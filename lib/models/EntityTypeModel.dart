import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:flutter/material.dart';

class EntityTypeModel {
  final String entity_type;

  EntityTypeModel({
    required this.entity_type,
  });
}

class EntityTypeDataSource extends DataGridSource {
  EntityTypeDataSource({required List<EntityTypeModel> entities}) {
    _entityTypeData = entities
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(
                columnName: 'entityType',
                value: e.entity_type,
              ),
            ]))
        .toList();
  }

  List<DataGridRow> _entityTypeData = [];

  @override
  List<DataGridRow> get rows => _entityTypeData;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(left: 16.0),
          child: Text(dataGridCell.value.toString()));
    }).toList());
  }
}
