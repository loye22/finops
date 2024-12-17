import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/botLVL/KeywordTagModel.dart';
import '../models/staticVar.dart';

class KeywordTagProvider with ChangeNotifier {
  List<KeywordTagModel> _keywordTagList = [];
  late KeywordTagDataSource _keywordTagDataSource;
  String? _errorMessage;
  String? _successMessage;

  // Getters
  List<KeywordTagModel> get keywordTagList => _keywordTagList;
  String? get errorMessage => _errorMessage;
  String? get successMessage => _successMessage;
  KeywordTagDataSource get keywordTagDataSource => _keywordTagDataSource;

  bool get hasData => _keywordTagList.isNotEmpty;

  KeywordTagProvider() {
    fetchKeywordTagsFromAPI();
  }

  Future<void> fetchKeywordTagsFromAPI() async {
    if (_keywordTagList.isNotEmpty) {
      print("Data is already loaded.");
      return;
    }
    print("Fetching keyword tags...");

    try {
      final url = staticVar.urlAPI + 'keyword_tag/Action';
      final headers = {
        'ApplicationAccessKey': 'V2-HPwgN-t1nZA-pHXjA-5UBkc-NAVkh-vRq9F-zPDFW-WMFY1',
        'Content-Type': 'application/json',
      };
      final body = jsonEncode({"Action": "Find", "Rows": []});
      final response = await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        List<KeywordTagModel> keywordTagListHelper = [];

        for (var item in data) {
          KeywordTagModel keywordTag = KeywordTagModel(
            keyword_tag: item['keyword_tag'] ?? 'NOTFOUND',
          );
          keywordTagListHelper.add(keywordTag);
        }

        _keywordTagList = keywordTagListHelper;
        _keywordTagDataSource = KeywordTagDataSource(keywordTags: _keywordTagList);
        notifyListeners();
      } else {
        throw Exception("Failed to fetch keyword tags. ${response.body}");
      }
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> addKeywordTag(Map<String, dynamic> data) async {
    try {
      final url = staticVar.urlAPI + 'keyword_tag/Action';
      final headers = {
        'ApplicationAccessKey': 'V2-HPwgN-t1nZA-pHXjA-5UBkc-NAVkh-vRq9F-zPDFW-WMFY1',
        'Content-Type': 'application/json',
      };
      final body = jsonEncode({
        "Action": "Add",
        "Rows": [{'keyword_tag': data['keyword_tag']}]
      });

      final response = await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        KeywordTagModel newKeywordTag = KeywordTagModel(
          keyword_tag: data['keyword_tag'],
        );
        _keywordTagList.add(newKeywordTag);
        _keywordTagDataSource = KeywordTagDataSource(keywordTags: _keywordTagList);
        _successMessage = 'Keyword tag added successfully!';
        notifyListeners();
      } else {
        throw Exception("Failed to add keyword tag. ${response.body}");
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

