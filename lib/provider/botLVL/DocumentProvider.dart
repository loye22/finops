// document_provider.dart
import 'dart:convert';
import 'package:finops/models/botLVL/DocumentModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../models/staticVar.dart';


class DocumentProvider with ChangeNotifier {
  List<DocumentModel> _documentsList = [];
  late DocumentDataSource _documentDataSource;
  String? _errorMessage;
  String? _successMessage;

  // Getter for error message
  String? get errorMessage => _errorMessage;

  // Getter for success message
  String? get successMessage => _successMessage;

  DocumentDataSource get documentDataSource => _documentDataSource;

  bool get hasData => _documentsList.isNotEmpty;

  DocumentProvider() {
    fetchDocumentsFromAPI();
  }

  Future<void> fetchDocumentsFromAPI() async {
    if (_documentsList.isNotEmpty) {
      print("Data is already loaded.");
      return;
    }
    print("Fetching documents...");

    try {
      final url = staticVar.urlAPI + 'document_type/Action';
      final headers = {
        'ApplicationAccessKey': 'V2-HPwgN-t1nZA-pHXjA-5UBkc-NAVkh-vRq9F-zPDFW-WMFY1',
        'Content-Type': 'application/json',
      };
      final body = jsonEncode({"Action": "Find", "Rows": []});
      final response = await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        List<DocumentModel> documentsListHelper = [];

        for (var item in data) {
          DocumentModel document = DocumentModel(
            document_type: item['document_type'] ?? 'NOTFOUND',
          );
          documentsListHelper.add(document);
        }

        _documentsList = documentsListHelper;
        _documentDataSource = DocumentDataSource(documents: _documentsList);
        notifyListeners();
      } else {
        throw Exception("Failed to fetch documents.${response.body}");
      }
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> addDocument(Map<String, dynamic> data) async {
    try {
      final url = staticVar.urlAPI + 'document_type/Action';
      final headers = {
        'ApplicationAccessKey': 'V2-HPwgN-t1nZA-pHXjA-5UBkc-NAVkh-vRq9F-zPDFW-WMFY1',
        'Content-Type': 'application/json',
      };
      final body = jsonEncode({
        "Action": "Add",
        "Rows": [{'document_type': data['document_type']}]
      });

      final response = await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        DocumentModel newDocument = DocumentModel(
          document_type: data['document_type'],
        );
        _documentsList.add(newDocument);
        _documentDataSource = DocumentDataSource(documents: _documentsList);
        _successMessage = 'Document added successfully!';
        notifyListeners();
      } else {
        throw Exception("Failed to add document.${response.body}");
      }
    } catch (e) {
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
