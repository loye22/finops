import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/UnitMeasureModel.dart';
import '../models/staticVar.dart';

class UnitMeasureProvider with ChangeNotifier {
  List<UnitMeasureModel> _unitMeasureList = [];
  late UnitMeasureDataSource _unitMeasureDataSource;
  String? _errorMessage;
  String? _successMessage;

  // Getters
  List<UnitMeasureModel> get unitMeasureList => _unitMeasureList;
  String? get errorMessage => _errorMessage;
  String? get successMessage => _successMessage;
  UnitMeasureDataSource get unitMeasureDataSource => _unitMeasureDataSource;

  bool get hasData => _unitMeasureList.isNotEmpty;

  UnitMeasureProvider() {
    fetchUnitMeasuresFromAPI();
  }

  Future<void> fetchUnitMeasuresFromAPI() async {
    if (_unitMeasureList.isNotEmpty) {
      print("Data is already loaded.");
      return;
    }
    print("Fetching unit measures...");

    try {
      final url = staticVar.urlAPI + 'unit_measure/Action';
      final headers = {
        'ApplicationAccessKey': 'V2-HPwgN-t1nZA-pHXjA-5UBkc-NAVkh-vRq9F-zPDFW-WMFY1',
        'Content-Type': 'application/json',
      };
      final body = jsonEncode({"Action": "Find", "Rows": []});
      final response = await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        List<UnitMeasureModel> unitMeasureListHelper = [];

        for (var item in data) {
          UnitMeasureModel unitMeasure = UnitMeasureModel(
            unit_measure: item['unit_measure'] ?? 'NOTFOUND',
          );
          unitMeasureListHelper.add(unitMeasure);
        }

        _unitMeasureList = unitMeasureListHelper;
        _unitMeasureDataSource = UnitMeasureDataSource(unitMeasures: _unitMeasureList);
        notifyListeners();
      } else {
        throw Exception("Failed to fetch unit measures. ${response.body}");
      }
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> addUnitMeasure(Map<String, dynamic> data) async {
    try {
      final url = staticVar.urlAPI + 'unit_measure/Action';
      final headers = {
        'ApplicationAccessKey': 'V2-HPwgN-t1nZA-pHXjA-5UBkc-NAVkh-vRq9F-zPDFW-WMFY1',
        'Content-Type': 'application/json',
      };
      final body = jsonEncode({
        "Action": "Add",
        "Rows": [{'unit_measure': data['unit_measure']}]
      });

      final response = await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        UnitMeasureModel newUnitMeasure = UnitMeasureModel(
          unit_measure: data['unit_measure'],
        );
        _unitMeasureList.add(newUnitMeasure);
        _unitMeasureDataSource = UnitMeasureDataSource(unitMeasures: _unitMeasureList);
        _successMessage = 'Unit measure added successfully!';
        notifyListeners();
      } else {
        throw Exception("Failed to add unit measure. ${response.body}");
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
