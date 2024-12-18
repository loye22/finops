// payment_method_ui.dart
import 'package:finops/provider/botLVL/PaymentMethodProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:finops/widgets/ErrorDialog.dart';
import 'package:finops/widgets/CustomTextField.dart';
import 'package:finops/widgets/customButton.dart';
import 'package:finops/models/staticVar.dart';

class PaymentMethodUI extends StatefulWidget {
  const PaymentMethodUI({super.key});

  @override
  State<PaymentMethodUI> createState() => _PaymentMethodUIState();
}

class _PaymentMethodUIState extends State<PaymentMethodUI> {
  final DataGridController _dataGridController = DataGridController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Adaugă Metodă de Plată',
        backgroundColor: staticVar.themeColor,
        onPressed: () async {
          showPaymentMethodDialog(context);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Consumer<PaymentMethodProvider>(
        builder: (context, paymentMethodProvider, _) {
          // Check for errors and display the error dialog
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (paymentMethodProvider.errorMessage != null) {
              showDialog(
                context: context,
                builder: (context) => ErrorDialog(
                  errorMessage: paymentMethodProvider.errorMessage!,
                ),
              ).then((_) {
                paymentMethodProvider.clearError();
              });
            }
            if (paymentMethodProvider.successMessage != null) {
              Future.delayed(Duration.zero, () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      paymentMethodProvider.successMessage!,
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.greenAccent,
                  ),
                );
                paymentMethodProvider.clearSuccessMessage();
              });
            }
          });

          return !paymentMethodProvider.hasData
              ? staticVar.loading()
              : SfDataGrid(
            controller: _dataGridController,
            allowSorting: true,
            allowFiltering: true,
            columnWidthMode: ColumnWidthMode.fill,
            source: paymentMethodProvider.paymentMethodDataSource,
            columns: <GridColumn>[
              GridColumn(
                columnName: 'paymentMethod',
                label: Container(
                  alignment: Alignment.center,
                  child: Text('Metodă de Plată'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

void showPaymentMethodDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AddPaymentMethodDialog(); // Dialog to add a new payment method
    },
  );
}

class AddPaymentMethodDialog extends StatefulWidget {
  @override
  State<AddPaymentMethodDialog> createState() => _AddPaymentMethodDialogState();
}

class _AddPaymentMethodDialogState extends State<AddPaymentMethodDialog> {
  TextEditingController paymentMethodController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final paymentMethod = paymentMethodController.text.trim();
      isLoading = true;
      setState(() {});
      Provider.of<PaymentMethodProvider>(context, listen: false)
          .addPaymentMethod({
        'payment_method': paymentMethod,
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
                textEditingController: paymentMethodController,
                label: "Metodă de Plată",
                hint: 'Introduceți metoda de plată',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the payment method.';
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
