import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class FuelTypeModel {
  final String fuel_type;

  FuelTypeModel({
    required this.fuel_type,
  });
}
class FuelTypeDataSource extends DataGridSource {
  FuelTypeDataSource({required List<FuelTypeModel> fuelTypes}) {
    _fuelTypeData = fuelTypes
        .map<DataGridRow>((fuelType) => DataGridRow(cells: [
      DataGridCell<String>(
        columnName: 'fuelType',
        value: fuelType.fuel_type,
      ),
    ]))
        .toList();
  }

  List<DataGridRow> _fuelTypeData = [];

  @override
  List<DataGridRow> get rows => _fuelTypeData;

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
