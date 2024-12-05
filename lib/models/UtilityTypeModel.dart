import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class UtilityTypeModel {
  final String utility_type;
  final String utility_type_description;

  UtilityTypeModel({
    required this.utility_type,
    required this.utility_type_description,
  });
}

class UtilityTypeDataSource extends DataGridSource {
  UtilityTypeDataSource({required List<UtilityTypeModel> utilityTypes}) {
    _getUtilityTypesData = utilityTypes
        .map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<String>(
        columnName: 'utilityName',
        value: e.utility_type,
      ),
      DataGridCell<String>(
        columnName: 'utilityDescription',
        value: e.utility_type_description,
      ),
    ]))
        .toList();
  }

  List<DataGridRow> _getUtilityTypesData = [];

  @override
  List<DataGridRow> get rows => _getUtilityTypesData;

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
