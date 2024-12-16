// activity_type_ui.dart
import 'package:finops/provider/ActivityTypeProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:finops/widgets/ErrorDialog.dart';
import 'package:finops/widgets/CustomTextField.dart';
import 'package:finops/widgets/customButton.dart';
import 'package:finops/models/staticVar.dart';

class ActivityTypeUI extends StatefulWidget {
  const ActivityTypeUI({super.key});

  @override
  State<ActivityTypeUI> createState() => _ActivityTypeUIState();
}

class _ActivityTypeUIState extends State<ActivityTypeUI> {
  final DataGridController _dataGridController = DataGridController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Adaugă Tip Activitate',
        backgroundColor: staticVar.themeColor,
        onPressed: () async {
          showActivityTypeDialog(context);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Consumer<ActivityTypeProvider>(
        builder: (context, activityTypeProvider, _) {
          // Check for errors and display the error dialog
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (activityTypeProvider.errorMessage != null) {
              showDialog(
                context: context,
                builder: (context) => ErrorDialog(
                  errorMessage: activityTypeProvider.errorMessage!,
                ),
              ).then((_) {
                activityTypeProvider.clearError();
              });
            }
            if (activityTypeProvider.successMessage != null) {
              Future.delayed(Duration.zero, () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      activityTypeProvider.successMessage!,
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.greenAccent,
                  ),
                );
                activityTypeProvider.clearSuccessMessage();
              });
            }
          });

          return !activityTypeProvider.hasData
              ? staticVar.loading()
              : SfDataGrid(
            controller: _dataGridController,
            allowSorting: true,
            allowFiltering: true,
            columnWidthMode: ColumnWidthMode.fill,
            source: activityTypeProvider.activityTypeDataSource,
            columns: <GridColumn>[
              GridColumn(
                columnName: 'activityType',
                label: Container(
                  alignment: Alignment.center,
                  child: Text('Tip Activitate'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

void showActivityTypeDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AddActivityTypeDialog(); // Dialog to add a new activity type
    },
  );
}

class AddActivityTypeDialog extends StatefulWidget {
  @override
  State<AddActivityTypeDialog> createState() => _AddActivityTypeDialogState();
}

class _AddActivityTypeDialogState extends State<AddActivityTypeDialog> {
  TextEditingController activityTypeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final activityType = activityTypeController.text.trim();
      isLoading = true;
      setState(() {});
      Provider.of<ActivityTypeProvider>(context, listen: false)
          .addActivityType({
        'activity_type': activityType,
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
                textEditingController: activityTypeController,
                label: "Tip Activitate",
                hint: 'Introduceți tipul activității',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the activity type.';
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
