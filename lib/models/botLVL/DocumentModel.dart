// document_model.dart
// document_data_source.dart
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:flutter/material.dart';


class DocumentModel {
  final String document_type;

  DocumentModel({
    required this.document_type,
  });
}



class DocumentDataSource extends DataGridSource {
  DocumentDataSource({required List<DocumentModel> documents}) {
    _documentsData = documents
        .map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<String>(
        columnName: 'documentType',
        value: e.document_type,
      ),
    ]))
        .toList();
  }

  List<DataGridRow> _documentsData = [];

  @override
  List<DataGridRow> get rows => _documentsData;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
          return Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(dataGridCell.value.toString()));
        }).toList());
  }
}
