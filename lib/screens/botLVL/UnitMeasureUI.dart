// unit_measure_ui.dart
import 'package:finops/provider/UnitMeasureProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:finops/widgets/ErrorDialog.dart';
import 'package:finops/widgets/CustomTextField.dart';
import 'package:finops/widgets/customButton.dart';
import 'package:finops/models/staticVar.dart';

class UnitMeasureUI extends StatefulWidget {
  const UnitMeasureUI({super.key});

  @override
  State<UnitMeasureUI> createState() => _UnitMeasureUIState();
}

class _UnitMeasureUIState extends State<UnitMeasureUI> {
  final DataGridController _dataGridController = DataGridController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Adaugă Unitate de Măsură',
        backgroundColor: staticVar.themeColor,
        onPressed: () async {
          showUnitMeasureDialog(context);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Consumer<UnitMeasureProvider>(
        builder: (context, unitMeasureProvider, _) {
          // Check for errors and display the error dialog
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (unitMeasureProvider.errorMessage != null) {
              showDialog(
                context: context,
                builder: (context) => ErrorDialog(
                  errorMessage: unitMeasureProvider.errorMessage!,
                ),
              ).then((_) {
                unitMeasureProvider.clearError();
              });
            }
            if (unitMeasureProvider.successMessage != null) {
              Future.delayed(Duration.zero, () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      unitMeasureProvider.successMessage!,
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.greenAccent,
                  ),
                );
                unitMeasureProvider.clearSuccessMessage();
              });
            }
          });

          return !unitMeasureProvider.hasData
              ? staticVar.loading()
              : SfDataGrid(
            controller: _dataGridController,
            allowSorting: true,
            allowFiltering: true,
            columnWidthMode: ColumnWidthMode.fill,
            source: unitMeasureProvider.unitMeasureDataSource,
            columns: <GridColumn>[
              GridColumn(
                columnName: 'unitMeasure',
                label: Container(
                  alignment: Alignment.center,
                  child: Text('Unitate de Măsură'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

void showUnitMeasureDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AddUnitMeasureDialog(); // Dialog to add a new unit measure
    },
  );
}

class AddUnitMeasureDialog extends StatefulWidget {
  @override
  State<AddUnitMeasureDialog> createState() => _AddUnitMeasureDialogState();
}

class _AddUnitMeasureDialogState extends State<AddUnitMeasureDialog> {
  TextEditingController unitMeasureController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final unitMeasure = unitMeasureController.text.trim();
      isLoading = true;
      setState(() {});
      Provider.of<UnitMeasureProvider>(context, listen: false)
          .addUnitMeasure({
        'unit_measure': unitMeasure,
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
                textEditingController: unitMeasureController,
                label: "Unitate de Măsură",
                hint: 'Introduceți unitatea de măsură',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the unit measure.';
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
