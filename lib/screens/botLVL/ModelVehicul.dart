// vehicle_model_ui.dart

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:finops/provider/botLVL/VehicleBrandProvider.dart';
import 'package:finops/provider/botLVL/VehicleModelProvider.dart';
import 'package:finops/screens/botLVL/VehicleBrandUI.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:finops/widgets/ErrorDialog.dart';
import 'package:finops/widgets/CustomTextField.dart';
import 'package:finops/widgets/CustomDropdown.dart';
import 'package:finops/widgets/customButton.dart';
import 'package:finops/models/staticVar.dart';

class VehicleModelUI extends StatefulWidget {
  const VehicleModelUI({super.key});

  @override
  State<VehicleModelUI> createState() => _VehicleModelUIState();
}

class _VehicleModelUIState extends State<VehicleModelUI> {
  final DataGridController _dataGridController = DataGridController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Adaugă Modelul Vehiculului',
        backgroundColor: staticVar.themeColor,
        onPressed: () async {
          showVehicleModelDialog(context);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Consumer<VehicleModelProvider>(
        builder: (context, vehicleModelProvider, _) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (vehicleModelProvider.errorMessage != null) {
              showDialog(
                context: context,
                builder: (context) => ErrorDialog(
                  errorMessage: vehicleModelProvider.errorMessage!,
                ),
              ).then((_) {
                vehicleModelProvider.clearError();
              });
            }
            if (vehicleModelProvider.successMessage != null) {
              Future.delayed(Duration.zero, () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      vehicleModelProvider.successMessage!,
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.greenAccent,
                  ),
                );
                vehicleModelProvider.clearSuccessMessage();
              });
            }
          });

          return !vehicleModelProvider.hasData
              ? staticVar.loading()
              : SfDataGrid(
                  controller: _dataGridController,
                  allowSorting: true,
                  allowFiltering: true,
                  columnWidthMode: ColumnWidthMode.fill,
                  source: vehicleModelProvider.vehicleModelDataSource,
                  columns: <GridColumn>[
                    GridColumn(
                      columnName: 'vehicleModel',
                      label: Container(
                        alignment: Alignment.center,
                        child: Text('Modelul Vehiculului'),
                      ),
                    ),
                    GridColumn(
                      columnName: 'vehicleBrand',
                      label: Container(
                        alignment: Alignment.center,
                        child: Text('Marca Vehiculului'),
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }
}

void showVehicleModelDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AddVehicleModelDialog();
    },
  );
}

class AddVehicleModelDialog extends StatefulWidget {
  @override
  State<AddVehicleModelDialog> createState() => _AddVehicleModelDialogState();
}

class _AddVehicleModelDialogState extends State<AddVehicleModelDialog> {
  TextEditingController vehicleModelController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  String? selectedVehicleBrand;
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  final GlobalKey<DropdownButton2State> dropdownKey = GlobalKey<DropdownButton2State>();



  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final vehicleModel = vehicleModelController.text.trim();
      final vehicleBrand = selectedVehicleBrand;

      if (vehicleBrand == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Selectați o marcă pentru vehicul.'),
            backgroundColor: Colors.redAccent,
          ),
        );
        return;
      }

      isLoading = true;
      setState(() {});
      Provider.of<VehicleModelProvider>(context, listen: false)
          .addVehicleModel({
        'vehicle_model': vehicleModel,
        'vehicle_brand': vehicleBrand,
      }).then((_) {
        isLoading = false;
        setState(() {});
        Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final vehicleBrandProvider = Provider.of<VehicleBrandProvider>(context);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Container(
        width: staticVar.fullWidth(context) * .4,
        height: staticVar.fullhigth(context) * .4,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: !vehicleBrandProvider.hasData
            ? staticVar.loading()
            : Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      textEditingController: vehicleModelController,
                      label: "Modelul Vehiculului",
                      hint: 'Introduceți modelul vehiculului',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Introduceți modelul vehiculului.';
                        }
                        return null;
                      },
                    ),
                    CustomDropdown(
                      items: vehicleBrandProvider.vehicleBrandList
                          .map((e) => e.vehicle_brand)
                          .toList(),
                      textEditingController: searchController,
                      hint: 'Selectați marca vehiculului',
                      lable: "Marca Vehiculului",
                      selectedValue: selectedVehicleBrand,
                      onChanged: (value) {
                        setState(() {
                          selectedVehicleBrand = value;
                        });
                      },
                      onAddNewItemPressed: ()  {
                        // Handle add new vehicle brand
                        showVehicleBrandDialog(context);



                      },
                    ),
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

  void showVehicleBrandDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return AddVehicleBrandDialog();
      },
    );
  }
}
