// real_estate_type_ui.dart
import 'package:finops/provider/RealEstateTypeProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:finops/widgets/ErrorDialog.dart';
import 'package:finops/widgets/CustomTextField.dart';
import 'package:finops/widgets/customButton.dart';
import 'package:finops/models/staticVar.dart';

class RealEstateTypeUI extends StatefulWidget {
  const RealEstateTypeUI({super.key});

  @override
  State<RealEstateTypeUI> createState() => _RealEstateTypeUIState();
}

class _RealEstateTypeUIState extends State<RealEstateTypeUI> {
  final DataGridController _dataGridController = DataGridController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Adaugă Tip Imobil',
        backgroundColor: staticVar.themeColor,
        onPressed: () async {
          showRealEstateTypeDialog(context);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Consumer<RealEstateTypeProvider>(
        builder: (context, realEstateTypeProvider, _) {
          // Check for errors and display the error dialog
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (realEstateTypeProvider.errorMessage != null) {
              showDialog(
                context: context,
                builder: (context) => ErrorDialog(
                  errorMessage: realEstateTypeProvider.errorMessage!,
                ),
              ).then((_) {
                realEstateTypeProvider.clearError();
              });
            }
            if (realEstateTypeProvider.successMessage != null) {
              Future.delayed(Duration.zero, () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      realEstateTypeProvider.successMessage!,
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.greenAccent,
                  ),
                );
                realEstateTypeProvider.clearSuccessMessage();
              });
            }
          });

          return !realEstateTypeProvider.hasData
              ? staticVar.loading()
              : SfDataGrid(
            controller: _dataGridController,
            allowSorting: true,
            allowFiltering: true,
            columnWidthMode: ColumnWidthMode.fill,
            source: realEstateTypeProvider.realEstateTypeDataSource,
            columns: <GridColumn>[
              GridColumn(
                columnName: 'realEstateType',
                label: Container(
                  alignment: Alignment.center,
                  child: Text('Tip Imobil'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

void showRealEstateTypeDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AddRealEstateTypeDialog(); // Dialog to add a new real estate type
    },
  );
}

class AddRealEstateTypeDialog extends StatefulWidget {
  @override
  State<AddRealEstateTypeDialog> createState() => _AddRealEstateTypeDialogState();
}

class _AddRealEstateTypeDialogState extends State<AddRealEstateTypeDialog> {
  TextEditingController realEstateTypeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final realEstateType = realEstateTypeController.text.trim();
      isLoading = true;
      setState(() {});
      Provider.of<RealEstateTypeProvider>(context, listen: false)
          .addRealEstateType({
        'real_estate_type': realEstateType,
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
                textEditingController: realEstateTypeController,
                label: "Tip Imobil",
                hint: 'Introduceți tipul imobilului',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the real estate type.';
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
