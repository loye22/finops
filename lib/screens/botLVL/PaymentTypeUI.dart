// payment_type_ui.dart
import 'package:finops/provider/PaymentTypeProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:finops/widgets/ErrorDialog.dart';
import 'package:finops/widgets/CustomTextField.dart';
import 'package:finops/widgets/customButton.dart';
import 'package:finops/models/staticVar.dart';

class PaymentTypeUI extends StatefulWidget {
  const PaymentTypeUI({super.key});

  @override
  State<PaymentTypeUI> createState() => _PaymentTypeUIState();
}

class _PaymentTypeUIState extends State<PaymentTypeUI> {
  final DataGridController _dataGridController = DataGridController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Adaugă Tipul de Plată',
        backgroundColor: staticVar.themeColor,
        onPressed: () async {
          showPaymentTypeDialog(context);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Consumer<PaymentTypeProvider>(
        builder: (context, paymentTypeProvider, _) {
          // Check for errors and display the error dialog
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (paymentTypeProvider.errorMessage != null) {
              showDialog(
                context: context,
                builder: (context) => ErrorDialog(
                  errorMessage: paymentTypeProvider.errorMessage!,
                ),
              ).then((_) {
                paymentTypeProvider.clearError();
              });
            }
            if (paymentTypeProvider.successMessage != null) {
              Future.delayed(Duration.zero, () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      paymentTypeProvider.successMessage!,
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.greenAccent,
                  ),
                );
                paymentTypeProvider.clearSuccessMessage();
              });
            }
          });

          return !paymentTypeProvider.hasData
              ? staticVar.loading()
              : SfDataGrid(
            controller: _dataGridController,
            allowSorting: true,
            allowFiltering: true,
            columnWidthMode: ColumnWidthMode.fill,
            source: paymentTypeProvider.paymentTypeDataSource,
            columns: <GridColumn>[
              GridColumn(
                columnName: 'paymentType',
                label: Container(
                  alignment: Alignment.center,
                  child: Text('Tipul de Plată'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

void showPaymentTypeDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AddPaymentTypeDialog(); // Dialog to add a new payment type
    },
  );
}

class AddPaymentTypeDialog extends StatefulWidget {
  @override
  State<AddPaymentTypeDialog> createState() => _AddPaymentTypeDialogState();
}

class _AddPaymentTypeDialogState extends State<AddPaymentTypeDialog> {
  TextEditingController paymentTypeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final paymentType = paymentTypeController.text.trim();
      isLoading = true;
      setState(() {});
      Provider.of<PaymentTypeProvider>(context, listen: false)
          .addPaymentType({
        'payment_type': paymentType,
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
                textEditingController: paymentTypeController,
                label: "Tipul de Plată",
                hint: 'Introduceți tipul de plată',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the payment type.';
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
