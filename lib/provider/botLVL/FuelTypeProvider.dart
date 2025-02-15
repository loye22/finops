import 'dart:convert';
import 'package:finops/models/botLVL/FuelTypeModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


import '../../models/staticVar.dart';

class FuelTypeProvider with ChangeNotifier {
  List<FuelTypeModel> _fuelTypeList = [];
  late FuelTypeDataSource _fuelTypeDataSource;
  String? _errorMessage;
  String? _successMessage;

  // Getters
  List<FuelTypeModel> get fuelTypeList => _fuelTypeList;
  String? get errorMessage => _errorMessage;
  String? get successMessage => _successMessage;
  FuelTypeDataSource get fuelTypeDataSource => _fuelTypeDataSource;

  bool get hasData => _fuelTypeList.isNotEmpty;

  FuelTypeProvider() {
    fetchFuelTypesFromAPI();
  }

  Future<void> fetchFuelTypesFromAPI() async {
    if (_fuelTypeList.isNotEmpty) {
      print("Data is already loaded.");
      return;
    }
    print("Fetching fuel types...");

    try {
      final url = staticVar.urlAPI + 'fuel_type/Action';
      final headers = {
        'ApplicationAccessKey': 'V2-HPwgN-t1nZA-pHXjA-5UBkc-NAVkh-vRq9F-zPDFW-WMFY1',
        'Content-Type': 'application/json',
      };
      final body = jsonEncode({"Action": "Find", "Rows": []});
      final response = await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        List<FuelTypeModel> fuelTypeListHelper = [];

        for (var item in data) {
          FuelTypeModel fuelType = FuelTypeModel(
            fuel_type: item['fuel_type'] ?? 'NOTFOUND',
          );
          fuelTypeListHelper.add(fuelType);
        }

        _fuelTypeList = fuelTypeListHelper;
        _fuelTypeDataSource = FuelTypeDataSource(fuelTypes: _fuelTypeList);
        notifyListeners();
      } else {
        throw Exception("Failed to fetch fuel types. ${response.body}");
      }
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> addFuelType(Map<String, dynamic> data) async {
    try {
      final url = staticVar.urlAPI + 'fuel_type/Action';
      final headers = {
        'ApplicationAccessKey': 'V2-HPwgN-t1nZA-pHXjA-5UBkc-NAVkh-vRq9F-zPDFW-WMFY1',
        'Content-Type': 'application/json',
      };
      final body = jsonEncode({
        "Action": "Add",
        "Rows": [{'fuel_type': data['fuel_type']}]
      });

      final response = await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        FuelTypeModel newFuelType = FuelTypeModel(
          fuel_type: data['fuel_type'],
        );
        _fuelTypeList.add(newFuelType);
        _fuelTypeDataSource = FuelTypeDataSource(fuelTypes: _fuelTypeList);
        _successMessage = 'Fuel type added successfully!';
        notifyListeners();
      } else {
        throw Exception("Failed to add fuel type. ${response.body}");
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

