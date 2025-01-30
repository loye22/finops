import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class EntityData {
  final String EntitateName;
  final String cui;
  final String iban;


  EntityData({required this.EntitateName,required this.cui,required this.iban});
}

class EntityDataSource extends DataGridSource {
  EntityDataSource({required List<EntityData> entities}) {
    _entityData = entities.map<DataGridRow>((entity) => DataGridRow(cells: [
      DataGridCell<String>(
        columnName: 'denumireEntitate',
        value: entity.EntitateName,
      ),
      DataGridCell<String>(
        columnName: 'cui',
        value: entity.cui,
      ),
      DataGridCell<String>(
        columnName: 'iban',
        value: entity.iban,
      ),

    ])).toList();
  }

  List<DataGridRow> _entityData = [];

  @override
  List<DataGridRow> get rows => _entityData;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: Text(
              dataGridCell.value.toString(),
              overflow: TextOverflow.ellipsis,
            ),
          );
        }).toList());
  }
}
