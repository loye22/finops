// document_ui.dart
import 'package:finops/provider/DocumentProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:finops/widgets/ErrorDialog.dart';
import 'package:finops/widgets/CustomTextField.dart';
import 'package:finops/widgets/customButton.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:finops/models/staticVar.dart';


class DocumentTypeUI extends StatefulWidget {
  const DocumentTypeUI({super.key});

  @override
  State<DocumentTypeUI> createState() => _DocumentTypeUIState();
}

class _DocumentTypeUIState extends State<DocumentTypeUI> {
  final DataGridController _dataGridController = DataGridController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Adaugă Tip Document',
        backgroundColor: staticVar.themeColor,
        onPressed: () async {
          showDocumentTypeDialog(context);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Consumer<DocumentProvider>(
        builder: (context, documentTypeProvider, _) {
          // Check for errors and display the error dialog
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (documentTypeProvider.errorMessage != null) {
              showDialog(
                context: context,
                builder: (context) => ErrorDialog(
                  errorMessage: documentTypeProvider.errorMessage!,
                ),
              ).then((_) {
                documentTypeProvider.clearError();
              });
            }
            if (documentTypeProvider.successMessage != null) {
              Future.delayed(Duration.zero, () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      documentTypeProvider.successMessage!,
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.greenAccent,
                  ),
                );
                documentTypeProvider.clearSuccessMessage();
              });
            }
          });

          return !documentTypeProvider.hasData
              ? staticVar.loading()
              : SfDataGrid(
            controller: _dataGridController,
            allowSorting: true,
            allowFiltering: true,
            columnWidthMode: ColumnWidthMode.fill,
            source: documentTypeProvider.documentDataSource,
            columns: <GridColumn>[
              GridColumn(
                columnName: 'documentType',
                label: Container(
                  alignment: Alignment.center,
                  child: Text('Tip Document'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

void showDocumentTypeDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AddDocumentTypeDialog(); // Dialog to add a new document type
    },
  );
}

class AddDocumentTypeDialog extends StatefulWidget {
  @override
  State<AddDocumentTypeDialog> createState() => _AddDocumentTypeDialogState();
}

class _AddDocumentTypeDialogState extends State<AddDocumentTypeDialog> {
  TextEditingController documentTypeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final documentTypeName = documentTypeController.text.trim();
      // Access the DocumentTypeProvider to add the document type
      isLoading = true;
      setState(() {});
      Provider.of<DocumentProvider>(context, listen: false).addDocument({
        'document_type': documentTypeName, // Pass the document type name
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
                    "Creează un nou Tip de Document",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                CustomTextField(
                  textEditingController: documentTypeController,
                  label: "Nume Tip de Document",
                  hint: "Introduceți tipul de document",
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: this.isLoading
                      ? [staticVar.loading()]
                      : [
                    CustomButton(
                      title: "Create",
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
