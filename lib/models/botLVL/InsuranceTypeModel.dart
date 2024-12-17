import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class InsuranceTypeModel {
  final String insurance_type;

  InsuranceTypeModel({
    required this.insurance_type,
  });
}
class InsuranceTypeDataSource extends DataGridSource {
  InsuranceTypeDataSource({required List<InsuranceTypeModel> insuranceTypes}) {
    _insuranceTypeData = insuranceTypes
        .map<DataGridRow>((insuranceType) => DataGridRow(cells: [
      DataGridCell<String>(
        columnName: 'insuranceType',
        value: insuranceType.insurance_type,
      ),
    ]))
        .toList();
  }

  List<DataGridRow> _insuranceTypeData = [];

  @override
  List<DataGridRow> get rows => _insuranceTypeData;

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
