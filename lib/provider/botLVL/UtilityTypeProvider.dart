import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../models/botLVL/UtilityTypeModel.dart';
import '../../models/staticVar.dart';

class UtilityTypeProvider with ChangeNotifier {
  List<UtilityTypeModel> _utilityList = [];
  late UtilityTypeDataSource _utilityTypeDataSource;
  String? _errorMessage;
  String? _successMessage;

  // Getters
  List<UtilityTypeModel> get utilityList => _utilityList;
  String? get errorMessage => _errorMessage;
  String? get successMessage => _successMessage;
  UtilityTypeDataSource get utilityTypeDataSource => _utilityTypeDataSource;

  bool get hasData => _utilityList.isNotEmpty;

  UtilityTypeProvider() {
    fetchUtilityTypesFromAPI();
  }

  Future<void> fetchUtilityTypesFromAPI() async {
    if (_utilityList.isNotEmpty) {
      print("Data is already loaded.");
      return;
    }
    print("Fetching utility types...");

    try {
      final url = staticVar.urlAPI + 'utility_type/Action';
      final headers = {
        'ApplicationAccessKey': 'V2-HPwgN-t1nZA-pHXjA-5UBkc-NAVkh-vRq9F-zPDFW-WMFY1',
        'Content-Type': 'application/json',
      };
      final body = jsonEncode({"Action": "Find", "Rows": []});
      final response = await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        List<UtilityTypeModel> utilityListHelper = [];

        for (var item in data) {
          UtilityTypeModel utility = UtilityTypeModel(
            utility_type: item['utility_type'] ?? 'NOTFOUND',
            utility_type_description: item['utility_type_description'] ?? 'No Description',
          );
          utilityListHelper.add(utility);
        }

        _utilityList = utilityListHelper;
        _utilityTypeDataSource = UtilityTypeDataSource(utilities: _utilityList);
        notifyListeners();
      } else {
        throw Exception("Failed to fetch utility types. ${response.body}");
      }
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> addUtilityType(Map<String, dynamic> data) async {
    try {
      final url = staticVar.urlAPI + 'utility_type/Action';
      final headers = {
        'ApplicationAccessKey': 'V2-HPwgN-t1nZA-pHXjA-5UBkc-NAVkh-vRq9F-zPDFW-WMFY1',
        'Content-Type': 'application/json',
      };
      final body = jsonEncode({
        "Action": "Add",
        "Rows": [
          {
            'utility_type': data['utility_type'],
            'utility_type_description': data['utility_type_description'],
          }
        ]
      });

      final response = await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        UtilityTypeModel newUtility = UtilityTypeModel(
          utility_type: data['utility_type'],
          utility_type_description: data['utility_type_description'],
        );
        _utilityList.add(newUtility);
        _utilityTypeDataSource = UtilityTypeDataSource(utilities: _utilityList);
        _successMessage = 'Utility type added successfully!';
        notifyListeners();
      } else {
        throw Exception("Failed to add utility type. ${response.body}");
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

