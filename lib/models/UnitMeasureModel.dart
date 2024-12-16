import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class UnitMeasureModel {
  final String unit_measure;

  UnitMeasureModel({
    required this.unit_measure,
  });
}
class UnitMeasureDataSource extends DataGridSource {
  UnitMeasureDataSource({required List<UnitMeasureModel> unitMeasures}) {
    _unitMeasureData = unitMeasures
        .map<DataGridRow>((unitMeasure) => DataGridRow(cells: [
      DataGridCell<String>(
        columnName: 'unitMeasure',
        value: unitMeasure.unit_measure,
      ),
    ]))
        .toList();
  }

  List<DataGridRow> _unitMeasureData = [];

  @override
  List<DataGridRow> get rows => _unitMeasureData;

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
