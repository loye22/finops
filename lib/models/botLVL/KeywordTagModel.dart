import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class KeywordTagModel {
  final String keyword_tag;

  KeywordTagModel({
    required this.keyword_tag,
  });
}

class KeywordTagDataSource extends DataGridSource {
  KeywordTagDataSource({required List<KeywordTagModel> keywordTags}) {
    _keywordTagData = keywordTags
        .map<DataGridRow>((keywordTag) => DataGridRow(cells: [
      DataGridCell<String>(
        columnName: 'keywordTag',
        value: keywordTag.keyword_tag,
      ),
    ]))
        .toList();
  }

  List<DataGridRow> _keywordTagData = [];

  @override
  List<DataGridRow> get rows => _keywordTagData;

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
