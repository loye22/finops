import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class TaxTypeModel {
  final String tax_type;

  TaxTypeModel({
    required this.tax_type,
  });
}

class TaxTypeDataSource extends DataGridSource {
  TaxTypeDataSource({required List<TaxTypeModel> taxes}) {
    _taxTypeData = taxes
        .map<DataGridRow>((tax) => DataGridRow(cells: [
      DataGridCell<String>(
        columnName: 'taxType',
        value: tax.tax_type,
      ),
    ]))
        .toList();
  }

  List<DataGridRow> _taxTypeData = [];

  @override
  List<DataGridRow> get rows => _taxTypeData;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(dataGridCell.value.toString()),
          );
        }).toList());
  }
}




