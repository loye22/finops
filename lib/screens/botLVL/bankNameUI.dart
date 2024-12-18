// bank_ui.dart
import 'package:finops/provider/botLVL/BankNameProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:finops/widgets/ErrorDialog.dart';
import 'package:finops/widgets/CustomTextField.dart';
import 'package:finops/widgets/customButton.dart';
import 'package:finops/models/staticVar.dart';

class bankNameUI extends StatefulWidget {
  const bankNameUI({super.key});

  @override
  State<bankNameUI> createState() => _bankNameUIState();
}

class _bankNameUIState extends State<bankNameUI> {
  final DataGridController _dataGridController = DataGridController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Adaugă Banca',
        backgroundColor: staticVar.themeColor,
        onPressed: () async {
          showBankNameDialog(context);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Consumer<BankNameProvider>(
        builder: (context, bankNameProvider, _) {
          // Check for errors and display the error dialog
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (bankNameProvider.errorMessage != null) {
              showDialog(
                context: context,
                builder: (context) => ErrorDialog(
                  errorMessage: bankNameProvider.errorMessage!,
                ),
              ).then((_) {
                bankNameProvider.clearError();
              });
            }
            if (bankNameProvider.successMessage != null) {
              Future.delayed(Duration.zero, () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      bankNameProvider.successMessage!,
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.greenAccent,
                  ),
                );
                bankNameProvider.clearSuccessMessage();
              });
            }
          });

          return !bankNameProvider.hasData
              ? staticVar.loading()
              : SfDataGrid(
                  controller: _dataGridController,
                  allowSorting: true,
                  allowFiltering: true,
                  columnWidthMode: ColumnWidthMode.fill,
                  source: bankNameProvider.bankNameDataSource,
                  columns: <GridColumn>[
                    GridColumn(
                      columnName: 'bankName',
                      label: Container(
                        alignment: Alignment.center,
                        child: Text('Nume Banca'),
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }
}

void showBankNameDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AddBankNameDialog(); // Dialog to add a new bank name
    },
  );
}

class AddBankNameDialog extends StatefulWidget {
  @override
  State<AddBankNameDialog> createState() => _AddBankNameDialogState();
}

class _AddBankNameDialogState extends State<AddBankNameDialog> {
  TextEditingController bankNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final bankName = bankNameController.text.trim();
      isLoading = true;
      setState(() {});
      Provider.of<BankNameProvider>(context, listen: false).addBankName({
        'bank_name': bankName,
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
                textEditingController: bankNameController,
                label: "Nume Banca",
                hint: 'Introduceți numele băncii',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the bank name.';
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
