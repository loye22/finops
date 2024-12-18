// document_class_ui.dart
import 'package:finops/provider/botLVL/DocumentClassProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:finops/widgets/ErrorDialog.dart';
import 'package:finops/widgets/CustomTextField.dart';
import 'package:finops/widgets/customButton.dart';
import 'package:finops/models/staticVar.dart';

class DocumentClassUI extends StatefulWidget {
  const DocumentClassUI({super.key});

  @override
  State<DocumentClassUI> createState() => _DocumentClassUIState();
}

class _DocumentClassUIState extends State<DocumentClassUI> {
  final DataGridController _dataGridController = DataGridController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Adaugă Clasă Document',
        backgroundColor: staticVar.themeColor,
        onPressed: () async {
          showDocumentClassDialog(context);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Consumer<DocumentClassProvider>(
        builder: (context, documentClassProvider, _) {
          // Check for errors and display the error dialog
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (documentClassProvider.errorMessage != null) {
              showDialog(
                context: context,
                builder: (context) => ErrorDialog(
                  errorMessage: documentClassProvider.errorMessage!,
                ),
              ).then((_) {
                documentClassProvider.clearError();
              });
            }
            if (documentClassProvider.successMessage != null) {
              Future.delayed(Duration.zero, () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      documentClassProvider.successMessage!,
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.greenAccent,
                  ),
                );
                documentClassProvider.clearSuccessMessage();
              });
            }
          });

          return !documentClassProvider.hasData
              ? staticVar.loading()
              : SfDataGrid(
            controller: _dataGridController,
            allowSorting: true,
            allowFiltering: true,
            columnWidthMode: ColumnWidthMode.fill,
            source: documentClassProvider.documentClassDataSource,
            columns: <GridColumn>[
              GridColumn(
                columnName: 'documentClass',
                label: Container(
                  alignment: Alignment.center,
                  child: Text('Clasă Document'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

void showDocumentClassDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AddDocumentClassDialog(); // Dialog to add a new document class
    },
  );
}

class AddDocumentClassDialog extends StatefulWidget {
  @override
  State<AddDocumentClassDialog> createState() => _AddDocumentClassDialogState();
}

class _AddDocumentClassDialogState extends State<AddDocumentClassDialog> {
  TextEditingController documentClassController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final documentClass = documentClassController.text.trim();
      isLoading = true;
      setState(() {});
      Provider.of<DocumentClassProvider>(context, listen: false)
          .addDocumentClass({
        'document_class': documentClass,
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
                textEditingController: documentClassController,
                label: "Clasă Document",
                hint: 'Introduceți numele clasei documentului',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the document class.';
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
