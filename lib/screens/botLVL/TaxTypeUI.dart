// tax_type_ui.dart
import 'package:finops/provider/botLVL/TaxTypeProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:finops/widgets/ErrorDialog.dart';
import 'package:finops/widgets/CustomTextField.dart';
import 'package:finops/widgets/customButton.dart';
import 'package:finops/models/staticVar.dart';

class TaxTypeUI extends StatefulWidget {
  const TaxTypeUI({super.key});

  @override
  State<TaxTypeUI> createState() => _TaxTypeUIState();
}

class _TaxTypeUIState extends State<TaxTypeUI> {
  final DataGridController _dataGridController = DataGridController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Adaugă Tip Taxă',
        backgroundColor: staticVar.themeColor,
        onPressed: () async {
          showTaxTypeDialog(context);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Consumer<TaxTypeProvider>(
        builder: (context, taxTypeProvider, _) {
          // Check for errors and display the error dialog
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (taxTypeProvider.errorMessage != null) {
              showDialog(
                context: context,
                builder: (context) => ErrorDialog(
                  errorMessage: taxTypeProvider.errorMessage!,
                ),
              ).then((_) {
                taxTypeProvider.clearError();
              });
            }
            if (taxTypeProvider.successMessage != null) {
              Future.delayed(Duration.zero, () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      taxTypeProvider.successMessage!,
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.greenAccent,
                  ),
                );
                taxTypeProvider.clearSuccessMessage();
              });
            }
          });

          return !taxTypeProvider.hasData
              ? staticVar.loading()
              : SfDataGrid(
            controller: _dataGridController,
            allowSorting: true,
            allowFiltering: true,
            columnWidthMode: ColumnWidthMode.fill,
            source: taxTypeProvider.taxTypeDataSource,
            columns: <GridColumn>[
              GridColumn(
                columnName: 'taxType',
                label: Container(
                  alignment: Alignment.center,
                  child: Text('Tip Taxă'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

void showTaxTypeDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AddTaxTypeDialog(); // Dialog to add a new tax type
    },
  );
}

class AddTaxTypeDialog extends StatefulWidget {
  @override
  State<AddTaxTypeDialog> createState() => _AddTaxTypeDialogState();
}

class _AddTaxTypeDialogState extends State<AddTaxTypeDialog> {
  TextEditingController taxTypeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final taxType = taxTypeController.text.trim();
      isLoading = true;
      setState(() {});
      Provider.of<TaxTypeProvider>(context, listen: false).addTaxType({
        'tax_type': taxType,
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
                textEditingController: taxTypeController,
                label: "Tip Taxă",
                hint: 'Introduceți tipul taxei',
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter the tax type.';
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
