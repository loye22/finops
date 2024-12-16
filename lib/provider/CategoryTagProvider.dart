import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/CategoryTagModel.dart';
import '../models/staticVar.dart';

class CategoryTagProvider with ChangeNotifier {
  List<CategoryTagModel> _categoryTagList = [];
  late CategoryTagDataSource _categoryTagDataSource;
  String? _errorMessage;
  String? _successMessage;

  // Getters
  List<CategoryTagModel> get categoryTagList => _categoryTagList;
  String? get errorMessage => _errorMessage;
  String? get successMessage => _successMessage;
  CategoryTagDataSource get categoryTagDataSource => _categoryTagDataSource;

  bool get hasData => _categoryTagList.isNotEmpty;

  CategoryTagProvider() {
    fetchCategoryTagsFromAPI();
  }

  Future<void> fetchCategoryTagsFromAPI() async {
    if (_categoryTagList.isNotEmpty) {
      print("Data is already loaded.");
      return;
    }
    print("Fetching category tags...");

    try {
      final url = staticVar.urlAPI + 'category_tag/Action';
      final headers = {
        'ApplicationAccessKey': 'V2-HPwgN-t1nZA-pHXjA-5UBkc-NAVkh-vRq9F-zPDFW-WMFY1',
        'Content-Type': 'application/json',
      };
      final body = jsonEncode({"Action": "Find", "Rows": []});
      final response = await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        List<CategoryTagModel> categoryTagListHelper = [];

        for (var item in data) {
          CategoryTagModel categoryTag = CategoryTagModel(
            category_tag: item['category_tag'] ?? 'NOTFOUND',
          );
          categoryTagListHelper.add(categoryTag);
        }

        _categoryTagList = categoryTagListHelper;
        _categoryTagDataSource = CategoryTagDataSource(categoryTags: _categoryTagList);
        notifyListeners();
      } else {
        throw Exception("Failed to fetch category tags. ${response.body}");
      }
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> addCategoryTag(Map<String, dynamic> data) async {
    try {
      final url = staticVar.urlAPI + 'category_tag/Action';
      final headers = {
        'ApplicationAccessKey': 'V2-HPwgN-t1nZA-pHXjA-5UBkc-NAVkh-vRq9F-zPDFW-WMFY1',
        'Content-Type': 'application/json',
      };
      final body = jsonEncode({
        "Action": "Add",
        "Rows": [{'category_tag': data['category_tag']}]
      });

      final response = await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        CategoryTagModel newCategoryTag = CategoryTagModel(
          category_tag: data['category_tag'],
        );
        _categoryTagList.add(newCategoryTag);
        _categoryTagDataSource = CategoryTagDataSource(categoryTags: _categoryTagList);
        _successMessage = 'Category tag added successfully!';
        notifyListeners();
      } else {
        throw Exception("Failed to add category tag. ${response.body}");
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
