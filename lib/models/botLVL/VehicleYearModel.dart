import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class VehicleYearModel {
  final String vehicle_year;

  VehicleYearModel({
    required this.vehicle_year,
  });
}
class VehicleYearDataSource extends DataGridSource {
  VehicleYearDataSource({required List<VehicleYearModel> vehicleYears}) {
    _vehicleYearData = vehicleYears
        .map<DataGridRow>((vehicleYear) => DataGridRow(cells: [
      DataGridCell<String>(
        columnName: 'vehicleYear',
        value: vehicleYear.vehicle_year,
      ),
    ]))
        .toList();
  }

  List<DataGridRow> _vehicleYearData = [];

  @override
  List<DataGridRow> get rows => _vehicleYearData;

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
