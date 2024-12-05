import 'package:finops/provider/UtilityTypeProvider.dart';
import 'package:finops/widgets/testPopUp.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../models/staticVar.dart';

class AnVehicul extends StatefulWidget {
  const AnVehicul({super.key});

  @override
  State<AnVehicul> createState() => _AnVehiculState();
}

class _AnVehiculState extends State<AnVehicul> {
  final DataGridController _dataGridController = DataGridController();

  @override
  Widget build(BuildContext context) {
    final utilityTypeProvider = Provider.of<UtilityTypeProvider>(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Adaugă Tip Utilitate',
        backgroundColor: staticVar.themeColor,
        onPressed: () async {
          showUtilityTypeDialog(context);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: !utilityTypeProvider.hasData
          ? staticVar.loading()
          : SfDataGrid(
              controller: _dataGridController,
              allowSorting: true,
              allowFiltering: true,
              columnWidthMode: ColumnWidthMode.fill,
              source: utilityTypeProvider.utilityTypeDataSource,
              columns: <GridColumn>[
                GridColumn(
                  columnName: 'utilityName',
                  label: Container(

                    alignment: Alignment.center,
                    child: Text('Nume Utilitate'),
                  ),
                ),
                GridColumn(
                  columnName: 'utilityDescription',
                  label: Container(
                    alignment: Alignment.center,
                    child: Text('Descriere Utilitate'),
                  ),
                ),
              ],
            ),
    );
  }
}

// Show dialog for adding a utility type
void showUtilityTypeDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AddCustomerDialog();
    },
  );
}
