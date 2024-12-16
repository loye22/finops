import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class PaymentStatusModel {
  final String payment_status;

  PaymentStatusModel({
    required this.payment_status,
  });
}
class PaymentStatusDataSource extends DataGridSource {
  PaymentStatusDataSource({required List<PaymentStatusModel> paymentStatuses}) {
    _paymentStatusData = paymentStatuses
        .map<DataGridRow>((paymentStatus) => DataGridRow(cells: [
      DataGridCell<String>(
        columnName: 'paymentStatus',
        value: paymentStatus.payment_status,
      ),
    ]))
        .toList();
  }

  List<DataGridRow> _paymentStatusData = [];

  @override
  List<DataGridRow> get rows => _paymentStatusData;

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
