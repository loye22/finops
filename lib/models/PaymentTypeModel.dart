import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class PaymentTypeModel {
  final String payment_type;

  PaymentTypeModel({
    required this.payment_type,
  });
}
class PaymentTypeDataSource extends DataGridSource {
  PaymentTypeDataSource({required List<PaymentTypeModel> paymentTypes}) {
    _paymentTypeData = paymentTypes
        .map<DataGridRow>((paymentType) => DataGridRow(cells: [
      DataGridCell<String>(
        columnName: 'paymentType',
        value: paymentType.payment_type,
      ),
    ]))
        .toList();
  }

  List<DataGridRow> _paymentTypeData = [];

  @override
  List<DataGridRow> get rows => _paymentTypeData;

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
