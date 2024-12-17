import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:flutter/material.dart';

class BankNameModel {
  final String bank_name;

  BankNameModel({
    required this.bank_name,
  });
}

class BankNameDataSource extends DataGridSource {
  BankNameDataSource({required List<BankNameModel> banks}) {
    _bankNameData = banks
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(
                columnName: 'bankName',
                value: e.bank_name,
              ),
            ]))
        .toList();
  }

  List<DataGridRow> _bankNameData = [];

  @override
  List<DataGridRow> get rows => _bankNameData;

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
