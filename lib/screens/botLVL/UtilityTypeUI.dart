// utility_type_ui.dart
import 'package:finops/provider/botLVL/UtilityTypeProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:finops/widgets/ErrorDialog.dart';
import 'package:finops/widgets/CustomTextField.dart';
import 'package:finops/widgets/customButton.dart';
import 'package:finops/models/staticVar.dart';

class UtilityTypeUI extends StatefulWidget {
  const UtilityTypeUI({super.key});

  @override
  State<UtilityTypeUI> createState() => _UtilityTypeUIState();
}

class _UtilityTypeUIState extends State<UtilityTypeUI> {
  final DataGridController _dataGridController = DataGridController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Adaugă Tip Utilitate',
        backgroundColor: staticVar.themeColor,
        onPressed: () async {
          showUtilityTypeDialog(context);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Consumer<UtilityTypeProvider>(
        builder: (context, utilityTypeProvider, _) {
          // Check for errors and display the error dialog
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (utilityTypeProvider.errorMessage != null) {
              showDialog(
                context: context,
                builder: (context) => ErrorDialog(
                  errorMessage: utilityTypeProvider.errorMessage!,
                ),
              ).then((_) {
                utilityTypeProvider.clearError();
              });
            }
            if (utilityTypeProvider.successMessage != null) {
              Future.delayed(Duration.zero, () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      utilityTypeProvider.successMessage!,
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.greenAccent,
                  ),
                );
                utilityTypeProvider.clearSuccessMessage();
              });
            }
          });

          return !utilityTypeProvider.hasData
              ? staticVar.loading()
              : SfDataGrid(
            controller: _dataGridController,
            allowSorting: true,
            allowFiltering: true,
            columnWidthMode: ColumnWidthMode.fill,
            source: utilityTypeProvider.utilityTypeDataSource,
            columns: <GridColumn>[
              GridColumn(
                columnName: 'utilityType',
                label: Container(
                  alignment: Alignment.center,
                  child: Text('Tip Utilitate'),
                ),
              ),
              GridColumn(
                columnName: 'utilityTypeDescription',
                label: Container(
                  alignment: Alignment.center,
                  child: Text('Descriere Tip Utilitate'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

void showUtilityTypeDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AddUtilityTypeDialog(); // Dialog to add a new utility type
    },
  );
}

class AddUtilityTypeDialog extends StatefulWidget {
  @override
  State<AddUtilityTypeDialog> createState() => _AddUtilityTypeDialogState();
}

class _AddUtilityTypeDialogState extends State<AddUtilityTypeDialog> {
  TextEditingController utilityTypeController = TextEditingController();
  TextEditingController utilityTypeDescriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final utilityType = utilityTypeController.text.trim();
      final utilityTypeDescription = utilityTypeDescriptionController.text.trim();
      isLoading = true;
      setState(() {});
      Provider.of<UtilityTypeProvider>(context, listen: false)
          .addUtilityType({
        'utility_type': utilityType,
        'utility_type_description': utilityTypeDescription,
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
        height: staticVar.fullhigth(context) * .5,
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
                textEditingController: utilityTypeController,
                label: "Tip Utilitate",
                hint: 'Introduceți tipul utilității',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the utility type.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              CustomTextField(
                maxChar: 60,
                textEditingController: utilityTypeDescriptionController,
                label: "Descriere Tip Utilitate",
                hint: 'Introduceți descrierea tipului utilității',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the utility type description.';
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
