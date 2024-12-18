// brand_tag_ui.dart
import 'package:finops/provider/botLVL/BrandTagProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:finops/widgets/ErrorDialog.dart';
import 'package:finops/widgets/CustomTextField.dart';
import 'package:finops/widgets/customButton.dart';
import 'package:finops/models/staticVar.dart';

class BrandTagUI extends StatefulWidget {
  const BrandTagUI({super.key});

  @override
  State<BrandTagUI> createState() => _BrandTagUIState();
}

class _BrandTagUIState extends State<BrandTagUI> {
  final DataGridController _dataGridController = DataGridController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Adaugă Etichetă Brand',
        backgroundColor: staticVar.themeColor,
        onPressed: () async {
          showBrandTagDialog(context);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Consumer<BrandTagProvider>(
        builder: (context, brandTagProvider, _) {
          // Check for errors and display the error dialog
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (brandTagProvider.errorMessage != null) {
              showDialog(
                context: context,
                builder: (context) => ErrorDialog(
                  errorMessage: brandTagProvider.errorMessage!,
                ),
              ).then((_) {
                brandTagProvider.clearError();
              });
            }
            if (brandTagProvider.successMessage != null) {
              Future.delayed(Duration.zero, () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      brandTagProvider.successMessage!,
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.greenAccent,
                  ),
                );
                brandTagProvider.clearSuccessMessage();
              });
            }
          });

          return !brandTagProvider.hasData
              ? staticVar.loading()
              : SfDataGrid(
            controller: _dataGridController,
            allowSorting: true,
            allowFiltering: true,
            columnWidthMode: ColumnWidthMode.fill,
            source: brandTagProvider.brandTagDataSource,
            columns: <GridColumn>[
              GridColumn(
                columnName: 'brandTag',
                label: Container(
                  alignment: Alignment.center,
                  child: Text('Etichetă Brand'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

void showBrandTagDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AddBrandTagDialog(); // Dialog to add a new brand tag
    },
  );
}

class AddBrandTagDialog extends StatefulWidget {
  @override
  State<AddBrandTagDialog> createState() => _AddBrandTagDialogState();
}

class _AddBrandTagDialogState extends State<AddBrandTagDialog> {
  TextEditingController brandTagController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final brandTag = brandTagController.text.trim();
      isLoading = true;
      setState(() {});
      Provider.of<BrandTagProvider>(context, listen: false)
          .addBrandTag({
        'brand_tag': brandTag,
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
                textEditingController: brandTagController,
                label: "Etichetă Brand",
                hint: 'Introduceți eticheta brandului',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the brand tag.';
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
