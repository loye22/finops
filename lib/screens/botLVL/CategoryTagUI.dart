// category_tag_ui.dart
import 'package:finops/provider/botLVL/CategoryTagProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:finops/widgets/ErrorDialog.dart';
import 'package:finops/widgets/CustomTextField.dart';
import 'package:finops/widgets/customButton.dart';
import 'package:finops/models/staticVar.dart';

class CategoryTagUI extends StatefulWidget {
  const CategoryTagUI({super.key});

  @override
  State<CategoryTagUI> createState() => _CategoryTagUIState();
}

class _CategoryTagUIState extends State<CategoryTagUI> {
  final DataGridController _dataGridController = DataGridController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Adaugă Etichetă Categorie',
        backgroundColor: staticVar.themeColor,
        onPressed: () async {
          showCategoryTagDialog(context);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Consumer<CategoryTagProvider>(
        builder: (context, categoryTagProvider, _) {
          // Check for errors and display the error dialog
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (categoryTagProvider.errorMessage != null) {
              showDialog(
                context: context,
                builder: (context) => ErrorDialog(
                  errorMessage: categoryTagProvider.errorMessage!,
                ),
              ).then((_) {
                categoryTagProvider.clearError();
              });
            }
            if (categoryTagProvider.successMessage != null) {
              Future.delayed(Duration.zero, () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      categoryTagProvider.successMessage!,
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.greenAccent,
                  ),
                );
                categoryTagProvider.clearSuccessMessage();
              });
            }
          });

          return !categoryTagProvider.hasData
              ? staticVar.loading()
              : SfDataGrid(
            controller: _dataGridController,
            allowSorting: true,
            allowFiltering: true,
            columnWidthMode: ColumnWidthMode.fill,
            source: categoryTagProvider.categoryTagDataSource,
            columns: <GridColumn>[
              GridColumn(
                columnName: 'categoryTag',
                label: Container(
                  alignment: Alignment.center,
                  child: Text('Etichetă Categorie'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

void showCategoryTagDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AddCategoryTagDialog(); // Dialog to add a new category tag
    },
  );
}

class AddCategoryTagDialog extends StatefulWidget {
  @override
  State<AddCategoryTagDialog> createState() => _AddCategoryTagDialogState();
}

class _AddCategoryTagDialogState extends State<AddCategoryTagDialog> {
  TextEditingController categoryTagController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final categoryTag = categoryTagController.text.trim();
      isLoading = true;
      setState(() {});
      Provider.of<CategoryTagProvider>(context, listen: false)
          .addCategoryTag({
        'category_tag': categoryTag,
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
                textEditingController: categoryTagController,
                label: "Etichetă Categorie",
                hint: 'Introduceți eticheta categoriei',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the category tag.';
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
