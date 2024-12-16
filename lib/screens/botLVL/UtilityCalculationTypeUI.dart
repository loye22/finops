// utility_calculation_type_ui.dart
import 'package:finops/provider/UtilityCalculationTypeProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:finops/widgets/ErrorDialog.dart';
import 'package:finops/widgets/CustomTextField.dart';
import 'package:finops/widgets/customButton.dart';
import 'package:finops/models/staticVar.dart';

class UtilityCalculationTypeUI extends StatefulWidget {
  const UtilityCalculationTypeUI({super.key});

  @override
  State<UtilityCalculationTypeUI> createState() => _UtilityCalculationTypeUIState();
}

class _UtilityCalculationTypeUIState extends State<UtilityCalculationTypeUI> {
  final DataGridController _dataGridController = DataGridController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Adaugă Tip Calcul Utilitate',
        backgroundColor: staticVar.themeColor,
        onPressed: () async {
          showUtilityCalculationTypeDialog(context);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Consumer<UtilityCalculationTypeProvider>(
        builder: (context, utilityCalculationTypeProvider, _) {
          // Check for errors and display the error dialog
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (utilityCalculationTypeProvider.errorMessage != null) {
              showDialog(
                context: context,
                builder: (context) => ErrorDialog(
                  errorMessage: utilityCalculationTypeProvider.errorMessage!,
                ),
              ).then((_) {
                utilityCalculationTypeProvider.clearError();
              });
            }
            if (utilityCalculationTypeProvider.successMessage != null) {
              Future.delayed(Duration.zero, () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      utilityCalculationTypeProvider.successMessage!,
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.greenAccent,
                  ),
                );
                utilityCalculationTypeProvider.clearSuccessMessage();
              });
            }
          });

          return !utilityCalculationTypeProvider.hasData
              ? staticVar.loading()
              : SfDataGrid(
            controller: _dataGridController,
            allowSorting: true,
            allowFiltering: true,
            columnWidthMode: ColumnWidthMode.fill,
            source: utilityCalculationTypeProvider.utilityCalculationTypeDataSource,
            columns: <GridColumn>[
              GridColumn(
                columnName: 'utilityCalculationType',
                label: Container(
                  alignment: Alignment.center,
                  child: Text('Tip Calcul Utilitate'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

void showUtilityCalculationTypeDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AddUtilityCalculationTypeDialog(); // Dialog to add a new utility calculation type
    },
  );
}

class AddUtilityCalculationTypeDialog extends StatefulWidget {
  @override
  State<AddUtilityCalculationTypeDialog> createState() => _AddUtilityCalculationTypeDialogState();
}

class _AddUtilityCalculationTypeDialogState extends State<AddUtilityCalculationTypeDialog> {
  TextEditingController utilityCalculationTypeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final utilityCalculationType = utilityCalculationTypeController.text.trim();
      isLoading = true;
      setState(() {});
      Provider.of<UtilityCalculationTypeProvider>(context, listen: false)
          .addUtilityCalculationType({
        'utility_calculation_type': utilityCalculationType,
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
                textEditingController: utilityCalculationTypeController,
                label: "Tip Calcul Utilitate",
                hint: 'Introduceți tipul de calcul utilitate',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the utility calculation type.';
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
