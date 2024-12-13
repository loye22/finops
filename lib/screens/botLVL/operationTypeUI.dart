import 'package:finops/models/staticVar.dart';
import 'package:finops/provider/OperationTypeProvider.dart';
import 'package:finops/widgets/CustomTextField.dart';
import 'package:finops/widgets/ErrorDialog.dart';
import 'package:finops/widgets/customButton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class operationTypeUI extends StatefulWidget {
  const operationTypeUI({super.key});

  @override
  State<operationTypeUI> createState() => _operationTypeUIState();
}

class _operationTypeUIState extends State<operationTypeUI> {
  final DataGridController _dataGridController = DataGridController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Adaugă Tip Operațiune',
        backgroundColor: staticVar.themeColor,
        onPressed: () async {
          showOperationTypeDialog(context);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Consumer<OperationTypeProvider>(
        builder: (context, operationTypeProvider, _) {
          // Check for errors and display the error dialog
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (operationTypeProvider.errorMessage != null) {
              showDialog(
                context: context,
                builder: (context) => ErrorDialog(
                  errorMessage: operationTypeProvider.errorMessage!,
                ),
              ).then((_) {
                operationTypeProvider
                    .clearError(); // Clear error after dialog dismissal
              });
            }
            if (operationTypeProvider.successMessage != null) {
              Future.delayed(Duration.zero, () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      operationTypeProvider.successMessage!,
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.greenAccent,
                  ),
                );
                operationTypeProvider
                    .clearSuccessMessage(); // Clear success message after showing it
              });
            }
          });

          return !operationTypeProvider.hasData
              ? staticVar.loading()
              : SfDataGrid(
                  controller: _dataGridController,
                  allowSorting: true,
                  allowFiltering: true,
                  columnWidthMode: ColumnWidthMode.fill,
                  source: operationTypeProvider.operationTypeDataSource,
                  columns: <GridColumn>[
                    GridColumn(
                      columnName: 'operationType',
                      label: Container(
                        alignment: Alignment.center,
                        child: Text('Tip Operațiune'),
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }
}

void showOperationTypeDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AddOperationDialog(); // Replace with actual implementation
    },
  );
}

class AddOperationDialog extends StatefulWidget {
  @override
  State<AddOperationDialog> createState() => _AddOperationDialogState();
}

class _AddOperationDialogState extends State<AddOperationDialog> {
  TextEditingController operationTypeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final operationTypeName = operationTypeController.text.trim();
      // Access the OperationTypeProvider to add the operation
      isLoading = true;
      setState(() {});
      Provider.of<OperationTypeProvider>(context, listen: false).addOperation({
        'operation_type': operationTypeName, // Pass the operation type name
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Creează un nou Tip de Operațiune",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                CustomTextField(
                  textEditingController: operationTypeController,
                  label: "Nume Tip de Operațiune",
                  hint: "Introduceți tipul de operațiune",
                ),
                SizedBox(height: 16),
                Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: this.isLoading
                            ? [staticVar.loading()]
                            :  [
                          CustomButton(
                            title: "Adaugă",
                            backgroundColor: staticVar.themeColor,
                            textColor: Colors.white,
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
      ),
    );
  }
}


