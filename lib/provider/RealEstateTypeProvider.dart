import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/botLVL/RealEstateTypeModel.dart';
import '../models/staticVar.dart';

class RealEstateTypeProvider with ChangeNotifier {
  List<RealEstateTypeModel> _realEstateTypeList = [];
  late RealEstateTypeDataSource _realEstateTypeDataSource;
  String? _errorMessage;
  String? _successMessage;

  // Getters
  List<RealEstateTypeModel> get realEstateTypeList => _realEstateTypeList;
  String? get errorMessage => _errorMessage;
  String? get successMessage => _successMessage;
  RealEstateTypeDataSource get realEstateTypeDataSource => _realEstateTypeDataSource;

  bool get hasData => _realEstateTypeList.isNotEmpty;

  RealEstateTypeProvider() {
    fetchRealEstateTypesFromAPI();
  }

  Future<void> fetchRealEstateTypesFromAPI() async {
    if (_realEstateTypeList.isNotEmpty) {
      print("Data is already loaded.");
      return;
    }
    print("Fetching real estate types...");

    try {
      final url = staticVar.urlAPI + 'real_estate_type/Action';
      final headers = {
        'ApplicationAccessKey': 'V2-HPwgN-t1nZA-pHXjA-5UBkc-NAVkh-vRq9F-zPDFW-WMFY1',
        'Content-Type': 'application/json',
      };
      final body = jsonEncode({"Action": "Find", "Rows": []});
      final response = await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        List<RealEstateTypeModel> realEstateTypeListHelper = [];

        for (var item in data) {
          RealEstateTypeModel realEstateType = RealEstateTypeModel(
            real_estate_type: item['real_estate_type'] ?? 'NOTFOUND',
          );
          realEstateTypeListHelper.add(realEstateType);
        }

        _realEstateTypeList = realEstateTypeListHelper;
        _realEstateTypeDataSource = RealEstateTypeDataSource(realEstateTypes: _realEstateTypeList);
        notifyListeners();
      } else {
        throw Exception("Failed to fetch real estate types. ${response.body}");
      }
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> addRealEstateType(Map<String, dynamic> data) async {
    try {
      final url = staticVar.urlAPI + 'real_estate_type/Action';
      final headers = {
        'ApplicationAccessKey': 'V2-HPwgN-t1nZA-pHXjA-5UBkc-NAVkh-vRq9F-zPDFW-WMFY1',
        'Content-Type': 'application/json',
      };
      final body = jsonEncode({
        "Action": "Add",
        "Rows": [{'real_estate_type': data['real_estate_type']}]
      });

      final response = await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        RealEstateTypeModel newRealEstateType = RealEstateTypeModel(
          real_estate_type: data['real_estate_type'],
        );
        _realEstateTypeList.add(newRealEstateType);
        _realEstateTypeDataSource = RealEstateTypeDataSource(realEstateTypes: _realEstateTypeList);
        _successMessage = 'Real estate type added successfully!';
        notifyListeners();
      } else {
        throw Exception("Failed to add real estate type. ${response.body}");
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

