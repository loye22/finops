import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class CategoryTagModel {
  final String category_tag;

  CategoryTagModel({
    required this.category_tag,
  });
}
class CategoryTagDataSource extends DataGridSource {
  CategoryTagDataSource({required List<CategoryTagModel> categoryTags}) {
    _categoryTagData = categoryTags
        .map<DataGridRow>((categoryTag) => DataGridRow(cells: [
      DataGridCell<String>(
        columnName: 'categoryTag',
        value: categoryTag.category_tag,
      ),
    ]))
        .toList();
  }

  List<DataGridRow> _categoryTagData = [];

  @override
  List<DataGridRow> get rows => _categoryTagData;

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
