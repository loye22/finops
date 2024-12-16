// payment_status_ui.dart
import 'package:finops/provider/PaymentStatusProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:finops/widgets/ErrorDialog.dart';
import 'package:finops/widgets/CustomTextField.dart';
import 'package:finops/widgets/customButton.dart';
import 'package:finops/models/staticVar.dart';

class PaymentStatusUI extends StatefulWidget {
  const PaymentStatusUI({super.key});

  @override
  State<PaymentStatusUI> createState() => _PaymentStatusUIState();
}

class _PaymentStatusUIState extends State<PaymentStatusUI> {
  final DataGridController _dataGridController = DataGridController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Adaugă Status Plată',
        backgroundColor: staticVar.themeColor,
        onPressed: () async {
          showPaymentStatusDialog(context);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Consumer<PaymentStatusProvider>(
        builder: (context, paymentStatusProvider, _) {
          // Check for errors and display the error dialog
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (paymentStatusProvider.errorMessage != null) {
              showDialog(
                context: context,
                builder: (context) => ErrorDialog(
                  errorMessage: paymentStatusProvider.errorMessage!,
                ),
              ).then((_) {
                paymentStatusProvider.clearError();
              });
            }
            if (paymentStatusProvider.successMessage != null) {
              Future.delayed(Duration.zero, () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      paymentStatusProvider.successMessage!,
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.greenAccent,
                  ),
                );
                paymentStatusProvider.clearSuccessMessage();
              });
            }
          });

          return !paymentStatusProvider.hasData
              ? staticVar.loading()
              : SfDataGrid(
            controller: _dataGridController,
            allowSorting: true,
            allowFiltering: true,
            columnWidthMode: ColumnWidthMode.fill,
            source: paymentStatusProvider.paymentStatusDataSource,
            columns: <GridColumn>[
              GridColumn(
                columnName: 'paymentStatus',
                label: Container(
                  alignment: Alignment.center,
                  child: Text('Status Plată'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

void showPaymentStatusDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AddPaymentStatusDialog(); // Dialog to add a new payment status
    },
  );
}

class AddPaymentStatusDialog extends StatefulWidget {
  @override
  State<AddPaymentStatusDialog> createState() => _AddPaymentStatusDialogState();
}

class _AddPaymentStatusDialogState extends State<AddPaymentStatusDialog> {
  TextEditingController paymentStatusController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final paymentStatus = paymentStatusController.text.trim();
      isLoading = true;
      setState(() {});
      Provider.of<PaymentStatusProvider>(context, listen: false)
          .addPaymentStatus({
        'payment_status': paymentStatus,
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
                textEditingController: paymentStatusController,
                label: "Status Plată",
                hint: 'Introduceți statusul plății',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the payment status.';
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
