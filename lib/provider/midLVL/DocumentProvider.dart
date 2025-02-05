import 'dart:convert';
import 'package:finops/models/staticVar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../models/midLVL/DocumentModel.dart';


class DocumentProviderMidLvl with ChangeNotifier {
  List<DocumentModelMidLvl> _documentList = [];
  late DocumentDataSource _documentDataSource;
  String? _errorMessage;
  String? _successMessage;

  // Getters
  List<DocumentModelMidLvl> get documentList => _documentList;
  String? get errorMessage => _errorMessage;
  String? get successMessage => _successMessage;
  DocumentDataSource get documentDataSource => _documentDataSource;
  bool get hasData => _documentList.isNotEmpty;

  DocumentProviderMidLvl() {
    fetchDocumentsFromAPI();
  }

  Future<void> fetchDocumentsFromAPI() async {
    if (_documentList.isNotEmpty) {
      print("Documents already loaded.");
      return;
    }
    print("Fetching documents...");

    try {
      final url =  staticVar.urlAPI  +  'documents/Action';  // Replace with your API endpoint.
      final headers = {
        'ApplicationAccessKey': 'V2-HPwgN-t1nZA-pHXjA-5UBkc-NAVkh-vRq9F-zPDFW-WMFY1', // Replace with your key.
        'Content-Type': 'application/json',
      };
      final body = jsonEncode({"Action": "Find", "Rows": []});
      final response = await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        List<DocumentModelMidLvl> documentListHelper = [];

        for (var item in data) {
          documentListHelper.add(DocumentModelMidLvl(
            documentId: item['document_id'],
            userEmail: item['user_email'],
            userTimestamp: DateTime.parse(item['user_timestamp']),
            documentClass: item['document_class'],
            documentType: item['document_type'],
            documentFileUrlFlutter: item['document_file_url_flutter'],
            documentName: item['document_name'],
            documentNumber: item['document_number'],
            documentSeries: item['document_series'],
            issuerId: item['issuer_id'],
            beneficiaryId: item['beneficiary_id'],
            partnerId: item['partner_id'],
            dateStart: DateTime.parse(item['date_start'])?? DateTime(1800),
            dateEnd: DateTime.parse(item['date_end']) ?? DateTime(1800),
          ));
        }

        _documentList = documentListHelper;
        _documentDataSource = DocumentDataSource(documents: _documentList);
        notifyListeners();
      } else {
        throw Exception("Failed to fetch documents. ${response.body}");
      }
    } catch (e) {
      print("error $e");
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> addDocument(Map<String, dynamic> data) async {
    try {
      print("adding ");
      final url = staticVar.urlAPI  +  'documents/Action';  // Replace with your API endpoint.
      final headers = {
        'ApplicationAccessKey': 'V2-HPwgN-t1nZA-pHXjA-5UBkc-NAVkh-vRq9F-zPDFW-WMFY1', // Replace with your key.
        'Content-Type': 'application/json',
      };
      User? user = FirebaseAuth.instance.currentUser;
      final body = jsonEncode({
        "Action": "Add",
        "Rows": [data]
      });

      final response = await http.post(Uri.parse(url), headers: headers, body: body);

      print("response.statusCode");
      print(response.statusCode);
      return;
      if (response.statusCode == 200) {
        DocumentModelMidLvl newDocument = DocumentModelMidLvl(
          documentId: data['document_id'],
          userEmail: data['user_email'],
          userTimestamp: data['user_timestamp'],
          documentClass: data['document_class'],
          documentType: data['document_type'],
          documentFileUrlFlutter: data['document_file_url_flutter'],
          documentName: data['document_name'],
          documentNumber: data['document_number'],
          documentSeries: data['document_series'],
          issuerId: data['issuer_id'],
          beneficiaryId: data['beneficiary_id'],
          partnerId: data['partner_id'],
          dateStart: data['date_start'],
          dateEnd: data['date_end'] ,
        );
        _documentList.add(newDocument);
        _documentDataSource = DocumentDataSource(documents: _documentList);
        _successMessage = 'Document added successfully!';
        notifyListeners();
      } else {
        throw Exception("Failed to add document. ${response.body}");
      }
    } catch (e) {
      print(e);
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  void clearSuccessMessage() {
    _successMessage = null;
    notifyListeners();
  }
}
