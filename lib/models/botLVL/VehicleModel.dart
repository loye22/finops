import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class VehicleModel {
  final String vehicle_model;
  final String vehicle_brand;

  VehicleModel({
    required this.vehicle_model,
    required this.vehicle_brand,
  });
}
class VehicleModelDataSource extends DataGridSource {
  VehicleModelDataSource({required List<VehicleModel> vehicleModels}) {
    _vehicleModelData = vehicleModels
        .map<DataGridRow>((vehicleModel) => DataGridRow(cells: [
      DataGridCell<String>(
        columnName: 'vehicleModel',
        value: vehicleModel.vehicle_model,
      ),
      DataGridCell<String>(
        columnName: 'vehicleBrand',
        value: vehicleModel.vehicle_brand,
      ),
    ]))
        .toList();
  }

  List<DataGridRow> _vehicleModelData = [];

  @override
  List<DataGridRow> get rows => _vehicleModelData;

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
