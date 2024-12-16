import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/UtilityCalculationTypeModel.dart';
import '../models/staticVar.dart';

class UtilityCalculationTypeProvider with ChangeNotifier {
  List<UtilityCalculationTypeModel> _utilityCalculationTypeList = [];
  late UtilityCalculationTypeDataSource _utilityCalculationTypeDataSource;
  String? _errorMessage;
  String? _successMessage;

  // Getters
  List<UtilityCalculationTypeModel> get utilityCalculationTypeList => _utilityCalculationTypeList;
  String? get errorMessage => _errorMessage;
  String? get successMessage => _successMessage;
  UtilityCalculationTypeDataSource get utilityCalculationTypeDataSource => _utilityCalculationTypeDataSource;

  bool get hasData => _utilityCalculationTypeList.isNotEmpty;

  UtilityCalculationTypeProvider() {
    fetchUtilityCalculationTypesFromAPI();
  }

  Future<void> fetchUtilityCalculationTypesFromAPI() async {
    if (_utilityCalculationTypeList.isNotEmpty) {
      print("Data is already loaded.");
      return;
    }
    print("Fetching utility calculation types...");

    try {
      final url = staticVar.urlAPI + 'utility_calculation_type/Action';
      final headers = {
        'ApplicationAccessKey': 'V2-HPwgN-t1nZA-pHXjA-5UBkc-NAVkh-vRq9F-zPDFW-WMFY1',
        'Content-Type': 'application/json',
      };
      final body = jsonEncode({"Action": "Find", "Rows": []});
      final response = await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        List<UtilityCalculationTypeModel> utilityCalculationTypeListHelper = [];

        for (var item in data) {
          UtilityCalculationTypeModel utilityCalculationType = UtilityCalculationTypeModel(
            utility_calculation_type: item['utility_calculation_type'] ?? 'NOTFOUND',
          );
          utilityCalculationTypeListHelper.add(utilityCalculationType);
        }

        _utilityCalculationTypeList = utilityCalculationTypeListHelper;
        _utilityCalculationTypeDataSource = UtilityCalculationTypeDataSource(utilityCalculationTypes: _utilityCalculationTypeList);
        notifyListeners();
      } else {
        throw Exception("Failed to fetch utility calculation types. ${response.body}");
      }
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> addUtilityCalculationType(Map<String, dynamic> data) async {
    try {
      final url = staticVar.urlAPI + 'utility_calculation_type/Action';
      final headers = {
        'ApplicationAccessKey': 'V2-HPwgN-t1nZA-pHXjA-5UBkc-NAVkh-vRq9F-zPDFW-WMFY1',
        'Content-Type': 'application/json',
      };
      final body = jsonEncode({
        "Action": "Add",
        "Rows": [{'utility_calculation_type': data['utility_calculation_type']}]
      });

      final response = await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        UtilityCalculationTypeModel newUtilityCalculationType = UtilityCalculationTypeModel(
          utility_calculation_type: data['utility_calculation_type'],
        );
        _utilityCalculationTypeList.add(newUtilityCalculationType);
        _utilityCalculationTypeDataSource = UtilityCalculationTypeDataSource(utilityCalculationTypes: _utilityCalculationTypeList);
        _successMessage = 'Utility calculation type added successfully!';
        notifyListeners();
      } else {
        throw Exception("Failed to add utility calculation type. ${response.body}");
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
