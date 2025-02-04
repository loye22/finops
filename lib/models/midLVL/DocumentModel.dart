import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class DocumentModelMidLvl {
  final String documentId;
  final String userEmail;
  final DateTime userTimestamp;
  final String documentClass;
  final String documentType;
  final String documentFileUrlFlutter;
  final String documentName;
  final String documentNumber;
  final String documentSeries;
  final String issuerId;
  final String beneficiaryId;
  final String partnerId;
  final DateTime dateStart;
  final DateTime dateEnd;

  DocumentModelMidLvl({
    required this.documentId,
    required this.userEmail,
    required this.userTimestamp,
    required this.documentClass,
    required this.documentType,
    required this.documentFileUrlFlutter,
    required this.documentName,
    required this.documentNumber,
    required this.documentSeries,
    required this.issuerId,
    required this.beneficiaryId,
    required this.partnerId,
    required this.dateStart,
    required this.dateEnd,
  });
}

class DocumentDataSource extends DataGridSource {
  DocumentDataSource({required List<DocumentModelMidLvl> documents}) {
    _documentData = documents.map<DataGridRow>((document) {
      return DataGridRow(cells: [
        DataGridCell<String>(columnName: 'document_id', value: document.documentId),
        DataGridCell<String>(columnName: 'user_email', value: document.userEmail),
        DataGridCell<DateTime>(columnName: 'user_timestamp', value: document.userTimestamp),
        DataGridCell<String>(columnName: 'document_class', value: document.documentClass),
        DataGridCell<String>(columnName: 'document_type', value: document.documentType),
        DataGridCell<String>(columnName: 'document_file_url_flutter', value: document.documentFileUrlFlutter),
        DataGridCell<String>(columnName: 'document_name', value: document.documentName),
        DataGridCell<String>(columnName: 'document_number', value: document.documentNumber),
        DataGridCell<String>(columnName: 'document_series', value: document.documentSeries),
        DataGridCell<String>(columnName: 'issuer_id', value: document.issuerId),
        DataGridCell<String>(columnName: 'beneficiary_id', value: document.beneficiaryId),
        DataGridCell<String>(columnName: 'partner_id', value: document.partnerId),
        DataGridCell<DateTime>(columnName: 'date_start', value: document.dateStart),
        DataGridCell<DateTime>(columnName: 'date_end', value: document.dateEnd),
      ]);
    }).toList();
  }

  List<DataGridRow> _documentData = [];

  @override
  List<DataGridRow> get rows => _documentData;

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
            style: const TextStyle(fontWeight: FontWeight.normal, color: CupertinoColors.black),
          ),
        );
      }).toList(),
    );
  }
}
