import 'package:finops/models/staticVar.dart';
import 'package:finops/widgets/CustomTextField.dart';
import 'package:finops/widgets/customButton.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../widgets/CustomDropdown.dart';

class entitiesMidLVL extends StatefulWidget {
  @override
  _entitiesMidLVLState createState() => _entitiesMidLVLState();
}

class _entitiesMidLVLState extends State<entitiesMidLVL>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final DataGridController _dataGridController = DataGridController();
  final EntityDataSource _entityDataSource = EntityDataSource();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: 'Adaugă Tip Operațiune',
        backgroundColor: staticVar.themeColor,
        onPressed: () async {
          popupexample(context);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      backgroundColor: Color(0xFFF8F8FA),
      body: Row(
        children: [
          Container(
            width: staticVar.fullWidth(context) * .65,
            height: staticVar.fullhigth(context),
            child: SfDataGridTheme(
              data: SfDataGridThemeData(headerColor: const Color(0xffEFF2F9)),
              child: SfDataGrid(
                controller: _dataGridController,
                allowSorting: true,
                allowFiltering: true,
                columnWidthMode: ColumnWidthMode.fill,
                source: _entityDataSource,
                columns: <GridColumn>[
                  GridColumn(
                    columnName: 'select',
                    label: Container(
                      padding: EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: Text('Select'),
                    ),
                    width: 60, // Adjust width for checkbox
                  ),
                  GridColumn(
                    columnName: 'denumireEntitate',
                    label: Container(
                      padding: EdgeInsets.all(8.0),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Denumire Entitate',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  GridColumn(
                    columnName: 'cui',
                    label: Container(
                      padding: EdgeInsets.all(8.0),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'CUI',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  GridColumn(
                    columnName: 'iban',
                    label: Container(
                      padding: EdgeInsets.all(8.0),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'IBAN',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  GridColumn(
                    columnName: 'asocieri',
                    label: Container(
                      padding: EdgeInsets.all(8.0),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Asocieri',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: staticVar.fullhigth(context) * .5,
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
                      length: 4,
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
                                Tab(text: 'Operatiuni'),
                                Tab(text: 'Tranzactii'),
                                Tab(text: 'Documente'),
                                Tab(text: 'Detalii'),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(16),
                              child: TabBarView(
                                children: [
                                  Center(child: Text('Operatiuni Content')),
                                  Center(child: Text('Tranzactii Content')),
                                  Center(child: Text('Documente Content')),
                                  Center(child: Text('Detalii Content')),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: staticVar.fullhigth(context) * .3,
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
                      length: 4,
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
                                Tab(text: 'Operatiuni'),
                                Tab(text: 'Tranzactii'),
                                Tab(text: 'Documente'),
                                Tab(text: 'Detalii'),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(16),
                              child: TabBarView(
                                children: [
                                  Center(child: Text('Operatiuni Content')),
                                  Center(child: Text('Tranzactii Content')),
                                  Center(child: Text('Documente Content')),
                                  Center(child: Text('Detalii Content')),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void popupexample(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AddEntityDialog();
      },
    );
  }
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

class EntityData {
  final String denumireEntitate;
  final String cui;
  final String iban;
  final String asocieri;

  EntityData(this.denumireEntitate, this.cui, this.iban, this.asocieri);
}

class EntityDataSource extends DataGridSource {
  final List<EntityData> _entities = List.generate(
    100, // Change this number for more rows
    (index) => EntityData(
      'STAR OFFICE CENTER SRL',
      '37624240',
      'RO87RZBR0000060020026999',
      index < 5 ? 'Septem, Furnizor, Client' : 'Septem, Ifigenia, Client',
    ),
  );

  @override
  List<DataGridRow> get rows => _entities
      .map((data) => DataGridRow(cells: [
            DataGridCell<String>(
                columnName: 'denumireEntitate', value: data.denumireEntitate),
            DataGridCell<String>(columnName: 'cui', value: data.cui),
            DataGridCell<String>(columnName: 'iban', value: data.iban),
            DataGridCell<String>(columnName: 'asocieri', value: data.asocieri),
          ]))
      .toList();

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(cells: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Checkbox(
          value: false,
          onChanged: (value) {},
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(row.getCells()[0].value),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(row.getCells()[1].value),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(row.getCells()[2].value),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(row.getCells()[3].value),
      ),
    ]);
  }
}

//

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
                                activeColor: staticVar.themeColor, // Active color
                              ),
                            ],
                          ), Divider(
                            color: Colors.grey,  // Gray underline
                            thickness: 1.0,      // Thickness of the underline
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
