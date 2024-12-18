import 'package:finops/models/staticVar.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class TabBarExample extends StatefulWidget {
  @override
  _TabBarExampleState createState() => _TabBarExampleState();
}

class _TabBarExampleState extends State<TabBarExample>
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
                      child: Text('Denumire Entitate' ),
                    ),
                  ),
                  GridColumn(
                    columnName: 'cui',
                    label: Container(
                      padding: EdgeInsets.all(8.0),
                      alignment: Alignment.centerLeft,
                      child: Text('CUI'),
                    ),
                  ),
                  GridColumn(
                    columnName: 'iban',
                    label: Container(
                      padding: EdgeInsets.all(8.0),
                      alignment: Alignment.centerLeft,
                      child: Text('IBAN'),
                    ),
                  ),
                  GridColumn(
                    columnName: 'asocieri',
                    label: Container(
                      padding: EdgeInsets.all(8.0),
                      alignment: Alignment.centerLeft,
                      child: Text('Asocieri'),
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
                      color: Colors.white, // Background color
                      borderRadius: BorderRadius.circular(10), // 10-radius curve
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
                              color: Colors.white, // White background for TabBar
                              borderRadius:
                                  BorderRadius.vertical(top: Radius.circular(10)),
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
                      color: Colors.white, // Background color
                      borderRadius: BorderRadius.circular(10), // 10-radius curve
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
                              color: Colors.white, // White background for TabBar
                              borderRadius:
                                  BorderRadius.vertical(top: Radius.circular(10)),
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
