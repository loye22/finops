// vehicle_registration_number_ui.dart
import 'package:finops/provider/VehicleRegistrationNumberProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:finops/widgets/ErrorDialog.dart';
import 'package:finops/widgets/CustomTextField.dart';
import 'package:finops/widgets/customButton.dart';
import 'package:finops/models/staticVar.dart';

class VehicleRegistrationNumberUI extends StatefulWidget {
  const VehicleRegistrationNumberUI({super.key});

  @override
  State<VehicleRegistrationNumberUI> createState() =>
      _VehicleRegistrationNumberUIState();
}

class _VehicleRegistrationNumberUIState
    extends State<VehicleRegistrationNumberUI> {
  final DataGridController _dataGridController = DataGridController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Adaugă Număr Înregistrare Vehicul',
        backgroundColor: staticVar.themeColor,
        onPressed: () async {
          showVehicleRegistrationNumberDialog(context);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Consumer<VehicleRegistrationNumberProvider>(
        builder: (context, vehicleRegistrationProvider, _) {
          // Check for errors and display the error dialog
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (vehicleRegistrationProvider.errorMessage != null) {
              showDialog(
                context: context,
                builder: (context) => ErrorDialog(
                  errorMessage: vehicleRegistrationProvider.errorMessage!,
                ),
              ).then((_) {
                vehicleRegistrationProvider.clearError();
              });
            }
            if (vehicleRegistrationProvider.successMessage != null) {
              Future.delayed(Duration.zero, () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      vehicleRegistrationProvider.successMessage!,
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.greenAccent,
                  ),
                );
                vehicleRegistrationProvider.clearSuccessMessage();
              });
            }
          });

          return !vehicleRegistrationProvider.hasData
              ? staticVar.loading()
              : SfDataGrid(
            controller: _dataGridController,
            allowSorting: true,
            allowFiltering: true,
            columnWidthMode: ColumnWidthMode.fill,
            source: vehicleRegistrationProvider.vehicleRegistrationNumberDataSource,
            columns: <GridColumn>[
              GridColumn(
                columnName: 'vehicleRegistrationNumber',
                label: Container(
                  alignment: Alignment.center,
                  child: Text('Număr Înregistrare Vehicul'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

void showVehicleRegistrationNumberDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AddVehicleRegistrationNumberDialog();
    },
  );
}

class AddVehicleRegistrationNumberDialog extends StatefulWidget {
  @override
  State<AddVehicleRegistrationNumberDialog> createState() =>
      _AddVehicleRegistrationNumberDialogState();
}

class _AddVehicleRegistrationNumberDialogState
    extends State<AddVehicleRegistrationNumberDialog> {
  TextEditingController vehicleRegistrationNumberController =
  TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final vehicleRegistrationNumber =
      vehicleRegistrationNumberController.text.trim();
      isLoading = true;
      setState(() {});
      Provider.of<VehicleRegistrationNumberProvider>(context, listen: false)
          .addVehicleRegistrationNumber({
        'vehicle_registration_number': vehicleRegistrationNumber,
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
                numbersOnly: true,
                textEditingController: vehicleRegistrationNumberController,
                label: "Număr Înregistrare Vehicul",
                hint: 'Introduceți numărul de înregistrare al vehiculului',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the vehicle registration number.';
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
