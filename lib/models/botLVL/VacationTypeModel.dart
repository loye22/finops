
import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class VacationTypeModel {
  final String vacation_type;

  VacationTypeModel({
    required this.vacation_type,
  });
}

class VacationTypeDataSource extends DataGridSource {
  VacationTypeDataSource({required List<VacationTypeModel> vacationTypes}) {
    _vacationTypeData = vacationTypes
        .map<DataGridRow>((vacationType) => DataGridRow(cells: [
      DataGridCell<String>(
        columnName: 'vacationType',
        value: vacationType.vacation_type,
      ),
    ]))
        .toList();
  }

  List<DataGridRow> _vacationTypeData = [];

  @override
  List<DataGridRow> get rows => _vacationTypeData;

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
