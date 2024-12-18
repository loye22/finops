// entity_ui.dart
import 'package:finops/provider/botLVL/EntityTypeProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:finops/widgets/ErrorDialog.dart';
import 'package:finops/widgets/CustomTextField.dart';
import 'package:finops/widgets/customButton.dart';
import 'package:finops/models/staticVar.dart';

class entityTypeUI extends StatefulWidget {
  const entityTypeUI({super.key});

  @override
  State<entityTypeUI> createState() => _entityTypeUIState();
}

class _entityTypeUIState extends State<entityTypeUI> {
  final DataGridController _dataGridController = DataGridController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Adaugă Tip Entitate',
        backgroundColor: staticVar.themeColor,
        onPressed: () async {
          showEntityTypeDialog(context);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Consumer<EntityTypeProvider>(
        builder: (context, entityTypeProvider, _) {
          // Check for errors and display the error dialog
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (entityTypeProvider.errorMessage != null) {
              showDialog(
                context: context,
                builder: (context) => ErrorDialog(
                  errorMessage: entityTypeProvider.errorMessage!,
                ),
              ).then((_) {
                entityTypeProvider.clearError();
              });
            }
            if (entityTypeProvider.successMessage != null) {
              Future.delayed(Duration.zero, () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      entityTypeProvider.successMessage!,
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.greenAccent,
                  ),
                );
                entityTypeProvider.clearSuccessMessage();
              });
            }
          });

          return !entityTypeProvider.hasData
              ? staticVar.loading()
              : SfDataGrid(
                  controller: _dataGridController,
                  allowSorting: true,
                  allowFiltering: true,
                  columnWidthMode: ColumnWidthMode.fill,
                  source: entityTypeProvider.entityTypeDataSource,
                  columns: <GridColumn>[
                    GridColumn(
                      columnName: 'entityType',
                      label: Container(
                        alignment: Alignment.center,
                        child: Text('Tip Entitate'),
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }
}

void showEntityTypeDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AddEntityTypeDialog(); // Dialog to add a new entity type
    },
  );
}

class AddEntityTypeDialog extends StatefulWidget {
  @override
  State<AddEntityTypeDialog> createState() => _AddEntityTypeDialogState();
}

class _AddEntityTypeDialogState extends State<AddEntityTypeDialog> {
  TextEditingController entityTypeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final entityTypeName = entityTypeController.text.trim();
      isLoading = true;
      setState(() {});
      Provider.of<EntityTypeProvider>(context, listen: false).addEntityType({
        'entity_type': entityTypeName,
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
                      textEditingController: entityTypeController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the entity type.';
                        }
                        return null;
                      },
                      label: 'Nume Tip Entitate',
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
