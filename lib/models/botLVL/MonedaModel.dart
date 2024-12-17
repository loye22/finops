import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:finops/models/botLVL/MonedaModel.dart';

class MonedaModel {
  final String moneda;

  MonedaModel({
    required this.moneda,
  });
}



class MonedaDataSource extends DataGridSource {
  MonedaDataSource({required List<MonedaModel> monedas}) {
    _monedaData = monedas
        .map<DataGridRow>((m) => DataGridRow(cells: [
      DataGridCell<String>(
        columnName: 'moneda',
        value: m.moneda,
      ),
    ]))
        .toList();
  }

  List<DataGridRow> _monedaData = [];

  @override
  List<DataGridRow> get rows => _monedaData;

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
