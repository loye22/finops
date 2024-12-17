import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class VehicleRegistrationNumberModel {
  final String vehicle_registration_number;

  VehicleRegistrationNumberModel({
    required this.vehicle_registration_number,
  });
}
class VehicleRegistrationNumberDataSource extends DataGridSource {
  VehicleRegistrationNumberDataSource({required List<VehicleRegistrationNumberModel> vehicleRegistrationNumbers}) {
    _vehicleRegistrationNumberData = vehicleRegistrationNumbers
        .map<DataGridRow>((vehicleRegistrationNumber) => DataGridRow(cells: [
      DataGridCell<String>(
        columnName: 'vehicleRegistrationNumber',
        value: vehicleRegistrationNumber.vehicle_registration_number,
      ),
    ]))
        .toList();
  }

  List<DataGridRow> _vehicleRegistrationNumberData = [];

  @override
  List<DataGridRow> get rows => _vehicleRegistrationNumberData;

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
