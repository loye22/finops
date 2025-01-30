import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class TransactionTabData {
  final String data;
  final String suma;
  final String platitor;
  final String beneficiar;

  TransactionTabData({
    required this.data,
    required this.suma,
    required this.platitor,
    required this.beneficiar,
  });
}

class TransactionTabDataSource extends DataGridSource {
  TransactionTabDataSource({required List<TransactionTabData> transactions}) {
    _transactionData = transactions.map<DataGridRow>((transaction) => DataGridRow(cells: [
      DataGridCell<String>(
        columnName: 'data',
        value: transaction.data,
      ),
      DataGridCell<String>(
        columnName: 'suma',
        value: transaction.suma,
      ),
      DataGridCell<String>(
        columnName: 'platitor',
        value: transaction.platitor,
      ),
      DataGridCell<String>(
        columnName: 'beneficiar',
        value: transaction.beneficiar,
      ),
    ])).toList();
  }

  List<DataGridRow> _transactionData = [];

  @override
  List<DataGridRow> get rows => _transactionData;

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
