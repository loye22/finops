import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class DocumentClassModel {
  final String document_class;

  DocumentClassModel({
    required this.document_class,
  });
}

class DocumentClassDataSource extends DataGridSource {
  DocumentClassDataSource({required List<DocumentClassModel> documentClasses}) {
    _documentClassData = documentClasses
        .map<DataGridRow>((documentClass) => DataGridRow(cells: [
      DataGridCell<String>(
        columnName: 'documentClass',
        value: documentClass.document_class,
      ),
    ]))
        .toList();
  }

  List<DataGridRow> _documentClassData = [];

  @override
  List<DataGridRow> get rows => _documentClassData;

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


