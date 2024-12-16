import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ActivityTypeModel {
  final String activity_type;

  ActivityTypeModel({
    required this.activity_type,
  });
}
class ActivityTypeDataSource extends DataGridSource {
  ActivityTypeDataSource({required List<ActivityTypeModel> activityTypes}) {
    _activityTypeData = activityTypes
        .map<DataGridRow>((activityType) => DataGridRow(cells: [
      DataGridCell<String>(
        columnName: 'activityType',
        value: activityType.activity_type,
      ),
    ]))
        .toList();
  }

  List<DataGridRow> _activityTypeData = [];

  @override
  List<DataGridRow> get rows => _activityTypeData;

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
