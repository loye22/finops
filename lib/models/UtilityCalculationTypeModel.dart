import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class UtilityCalculationTypeModel {
  final String utility_calculation_type;

  UtilityCalculationTypeModel({
    required this.utility_calculation_type,
  });
}
class UtilityCalculationTypeDataSource extends DataGridSource {
  UtilityCalculationTypeDataSource({required List<UtilityCalculationTypeModel> utilityCalculationTypes}) {
    _utilityCalculationTypeData = utilityCalculationTypes
        .map<DataGridRow>((utilityCalculationType) => DataGridRow(cells: [
      DataGridCell<String>(
        columnName: 'utilityCalculationType',
        value: utilityCalculationType.utility_calculation_type,
      ),
    ]))
        .toList();
  }

  List<DataGridRow> _utilityCalculationTypeData = [];

  @override
  List<DataGridRow> get rows => _utilityCalculationTypeData;

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
