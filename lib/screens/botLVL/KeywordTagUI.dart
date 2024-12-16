// keyword_tag_ui.dart
import 'package:finops/provider/KeywordTagProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:finops/widgets/ErrorDialog.dart';
import 'package:finops/widgets/CustomTextField.dart';
import 'package:finops/widgets/customButton.dart';
import 'package:finops/models/staticVar.dart';

class KeywordTagUI extends StatefulWidget {
  const KeywordTagUI({super.key});

  @override
  State<KeywordTagUI> createState() => _KeywordTagUIState();
}

class _KeywordTagUIState extends State<KeywordTagUI> {
  final DataGridController _dataGridController = DataGridController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Adaugă Etichetă Cuvânt Cheie',
        backgroundColor: staticVar.themeColor,
        onPressed: () async {
          showKeywordTagDialog(context);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Consumer<KeywordTagProvider>(
        builder: (context, keywordTagProvider, _) {
          // Check for errors and display the error dialog
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (keywordTagProvider.errorMessage != null) {
              showDialog(
                context: context,
                builder: (context) => ErrorDialog(
                  errorMessage: keywordTagProvider.errorMessage!,
                ),
              ).then((_) {
                keywordTagProvider.clearError();
              });
            }
            if (keywordTagProvider.successMessage != null) {
              Future.delayed(Duration.zero, () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      keywordTagProvider.successMessage!,
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.greenAccent,
                  ),
                );
                keywordTagProvider.clearSuccessMessage();
              });
            }
          });

          return !keywordTagProvider.hasData
              ? staticVar.loading()
              : SfDataGrid(
            controller: _dataGridController,
            allowSorting: true,
            allowFiltering: true,
            columnWidthMode: ColumnWidthMode.fill,
            source: keywordTagProvider.keywordTagDataSource,
            columns: <GridColumn>[
              GridColumn(
                columnName: 'keywordTag',
                label: Container(
                  alignment: Alignment.center,
                  child: Text('Etichetă Cuvânt Cheie'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

void showKeywordTagDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AddKeywordTagDialog(); // Dialog to add a new keyword tag
    },
  );
}

class AddKeywordTagDialog extends StatefulWidget {
  @override
  State<AddKeywordTagDialog> createState() => _AddKeywordTagDialogState();
}

class _AddKeywordTagDialogState extends State<AddKeywordTagDialog> {
  TextEditingController keywordTagController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final keywordTag = keywordTagController.text.trim();
      isLoading = true;
      setState(() {});
      Provider.of<KeywordTagProvider>(context, listen: false)
          .addKeywordTag({
        'keyword_tag': keywordTag,
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
                textEditingController: keywordTagController,
                label: "Etichetă Cuvânt Cheie",
                hint: 'Introduceți eticheta cuvântului cheie',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the keyword tag.';
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