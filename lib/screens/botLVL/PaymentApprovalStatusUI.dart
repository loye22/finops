// payment_approval_status_ui.dart
import 'package:finops/provider/botLVL/PaymentApprovalStatusProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:finops/widgets/ErrorDialog.dart';
import 'package:finops/widgets/CustomTextField.dart';
import 'package:finops/widgets/customButton.dart';
import 'package:finops/models/staticVar.dart';

class PaymentApprovalStatusUI extends StatefulWidget {
  const PaymentApprovalStatusUI({super.key});

  @override
  State<PaymentApprovalStatusUI> createState() => _PaymentApprovalStatusUIState();
}

class _PaymentApprovalStatusUIState extends State<PaymentApprovalStatusUI> {
  final DataGridController _dataGridController = DataGridController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Adaugă Status Aprobare Plată',
        backgroundColor: staticVar.themeColor,
        onPressed: () async {
          showPaymentApprovalStatusDialog(context);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Consumer<PaymentApprovalStatusProvider>(
        builder: (context, paymentApprovalStatusProvider, _) {
          // Check for errors and display the error dialog
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (paymentApprovalStatusProvider.errorMessage != null) {
              showDialog(
                context: context,
                builder: (context) => ErrorDialog(
                  errorMessage: paymentApprovalStatusProvider.errorMessage!,
                ),
              ).then((_) {
                paymentApprovalStatusProvider.clearError();
              });
            }
            if (paymentApprovalStatusProvider.successMessage != null) {
              Future.delayed(Duration.zero, () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      paymentApprovalStatusProvider.successMessage!,
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.greenAccent,
                  ),
                );
                paymentApprovalStatusProvider.clearSuccessMessage();
              });
            }
          });

          return !paymentApprovalStatusProvider.hasData
              ? staticVar.loading()
              : SfDataGrid(
            controller: _dataGridController,
            allowSorting: true,
            allowFiltering: true,
            columnWidthMode: ColumnWidthMode.fill,
            source: paymentApprovalStatusProvider.paymentApprovalStatusDataSource,
            columns: <GridColumn>[
              GridColumn(
                columnName: 'paymentApprovalStatus',
                label: Container(
                  alignment: Alignment.center,
                  child: Text('Status Aprobare Plată'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

void showPaymentApprovalStatusDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AddPaymentApprovalStatusDialog(); // Dialog to add a new payment approval status
    },
  );
}

class AddPaymentApprovalStatusDialog extends StatefulWidget {
  @override
  State<AddPaymentApprovalStatusDialog> createState() =>
      _AddPaymentApprovalStatusDialogState();
}

class _AddPaymentApprovalStatusDialogState extends State<AddPaymentApprovalStatusDialog> {
  TextEditingController paymentApprovalStatusController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final paymentApprovalStatus = paymentApprovalStatusController.text.trim();
      isLoading = true;
      setState(() {});
      Provider.of<PaymentApprovalStatusProvider>(context, listen: false)
          .addPaymentApprovalStatus({
        'payment_approval_status': paymentApprovalStatus,
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
                textEditingController: paymentApprovalStatusController,
                label: "Status Aprobare Plată",
                hint: 'Introduceți statusul aprobării plății',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the payment approval status.';
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
