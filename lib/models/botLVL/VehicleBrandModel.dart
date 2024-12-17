import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class VehicleBrandModel {
  final String vehicle_brand;

  VehicleBrandModel({
    required this.vehicle_brand,
  });
}
class VehicleBrandDataSource extends DataGridSource {
  VehicleBrandDataSource({required List<VehicleBrandModel> vehicleBrands}) {
    _vehicleBrandData = vehicleBrands
        .map<DataGridRow>((vehicleBrand) => DataGridRow(cells: [
      DataGridCell<String>(
        columnName: 'vehicleBrand',
        value: vehicleBrand.vehicle_brand,
      ),
    ]))
        .toList();
  }

  List<DataGridRow> _vehicleBrandData = [];

  @override
  List<DataGridRow> get rows => _vehicleBrandData;

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
