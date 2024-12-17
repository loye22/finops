import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class PaymentApprovalStatusModel {
  final String payment_approval_status;

  PaymentApprovalStatusModel({
    required this.payment_approval_status,
  });
}

class PaymentApprovalStatusDataSource extends DataGridSource {
  PaymentApprovalStatusDataSource({required List<PaymentApprovalStatusModel> paymentApprovalStatuses}) {
    _paymentApprovalStatusData = paymentApprovalStatuses
        .map<DataGridRow>((paymentApprovalStatus) => DataGridRow(cells: [
      DataGridCell<String>(
        columnName: 'paymentApprovalStatus',
        value: paymentApprovalStatus.payment_approval_status,
      ),
    ]))
        .toList();
  }

  List<DataGridRow> _paymentApprovalStatusData = [];

  @override
  List<DataGridRow> get rows => _paymentApprovalStatusData;

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
