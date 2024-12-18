import 'package:finops/provider/botLVL/VacationTypeProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:finops/widgets/ErrorDialog.dart';
import 'package:finops/widgets/CustomTextField.dart';
import 'package:finops/widgets/customButton.dart';
import 'package:finops/models/staticVar.dart';

class VacantionTypeUI extends StatefulWidget {
  const VacantionTypeUI({super.key});

  @override
  State<VacantionTypeUI> createState() => _VacantionTypeUIState();
}

class _VacantionTypeUIState extends State<VacantionTypeUI> {
  final DataGridController _dataGridController = DataGridController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Adaugă Tip Vacanță',
        backgroundColor: staticVar.themeColor,
        onPressed: () async {
          showVacantionTypeDialog(context);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Consumer<VacationTypeProvider>(
        builder: (context, vacantionTypeProvider, _) {
          // Check for errors and display the error dialog
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (vacantionTypeProvider.errorMessage != null) {
              showDialog(
                context: context,
                builder: (context) => ErrorDialog(
                  errorMessage: vacantionTypeProvider.errorMessage!,
                ),
              ).then((_) {
                vacantionTypeProvider.clearError();
              });
            }
            if (vacantionTypeProvider.successMessage != null) {
              Future.delayed(Duration.zero, () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      vacantionTypeProvider.successMessage!,
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.greenAccent,
                  ),
                );
                vacantionTypeProvider.clearSuccessMessage();
              });
            }
          });

          return !vacantionTypeProvider.hasData
              ? staticVar.loading()
              : SfDataGrid(
                  controller: _dataGridController,
                  allowSorting: true,
                  allowFiltering: true,
                  columnWidthMode: ColumnWidthMode.fill,
                  source: vacantionTypeProvider.vacationTypeDataSource,
                  columns: <GridColumn>[
                    GridColumn(
                      columnName: 'vacantionType',
                      label: Container(
                        alignment: Alignment.center,
                        child: Text('Tip Vacanță'),
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }
}

void showVacantionTypeDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AddVacantionTypeDialog(); // Dialog to add a new vacation type
    },
  );
}

class AddVacantionTypeDialog extends StatefulWidget {
  @override
  State<AddVacantionTypeDialog> createState() => _AddVacantionTypeDialogState();
}

class _AddVacantionTypeDialogState extends State<AddVacantionTypeDialog> {
  TextEditingController vacantionTypeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final vacantionType = vacantionTypeController.text.trim();
      isLoading = true;
      setState(() {});
      Provider.of<VacationTypeProvider>(context, listen: false)
          .addVacationType({
        'vacantion_type': vacantionType,
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
                textEditingController: vacantionTypeController,
                label: "Tip Vacanță",
                hint: 'Introduceți tipul de vacanță',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the vacation type.';
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
