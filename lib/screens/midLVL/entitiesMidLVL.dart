import 'package:finops/models/midLVL/EntityDataModel/transactionTabDataModel.dart';
import 'package:finops/models/staticVar.dart';
import 'package:finops/provider/midLVL/EntityDataProvider.dart';
import 'package:finops/widgets/CustomDropdown.dart';
import 'package:finops/widgets/CustomTextField.dart';
import 'package:finops/widgets/EntityInfoCard.dart';
import 'package:finops/widgets/ErrorDialog.dart';
import 'package:finops/widgets/customButton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class entitiesMidLVL extends StatefulWidget {
  const entitiesMidLVL({super.key});

  @override
  State<entitiesMidLVL> createState() => _entitiesMidLVLState();
}

class _entitiesMidLVLState extends State<entitiesMidLVL> {
  final DataGridController _dataGridController = DataGridController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Adaugă Entitate',
        backgroundColor: staticVar.themeColor,
        onPressed: () async {
          showEntityDialog(context);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Row(
        children: [
          Container(
            width: staticVar.fullWidth(context) * .55,
            child: Consumer<EntityProvider>(
              builder: (context, entityProvider, _) {
                // Check for errors and display the error dialog
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (entityProvider.errorMessage != null) {
                    showDialog(
                      context: context,
                      builder: (context) => ErrorDialog(
                        errorMessage: entityProvider.errorMessage!,
                      ),
                    ).then((_) {
                      entityProvider.clearError();
                    });
                  }
                  if (entityProvider.successMessage != null) {
                    Future.delayed(Duration.zero, () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            entityProvider.successMessage!,
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.greenAccent,
                        ),
                      );
                      entityProvider.clearSuccessMessage();
                    });
                  }
                });

                return !entityProvider.hasData
                    ? staticVar.loading()
                    : SfDataGrid(
                        controller: _dataGridController,
                        allowSorting: true,
                        allowFiltering: true,
                        columnWidthMode: ColumnWidthMode.fill,
                        source: entityProvider.entityDataSource,
                        columns: <GridColumn>[
                          GridColumn(
                            columnName: 'denumireEntitate',
                            label: Container(
                              alignment: Alignment.center,
                              child: Text('Denumire Entitate'),
                            ),
                          ),
                          GridColumn(
                            columnName: 'cui',
                            label: Container(
                              alignment: Alignment.center,
                              child: Text('CUI'),
                            ),
                          ),
                          GridColumn(
                            columnName: 'iban',
                            label: Container(
                              alignment: Alignment.center,
                              child: Text('IBAN'),
                            ),
                          ),

                        ],
                      );
              },
            ),
          ),
          Expanded(
            child: Column(
              children: [
                EntityInfoCard(
                  entityName: 'MEDIAFLOW PUBLIC RELATIONS',
                  cui: '45135547',
                  regCom: 'J40/18626/2021',
                  adresa: 'Bdul. Decebal 12 B',
                  alertCount: 13,
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: staticVar.fullhigth(context) * .65,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      // Background color
                      borderRadius: BorderRadius.circular(10),
                      // 10-radius curve
                      border: Border.all(
                        color: Colors.grey, // Grey border
                        width: 2.0,
                      ),
                    ),
                    child: DefaultTabController(
                      length: 5,
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              // White background for TabBar
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(10)),
                            ),
                            child: TabBar(
                              indicatorColor: staticVar.themeColor,
                              // Tab indicator color
                              labelColor: Colors.black,
                              // Active label color
                              unselectedLabelColor: Colors.grey,
                              // Inactive label color
                              tabs: [
                                Tab(text: 'Tranzactii'),
                                Tab(text: 'Operatiuni'),
                                Tab(text: 'Documente'),
                                Tab(text: 'Conturi Bancare'),
                                Tab(text: 'Rapoarte'),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(16),
                              child: TabBarView(
                                children: [
                                  SfDataGridTheme(
                                    data: SfDataGridThemeData(
                                      sortIconColor: Colors.white,
                                        headerColor: const Color(0xff38383A),
                                        filterIconColor: Colors.white),
                                    child: SfDataGrid(
                                      controller: _dataGridController,
                                      allowSorting: true,
                                      allowFiltering: true,
                                      columnWidthMode: ColumnWidthMode.fill,
                                      source: TransactionTabDataSource(
                                          transactions: generateDummyData()),
                                      columns: <GridColumn>[
                                        GridColumn(
                                          columnName: 'data',
                                          label: Container(
                                            alignment: Alignment.center,
                                            child: Text(
                                              'Data',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        GridColumn(
                                          columnName: 'suma',
                                          label: Container(
                                            alignment: Alignment.center,
                                            child: Text(
                                              'Suma',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        GridColumn(
                                          columnName: 'platitor',
                                          label: Container(
                                            alignment: Alignment.center,
                                            child: Text(
                                              'Platitor',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        GridColumn(
                                          columnName: 'beneficiar',
                                          label: Container(
                                            alignment: Alignment.center,
                                            child: Text(
                                              'Beneficiar',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Center(child: Text('Tranzactii Content')),
                                  Center(child: Text('Documente Content')),
                                  Center(child: Text('Documente Content')),
                                  Center(child: Text('Documente Content')),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Container(
                //     height: staticVar.fullhigth(context) * .3,
                //     decoration: BoxDecoration(
                //       color: Colors.white,
                //       // Background color
                //       borderRadius: BorderRadius.circular(10),
                //       // 10-radius curve
                //       border: Border.all(
                //         color: Colors.grey, // Grey border
                //         width: 2.0,
                //       ),
                //     ),
                //     child: DefaultTabController(
                //       length: 4,
                //       child: Column(
                //         children: [
                //           Container(
                //             decoration: BoxDecoration(
                //               color: Colors.white,
                //               // White background for TabBar
                //               borderRadius: BorderRadius.vertical(
                //                   top: Radius.circular(10)),
                //             ),
                //             child: TabBar(
                //               indicatorColor: staticVar.themeColor,
                //               // Tab indicator color
                //               labelColor: Colors.black,
                //               // Active label color
                //               unselectedLabelColor: Colors.grey,
                //               // Inactive label color
                //               tabs: [
                //                 Tab(text: 'Operatiuni'),
                //                 Tab(text: 'Tranzactii'),
                //                 Tab(text: 'Documente'),
                //                 Tab(text: 'Detalii'),
                //               ],
                //             ),
                //           ),
                //           Expanded(
                //             child: Container(
                //               padding: EdgeInsets.all(16),
                //               child: TabBarView(
                //                 children: [
                //                   Center(child: Text('Operatiuni Content')),
                //                   Center(child: Text('Tranzactii Content')),
                //                   Center(child: Text('Documente Content')),
                //                   Center(child: Text('Detalii Content')),
                //                 ],
                //               ),
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          )
        ],
      ),
    );
  }

  // Generating dummy data for 20 rows
  List<TransactionTabData> generateDummyData() {
    return List<TransactionTabData>.generate(20, (index) {
      return TransactionTabData(
        data: '2025-01-0${index + 1}',
        suma: '${(index + 1) * 100}.00 RON',
        platitor: 'Platitor ${index + 1}',
        beneficiar: 'Beneficiar ${index + 1}',
      );
    });
  }
}

void showEntityDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AddEntityDialog();
    },
  );
}


class DocumenteTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white, // Ensure the background is white
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Resources',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          SizedBox(height: 8),
          Text('Compressed Archive • 302 MB'),
          SizedBox(height: 24),
          Text(
            'Information',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          SizedBox(height: 8),
          buildInfoRow('Created', 'Sep 29, 2020 at 10:44 PM'),
          buildInfoRow('Modified', 'Oct 4, 2020 at 9:30 AM'),
          buildInfoRow('Last Opened', 'Oct 4, 2020 at 9:30 AM'),
        ],
      ),
    );
  }

  Widget buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value),
        ],
      ),
    );
  }
}

class AddEntityDialog extends StatefulWidget {
  @override
  State<AddEntityDialog> createState() => _AddEntityDialogState();
}

class _AddEntityDialogState extends State<AddEntityDialog> {
  TextEditingController entityNameController = TextEditingController();
  TextEditingController dropdownSearchController = TextEditingController();
  String entityType = 'SRL'; // Default dropdown value
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  // Entity type switches
  Map<String, bool> entityTypeSwitches = {
    'In Administratie': false,
    'Statul': false,
    'Furnizor': false,
    'Autoritati': false,
    'Client': false,
    'Partener': false,
    'Angajat': false,
    'Creditor': false,
    'Asociat': false,
    'Proprietar': false,
  };

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final entityName = entityNameController.text.trim();
      isLoading = true;
      setState(() {});
      // Add entity logic here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Color(0xFFF8F8FA),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  "Adauga o entitate noua",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // Entity Name Field
                Text(
                  "Numele Entitatii",
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 8),
                CustomTextField(
                  textEditingController: entityNameController,
                  label: "Numele Entitatii",
                ),
                SizedBox(height: 16),

                // Dropdown for Entity Type
                Text(
                  "Tipul Entitatii",
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 8),
                CustomDropdown(
                  textEditingController: dropdownSearchController,
                  items: ['SRL', 'SA', 'ONG'],
                  selectedValue: entityType,
                  lable: "Tipul Entitatii",
                  onChanged: (newValue) {
                    setState(() {
                      entityType = newValue!;
                    });
                  },
                  onAddNewItemPressed: () {
                    // Handle add new item logic here
                  },
                ),
                SizedBox(height: 16),

                //Switches for Entity Types in 2 columns
                GridView.builder(
                  shrinkWrap: true,
                  itemCount: entityTypeSwitches.keys.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // 2 columns
                    childAspectRatio: 4, // Adjust for the desired row height
                  ),
                  itemBuilder: (context, index) {
                    String key = entityTypeSwitches.keys.elementAt(index);
                    return Padding(
                      padding: const EdgeInsets.only(left: 70.0, right: 70),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(key),
                              Expanded(child: SizedBox()),
                              Switch(
                                value: entityTypeSwitches[key]!,
                                onChanged: (value) {
                                  setState(() {
                                    entityTypeSwitches[key] = value;
                                  });
                                },
                                activeColor:
                                    staticVar.themeColor, // Active color
                              ),
                            ],
                          ),
                          Divider(
                            color: Colors.grey, // Gray underline
                            thickness: 1.0, // Thickness of the underline
                          ),
                        ],
                      ),
                    );
                  },
                ),

                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Column(
                //     children: [
                //       Row(
                //         children: List.generate(4, (index) {
                //           return Expanded(
                //             child: Container(
                //               margin: EdgeInsets.all(4),
                //               height: 500,
                //               color: Colors.grey[(index + 1) * 100], // Different shades of grey
                //               child: Column(
                //                 children: List.generate(5, (elementIndex) {
                //                   // Get the keys from the entityTypeSwitches map
                //                   String key = entityTypeSwitches.keys.elementAt(elementIndex);
                //                   return ListTile(
                //                     title: Text(key),
                //                     trailing: Switch(
                //                       value: entityTypeSwitches[key]!,
                //                       onChanged: (value) {
                //                         // Update the switch value
                //                         entityTypeSwitches[key] = value;
                //                       },
                //                     ),
                //                   );
                //                 }),
                //               ),
                //             ),
                //           );
                //         }),
                //       ),
                //       // Row 1 with 4 columns
                //       Row(
                //         children: List.generate(4, (index) {
                //           return Expanded(
                //             child: Container(
                //               margin: EdgeInsets.all(4),
                //               height: 500,
                //               color: Colors.grey[(index + 1) * 100], // Different shades of grey
                //               child: Column(
                //                 children: List.generate(4, (elementIndex) {
                //                   return Container(
                //                     height: 80, // Height for each element in the column
                //                     color: Colors.primaries[elementIndex % Colors.primaries.length], // Cycle through primary colors
                //                   );
                //                 }),
                //               ),
                //             ),
                //           );
                //         }),
                //       ),
                //
                //       // Add more rows as needed
                //     ],
                //   ),
                // ),
                SizedBox(height: 24),

                // Action Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
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
      ),
    );
  }
}
