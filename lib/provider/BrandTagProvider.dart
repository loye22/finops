import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/botLVL/BrandTagModel.dart';
import '../models/staticVar.dart';

class BrandTagProvider with ChangeNotifier {
  List<BrandTagModel> _brandTagList = [];
  late BrandTagDataSource _brandTagDataSource;
  String? _errorMessage;
  String? _successMessage;

  // Getters
  List<BrandTagModel> get brandTagList => _brandTagList;
  String? get errorMessage => _errorMessage;
  String? get successMessage => _successMessage;
  BrandTagDataSource get brandTagDataSource => _brandTagDataSource;

  bool get hasData => _brandTagList.isNotEmpty;

  BrandTagProvider() {
    fetchBrandTagsFromAPI();
  }

  Future<void> fetchBrandTagsFromAPI() async {
    if (_brandTagList.isNotEmpty) {
      print("Data is already loaded.");
      return;
    }
    print("Fetching brand tags...");

    try {
      final url = staticVar.urlAPI + 'brand_tag/Action';
      final headers = {
        'ApplicationAccessKey': 'V2-HPwgN-t1nZA-pHXjA-5UBkc-NAVkh-vRq9F-zPDFW-WMFY1',
        'Content-Type': 'application/json',
      };
      final body = jsonEncode({"Action": "Find", "Rows": []});
      final response = await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        List<BrandTagModel> brandTagListHelper = [];

        for (var item in data) {
          BrandTagModel brandTag = BrandTagModel(
            brand_tag: item['brand_tag'] ?? 'NOTFOUND',
          );
          brandTagListHelper.add(brandTag);
        }

        _brandTagList = brandTagListHelper;
        _brandTagDataSource = BrandTagDataSource(brandTags: _brandTagList);
        notifyListeners();
      } else {
        throw Exception("Failed to fetch brand tags. ${response.body}");
      }
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> addBrandTag(Map<String, dynamic> data) async {
    try {
      final url = staticVar.urlAPI + 'brand_tag/Action';
      final headers = {
        'ApplicationAccessKey': 'V2-HPwgN-t1nZA-pHXjA-5UBkc-NAVkh-vRq9F-zPDFW-WMFY1',
        'Content-Type': 'application/json',
      };
      final body = jsonEncode({
        "Action": "Add",
        "Rows": [{'brand_tag': data['brand_tag']}]
      });

      final response = await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        BrandTagModel newBrandTag = BrandTagModel(
          brand_tag: data['brand_tag'],
        );
        _brandTagList.add(newBrandTag);
        _brandTagDataSource = BrandTagDataSource(brandTags: _brandTagList);
        _successMessage = 'Brand tag added successfully!';
        notifyListeners();
      } else {
        throw Exception("Failed to add brand tag. ${response.body}");
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

