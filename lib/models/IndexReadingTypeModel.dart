import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class IndexReadingTypeModel {
  final String index_reading_type;

  IndexReadingTypeModel({
    required this.index_reading_type,
  });
}
class IndexReadingTypeDataSource extends DataGridSource {
  IndexReadingTypeDataSource({required List<IndexReadingTypeModel> indexReadingTypes}) {
    _indexReadingTypeData = indexReadingTypes
        .map<DataGridRow>((indexReadingType) => DataGridRow(cells: [
      DataGridCell<String>(
        columnName: 'indexReadingType',
        value: indexReadingType.index_reading_type,
      ),
    ]))
        .toList();
  }

  List<DataGridRow> _indexReadingTypeData = [];

  @override
  List<DataGridRow> get rows => _indexReadingTypeData;

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
