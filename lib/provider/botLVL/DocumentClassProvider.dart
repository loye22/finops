import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../models/botLVL/DocumentClassModel.dart';
import '../../models/staticVar.dart';

class DocumentClassProvider with ChangeNotifier {
  List<DocumentClassModel> _documentClassList = [];
  late DocumentClassDataSource _documentClassDataSource;
  String? _errorMessage;
  String? _successMessage;

  // Getters
  List<DocumentClassModel> get documentClassList => _documentClassList;
  String? get errorMessage => _errorMessage;
  String? get successMessage => _successMessage;
  DocumentClassDataSource get documentClassDataSource => _documentClassDataSource;

  bool get hasData => _documentClassList.isNotEmpty;

  DocumentClassProvider() {
    fetchDocumentClassesFromAPI();
  }

  Future<void> fetchDocumentClassesFromAPI() async {
    if (_documentClassList.isNotEmpty) {
      print("Data is already loaded.");
      return;
    }
    print("Fetching document classes...");

    try {
      final url = staticVar.urlAPI + 'document_class/Action';
      final headers = {
        'ApplicationAccessKey': 'V2-HPwgN-t1nZA-pHXjA-5UBkc-NAVkh-vRq9F-zPDFW-WMFY1',
        'Content-Type': 'application/json',
      };
      final body = jsonEncode({"Action": "Find", "Rows": []});
      final response = await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        List<DocumentClassModel> documentClassListHelper = [];

        for (var item in data) {
          DocumentClassModel documentClass = DocumentClassModel(
            document_class: item['document_class'] ?? 'NOTFOUND',
          );
          documentClassListHelper.add(documentClass);
        }

        _documentClassList = documentClassListHelper;
        _documentClassDataSource = DocumentClassDataSource(documentClasses: _documentClassList);
        notifyListeners();
      } else {
        throw Exception("Failed to fetch document classes. ${response.body}");
      }
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> addDocumentClass(Map<String, dynamic> data) async {
    try {
      final url = staticVar.urlAPI + 'document_class/Action';
      final headers = {
        'ApplicationAccessKey': 'V2-HPwgN-t1nZA-pHXjA-5UBkc-NAVkh-vRq9F-zPDFW-WMFY1',
        'Content-Type': 'application/json',
      };
      final body = jsonEncode({
        "Action": "Add",
        "Rows": [{'document_class': data['document_class']}]
      });

      final response = await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        DocumentClassModel newDocumentClass = DocumentClassModel(
          document_class: data['document_class'],
        );
        _documentClassList.add(newDocumentClass);
        _documentClassDataSource = DocumentClassDataSource(documentClasses: _documentClassList);
        _successMessage = 'Document class added successfully!';
        notifyListeners();
      } else {
        throw Exception("Failed to add document class. ${response.body}");
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

