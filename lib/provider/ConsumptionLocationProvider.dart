import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/botLVL/ConsumptionLocationModel.dart';
import '../models/staticVar.dart';

class ConsumptionLocationProvider with ChangeNotifier {
  List<ConsumptionLocationModel> _consumptionLocationList = [];
  late ConsumptionLocationDataSource _consumptionLocationDataSource;
  String? _errorMessage;
  String? _successMessage;

  // Getters
  List<ConsumptionLocationModel> get consumptionLocationList => _consumptionLocationList;
  String? get errorMessage => _errorMessage;
  String? get successMessage => _successMessage;
  ConsumptionLocationDataSource get consumptionLocationDataSource => _consumptionLocationDataSource;

  bool get hasData => _consumptionLocationList.isNotEmpty;

  ConsumptionLocationProvider() {
    fetchConsumptionLocationsFromAPI();
  }

  Future<void> fetchConsumptionLocationsFromAPI() async {
    if (_consumptionLocationList.isNotEmpty) {
      print("Data is already loaded.");
      return;
    }
    print("Fetching consumption locations...");

    try {
      final url = staticVar.urlAPI + 'consumption_location/Action';
      final headers = {
        'ApplicationAccessKey': 'V2-HPwgN-t1nZA-pHXjA-5UBkc-NAVkh-vRq9F-zPDFW-WMFY1',
        'Content-Type': 'application/json',
      };
      final body = jsonEncode({"Action": "Find", "Rows": []});
      final response = await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        List<ConsumptionLocationModel> consumptionLocationListHelper = [];

        for (var item in data) {
          ConsumptionLocationModel consumptionLocation = ConsumptionLocationModel(
            consumption_location: item['consumption_location'] ?? 'NOTFOUND',
          );
          consumptionLocationListHelper.add(consumptionLocation);
        }

        _consumptionLocationList = consumptionLocationListHelper;
        _consumptionLocationDataSource = ConsumptionLocationDataSource(consumptionLocations: _consumptionLocationList);
        notifyListeners();
      } else {
        throw Exception("Failed to fetch consumption locations. ${response.body}");
      }
    } catch (e)      {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> addConsumptionLocation(Map<String, dynamic> data) async {
    try {
      final url = staticVar.urlAPI + 'consumption_location/Action';
      final headers = {
        'ApplicationAccessKey': 'V2-HPwgN-t1nZA-pHXjA-5UBkc-NAVkh-vRq9F-zPDFW-WMFY1',
        'Content-Type': 'application/json',
      };
      final body = jsonEncode({
        "Action": "Add",
        "Rows": [{'consumption_location': data['consumption_location']}]
      });

      final response = await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        ConsumptionLocationModel newConsumptionLocation = ConsumptionLocationModel(
          consumption_location: data['consumption_location'],
        );
        _consumptionLocationList.add(newConsumptionLocation);
        _consumptionLocationDataSource = ConsumptionLocationDataSource(consumptionLocations: _consumptionLocationList);
        _successMessage = 'Consumption location added successfully!';
        notifyListeners();
      } else {
        throw Exception("Failed to add consumption location. ${response.body}");
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

