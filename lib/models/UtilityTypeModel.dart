import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class UtilityTypeModel {
  final String utility_type;
  final String utility_type_description;

  UtilityTypeModel({
    required this.utility_type,
    required this.utility_type_description,
  });
}


class UtilityTypeDataSource extends DataGridSource {
  UtilityTypeDataSource({required List<UtilityTypeModel> utilities}) {
    _utilityTypeData = utilities
        .map<DataGridRow>((utility) => DataGridRow(cells: [
      DataGridCell<String>(
        columnName: 'utilityType',
        value: utility.utility_type,
      ),
      DataGridCell<String>(
        columnName: 'utilityTypeDescription',
        value: utility.utility_type_description,
      ),
    ]))
        .toList();
  }

  List<DataGridRow> _utilityTypeData = [];

  @override
  List<DataGridRow> get rows => _utilityTypeData;

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
