import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class PaymentMethodModel {
  final String payment_method;

  PaymentMethodModel({
    required this.payment_method,
  });
}

class PaymentMethodDataSource extends DataGridSource {
  PaymentMethodDataSource({required List<PaymentMethodModel> paymentMethods}) {
    _paymentMethodData = paymentMethods
        .map<DataGridRow>((paymentMethod) => DataGridRow(cells: [
      DataGridCell<String>(
        columnName: 'paymentMethod',
        value: paymentMethod.payment_method,
      ),
    ]))
        .toList();
  }

  List<DataGridRow> _paymentMethodData = [];

  @override
  List<DataGridRow> get rows => _paymentMethodData;

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
