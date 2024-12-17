// insurance_type_ui.dart
import 'package:finops/provider/InsuranceTypeProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:finops/widgets/ErrorDialog.dart';
import 'package:finops/widgets/CustomTextField.dart';
import 'package:finops/widgets/customButton.dart';
import 'package:finops/models/staticVar.dart';

class InsuranceTypeUI extends StatefulWidget {
  const InsuranceTypeUI({super.key});

  @override
  State<InsuranceTypeUI> createState() => _InsuranceTypeUIState();
}

class _InsuranceTypeUIState extends State<InsuranceTypeUI> {
  final DataGridController _dataGridController = DataGridController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Adaugă Tip Asigurare',
        backgroundColor: staticVar.themeColor,
        onPressed: () async {
          showInsuranceTypeDialog(context);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Consumer<InsuranceTypeProvider>(
        builder: (context, insuranceTypeProvider, _) {
          // Check for errors and display the error dialog
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (insuranceTypeProvider.errorMessage != null) {
              showDialog(
                context: context,
                builder: (context) => ErrorDialog(
                  errorMessage: insuranceTypeProvider.errorMessage!,
                ),
              ).then((_) {
                insuranceTypeProvider.clearError();
              });
            }
            if (insuranceTypeProvider.successMessage != null) {
              Future.delayed(Duration.zero, () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      insuranceTypeProvider.successMessage!,
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.greenAccent,
                  ),
                );
                insuranceTypeProvider.clearSuccessMessage();
              });
            }
          });

          return !insuranceTypeProvider.hasData
              ? staticVar.loading()
              : SfDataGrid(
            controller: _dataGridController,
            allowSorting: true,
            allowFiltering: true,
            columnWidthMode: ColumnWidthMode.fill,
            source: insuranceTypeProvider.insuranceTypeDataSource,
            columns: <GridColumn>[
              GridColumn(
                columnName: 'insuranceType',
                label: Container(
                  alignment: Alignment.center,
                  child: Text('Tip Asigurare'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

void showInsuranceTypeDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AddInsuranceTypeDialog(); // Dialog to add a new insurance type
    },
  );
}

class AddInsuranceTypeDialog extends StatefulWidget {
  @override
  State<AddInsuranceTypeDialog> createState() =>
      _AddInsuranceTypeDialogState();
}

class _AddInsuranceTypeDialogState extends State<AddInsuranceTypeDialog> {
  TextEditingController insuranceTypeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final insuranceType = insuranceTypeController.text.trim();
      isLoading = true;
      setState(() {});
      Provider.of<InsuranceTypeProvider>(context, listen: false)
          .addInsuranceType({
        'insurance_type': insuranceType,
      }).then((_) {
        isLoading = false;
        setState(() {});
        // Close the dialog on success
        Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Container(
        width: staticVar.fullWidth(context) * .3,
        height: staticVar.fullhigth(context) * .3,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextField(
                textEditingController: insuranceTypeController,
                label: "Tip Asigurare",
                hint: 'Introduceți tipul asigurării',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the insurance type.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: this.isLoading
                    ? [staticVar.loading()]
                    : [
                  CustomButton(
                    backgroundColor: staticVar.themeColor,
                    textColor: Colors.white,
                    title: "Adaugă",
                    onPressed: _submitForm,
                  ),
                  SizedBox(width: 10),
                  CustomButton(
                    title: "Anula",
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
