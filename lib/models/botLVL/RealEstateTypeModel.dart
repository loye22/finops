import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class RealEstateTypeModel {
  final String real_estate_type;

  RealEstateTypeModel({
    required this.real_estate_type,
  });
}
class RealEstateTypeDataSource extends DataGridSource {
  RealEstateTypeDataSource({required List<RealEstateTypeModel> realEstateTypes}) {
    _realEstateTypeData = realEstateTypes
        .map<DataGridRow>((realEstateType) => DataGridRow(cells: [
      DataGridCell<String>(
        columnName: 'realEstateType',
        value: realEstateType.real_estate_type,
      ),
    ]))
        .toList();
  }

  List<DataGridRow> _realEstateTypeData = [];

  @override
  List<DataGridRow> get rows => _realEstateTypeData;

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
