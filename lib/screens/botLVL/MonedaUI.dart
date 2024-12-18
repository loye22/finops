import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:finops/widgets/ErrorDialog.dart';
import 'package:finops/widgets/CustomTextField.dart';
import 'package:finops/widgets/customButton.dart';
import 'package:finops/models/staticVar.dart';
import 'package:finops/provider/botLVL/MonedaProvider.dart';  // Make sure you import your provider

class MonedaUI extends StatefulWidget {
  const MonedaUI({super.key});

  @override
  State<MonedaUI> createState() => _MonedaUIState();
}

class _MonedaUIState extends State<MonedaUI> {
  final DataGridController _dataGridController = DataGridController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Adaugă Monedă',
        backgroundColor: staticVar.themeColor,
        onPressed: () async {
          showMonedaDialog(context);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Consumer<MonedaProvider>(
        builder: (context, monedaProvider, _) {
          // Check for errors and display the error dialog
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (monedaProvider.errorMessage != null) {
              showDialog(
                context: context,
                builder: (context) => ErrorDialog(
                  errorMessage: monedaProvider.errorMessage!,
                ),
              ).then((_) {
                monedaProvider.clearError();
              });
            }
            if (monedaProvider.successMessage != null) {
              Future.delayed(Duration.zero, () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      monedaProvider.successMessage!,
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.greenAccent,
                  ),
                );
                monedaProvider.clearSuccessMessage();
              });
            }
          });

          return !monedaProvider.hasData
              ? staticVar.loading()
              : SfDataGrid(
            controller: _dataGridController,
            allowSorting: true,
            allowFiltering: true,
            columnWidthMode: ColumnWidthMode.fill,
            source: monedaProvider.monedaDataSource,
            columns: <GridColumn>[
              GridColumn(
                columnName: 'moneda',
                label: Container(
                  alignment: Alignment.center,
                  child: Text('Moneda'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

void showMonedaDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AddMonedaDialog(); // Dialog to add a new moneda
    },
  );
}

class AddMonedaDialog extends StatefulWidget {
  @override
  State<AddMonedaDialog> createState() => _AddMonedaDialogState();
}

class _AddMonedaDialogState extends State<AddMonedaDialog> {
  TextEditingController monedaController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final monedaName = monedaController.text.trim();
      isLoading = true;
      setState(() {});
      Provider.of<MonedaProvider>(context, listen: false).addMoneda({
        'currency': monedaName,
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
                textEditingController: monedaController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the currency name.';
                  }
                  return null;
                },
                label: 'Nume Monedă',
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
