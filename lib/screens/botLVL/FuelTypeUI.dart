// fuel_type_ui.dart
import 'package:finops/provider/botLVL/FuelTypeProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:finops/widgets/ErrorDialog.dart';
import 'package:finops/widgets/CustomTextField.dart';
import 'package:finops/widgets/customButton.dart';
import 'package:finops/models/staticVar.dart';

class FuelTypeUI extends StatefulWidget {
  const FuelTypeUI({super.key});

  @override
  State<FuelTypeUI> createState() => _FuelTypeUIState();
}

class _FuelTypeUIState extends State<FuelTypeUI> {
  final DataGridController _dataGridController = DataGridController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Adaugă Tipul Combustibilului',
        backgroundColor: staticVar.themeColor,
        onPressed: () async {
          showFuelTypeDialog(context);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Consumer<FuelTypeProvider>(
        builder: (context, fuelTypeProvider, _) {
          // Check for errors and display the error dialog
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (fuelTypeProvider.errorMessage != null) {
              showDialog(
                context: context,
                builder: (context) => ErrorDialog(
                  errorMessage: fuelTypeProvider.errorMessage!,
                ),
              ).then((_) {
                fuelTypeProvider.clearError();
              });
            }
            if (fuelTypeProvider.successMessage != null) {
              Future.delayed(Duration.zero, () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      fuelTypeProvider.successMessage!,
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.greenAccent,
                  ),
                );
                fuelTypeProvider.clearSuccessMessage();
              });
            }
          });

          return !fuelTypeProvider.hasData
              ? staticVar.loading()
              : SfDataGrid(
            controller: _dataGridController,
            allowSorting: true,
            allowFiltering: true,
            columnWidthMode: ColumnWidthMode.fill,
            source: fuelTypeProvider.fuelTypeDataSource,
            columns: <GridColumn>[
              GridColumn(
                columnName: 'fuelType',
                label: Container(
                  alignment: Alignment.center,
                  child: Text('Tipul Combustibilului'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

void showFuelTypeDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AddFuelTypeDialog();
    },
  );
}

class AddFuelTypeDialog extends StatefulWidget {
  @override
  State<AddFuelTypeDialog> createState() => _AddFuelTypeDialogState();
}

class _AddFuelTypeDialogState extends State<AddFuelTypeDialog> {
  TextEditingController fuelTypeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final fuelType = fuelTypeController.text.trim();
      isLoading = true;
      setState(() {});
      Provider.of<FuelTypeProvider>(context, listen: false)
          .addFuelType({
        'fuel_type': fuelType,
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
                textEditingController: fuelTypeController,
                label: "Tipul Combustibilului",
                hint: 'Introduceți tipul combustibilului',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the fuel type.';
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
