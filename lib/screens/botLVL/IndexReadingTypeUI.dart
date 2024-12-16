// index_reading_type_ui.dart
import 'package:finops/provider/IndexReadingTypeProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:finops/widgets/ErrorDialog.dart';
import 'package:finops/widgets/CustomTextField.dart';
import 'package:finops/widgets/customButton.dart';
import 'package:finops/models/staticVar.dart';

class IndexReadingTypeUI extends StatefulWidget {
  const IndexReadingTypeUI({super.key});

  @override
  State<IndexReadingTypeUI> createState() => _IndexReadingTypeUIState();
}

class _IndexReadingTypeUIState extends State<IndexReadingTypeUI> {
  final DataGridController _dataGridController = DataGridController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Adaugă Tip Citire Index',
        backgroundColor: staticVar.themeColor,
        onPressed: () async {
          showIndexReadingTypeDialog(context);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Consumer<IndexReadingTypeProvider>(
        builder: (context, indexReadingTypeProvider, _) {
          // Check for errors and display the error dialog
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (indexReadingTypeProvider.errorMessage != null) {
              showDialog(
                context: context,
                builder: (context) => ErrorDialog(
                  errorMessage: indexReadingTypeProvider.errorMessage!,
                ),
              ).then((_) {
                indexReadingTypeProvider.clearError();
              });
            }
            if (indexReadingTypeProvider.successMessage != null) {
              Future.delayed(Duration.zero, () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      indexReadingTypeProvider.successMessage!,
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.greenAccent,
                  ),
                );
                indexReadingTypeProvider.clearSuccessMessage();
              });
            }
          });

          return !indexReadingTypeProvider.hasData
              ? staticVar.loading()
              : SfDataGrid(
            controller: _dataGridController,
            allowSorting: true,
            allowFiltering: true,
            columnWidthMode: ColumnWidthMode.fill,
            source: indexReadingTypeProvider.indexReadingTypeDataSource,
            columns: <GridColumn>[
              GridColumn(
                columnName: 'indexReadingType',
                label: Container(
                  alignment: Alignment.center,
                  child: Text('Tip Citire Index'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

void showIndexReadingTypeDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AddIndexReadingTypeDialog(); // Dialog to add a new index reading type
    },
  );
}

class AddIndexReadingTypeDialog extends StatefulWidget {
  @override
  State<AddIndexReadingTypeDialog> createState() => _AddIndexReadingTypeDialogState();
}

class _AddIndexReadingTypeDialogState extends State<AddIndexReadingTypeDialog> {
  TextEditingController indexReadingTypeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final indexReadingType = indexReadingTypeController.text.trim();
      isLoading = true;
      setState(() {});
      Provider.of<IndexReadingTypeProvider>(context, listen: false)
          .addIndexReadingType({
        'index_reading_type': indexReadingType,
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
                textEditingController: indexReadingTypeController,
                label: "Tip Citire Index",
                hint: 'Introduceți tipul de citire a indexului',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the index reading type.';
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
