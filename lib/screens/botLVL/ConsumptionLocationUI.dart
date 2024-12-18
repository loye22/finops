// consumption_location_ui.dart
import 'package:finops/provider/botLVL/ConsumptionLocationProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:finops/widgets/ErrorDialog.dart';
import 'package:finops/widgets/CustomTextField.dart';
import 'package:finops/widgets/customButton.dart';
import 'package:finops/models/staticVar.dart';

class ConsumptionLocationUI extends StatefulWidget {
  const ConsumptionLocationUI({super.key});

  @override
  State<ConsumptionLocationUI> createState() => _ConsumptionLocationUIState();
}

class _ConsumptionLocationUIState extends State<ConsumptionLocationUI> {
  final DataGridController _dataGridController = DataGridController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Adaugă Locație Consum',
        backgroundColor: staticVar.themeColor,
        onPressed: () async {
          showConsumptionLocationDialog(context);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Consumer<ConsumptionLocationProvider>(
        builder: (context, consumptionLocationProvider, _) {
          // Check for errors and display the error dialog
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (consumptionLocationProvider.errorMessage != null) {
              showDialog(
                context: context,
                builder: (context) => ErrorDialog(
                  errorMessage: consumptionLocationProvider.errorMessage!,
                ),
              ).then((_) {
                consumptionLocationProvider.clearError();
              });
            }
            if (consumptionLocationProvider.successMessage != null) {
              Future.delayed(Duration.zero, () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      consumptionLocationProvider.successMessage!,
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.greenAccent,
                  ),
                );
                consumptionLocationProvider.clearSuccessMessage();
              });
            }
          });

          return !consumptionLocationProvider.hasData
              ? staticVar.loading()
              : SfDataGrid(
            controller: _dataGridController,
            allowSorting: true,
            allowFiltering: true,
            columnWidthMode: ColumnWidthMode.fill,
            source: consumptionLocationProvider.consumptionLocationDataSource,
            columns: <GridColumn>[
              GridColumn(
                columnName: 'consumptionLocation',
                label: Container(
                  alignment: Alignment.center,
                  child: Text('Locație Consum'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

void showConsumptionLocationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AddConsumptionLocationDialog(); // Dialog to add a new consumption location
    },
  );
}

class AddConsumptionLocationDialog extends StatefulWidget {
  @override
  State<AddConsumptionLocationDialog> createState() => _AddConsumptionLocationDialogState();
}

class _AddConsumptionLocationDialogState extends State<AddConsumptionLocationDialog> {
  TextEditingController consumptionLocationController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final consumptionLocation = consumptionLocationController.text.trim();
      isLoading = true;
      setState(() {});
      Provider.of<ConsumptionLocationProvider>(context, listen: false)
          .addConsumptionLocation({
        'consumption_location': consumptionLocation,
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
                textEditingController: consumptionLocationController,
                label: "Locație Consum",
                hint: 'Introduceți locația consumului',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the consumption location.';
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
