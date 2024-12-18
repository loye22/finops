// vehicle_year_ui.dart
import 'package:finops/provider/botLVL/VehicleYearProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:finops/widgets/ErrorDialog.dart';
import 'package:finops/widgets/CustomTextField.dart';
import 'package:finops/widgets/customButton.dart';
import 'package:finops/models/staticVar.dart';

class VehicleYearUI extends StatefulWidget {
  const VehicleYearUI({super.key});

  @override
  State<VehicleYearUI> createState() => _VehicleYearUIState();
}

class _VehicleYearUIState extends State<VehicleYearUI> {
  final DataGridController _dataGridController = DataGridController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Adaugă Anul Vehiculului',
        backgroundColor: staticVar.themeColor,
        onPressed: () async {
          showVehicleYearDialog(context);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Consumer<VehicleYearProvider>(
        builder: (context, vehicleYearProvider, _) {
          // Check for errors and display the error dialog
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (vehicleYearProvider.errorMessage != null) {
              showDialog(
                context: context,
                builder: (context) => ErrorDialog(
                  errorMessage: vehicleYearProvider.errorMessage!,
                ),
              ).then((_) {
                vehicleYearProvider.clearError();
              });
            }
            if (vehicleYearProvider.successMessage != null) {
              Future.delayed(Duration.zero, () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      vehicleYearProvider.successMessage!,
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.greenAccent,
                  ),
                );
                vehicleYearProvider.clearSuccessMessage();
              });
            }
          });

          return !vehicleYearProvider.hasData
              ? staticVar.loading()
              : SfDataGrid(
            controller: _dataGridController,
            allowSorting: true,
            allowFiltering: true,
            columnWidthMode: ColumnWidthMode.fill,
            source: vehicleYearProvider.vehicleYearDataSource,
            columns: <GridColumn>[
              GridColumn(
                columnName: 'vehicleYear',
                label: Container(
                  alignment: Alignment.center,
                  child: Text('Anul Vehiculului'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

void showVehicleYearDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AddVehicleYearDialog();
    },
  );
}

class AddVehicleYearDialog extends StatefulWidget {
  @override
  State<AddVehicleYearDialog> createState() => _AddVehicleYearDialogState();
}

class _AddVehicleYearDialogState extends State<AddVehicleYearDialog> {
  TextEditingController vehicleYearController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final vehicleYear = vehicleYearController.text.trim();
      isLoading = true;
      setState(() {});
      Provider.of<VehicleYearProvider>(context, listen: false)
          .addVehicleYear({
        'vehicle_year': vehicleYear,
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
                maxChar: 4,
                textEditingController: vehicleYearController,
                label: "Anul Vehiculului",
                hint: 'Introduceți anul vehiculului',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the vehicle year.';
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
