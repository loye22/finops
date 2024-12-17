// operation_type_model.dart
// operation_type_data_source.dart
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class OperationTypeModel {
  final String operation_type;

  OperationTypeModel({
    required this.operation_type,
  });
}



class OperationTypeDataSource extends DataGridSource {
  OperationTypeDataSource({required List<OperationTypeModel> operationTypes}) {
    _operationTypesData = operationTypes
        .map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<String>(
        columnName: 'operationType',
        value: e.operation_type,
      ),
    ]))
        .toList();
  }

  List<DataGridRow> _operationTypesData = [];

  @override
  List<DataGridRow> get rows => _operationTypesData;

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
