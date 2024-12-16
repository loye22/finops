import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ConsumptionLocationModel {
  final String consumption_location;

  ConsumptionLocationModel({
    required this.consumption_location,
  });
}
class ConsumptionLocationDataSource extends DataGridSource {
  ConsumptionLocationDataSource({required List<ConsumptionLocationModel> consumptionLocations}) {
    _consumptionLocationData = consumptionLocations
        .map<DataGridRow>((consumptionLocation) => DataGridRow(cells: [
      DataGridCell<String>(
        columnName: 'consumptionLocation',
        value: consumptionLocation.consumption_location,
      ),
    ]))
        .toList();
  }

  List<DataGridRow> _consumptionLocationData = [];

  @override
  List<DataGridRow> get rows => _consumptionLocationData;

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
