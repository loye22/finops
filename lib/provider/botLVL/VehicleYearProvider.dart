import 'dart:convert';
import 'package:finops/models/botLVL/VehicleYearModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


import '../../models/staticVar.dart';

class VehicleYearProvider with ChangeNotifier {
  List<VehicleYearModel> _vehicleYearList = [];
  late VehicleYearDataSource _vehicleYearDataSource;
  String? _errorMessage;
  String? _successMessage;

  // Getters
  List<VehicleYearModel> get vehicleYearList => _vehicleYearList;
  String? get errorMessage => _errorMessage;
  String? get successMessage => _successMessage;
  VehicleYearDataSource get vehicleYearDataSource => _vehicleYearDataSource;

  bool get hasData => _vehicleYearList.isNotEmpty;

  VehicleYearProvider() {
    fetchVehicleYearsFromAPI();
  }

  Future<void> fetchVehicleYearsFromAPI() async {
    if (_vehicleYearList.isNotEmpty) {
      print("Data is already loaded.");
      return;
    }
    print("Fetching vehicle years...");

    try {
      final url = staticVar.urlAPI + 'vehicle_year/Action';
      final headers = {
        'ApplicationAccessKey': 'V2-HPwgN-t1nZA-pHXjA-5UBkc-NAVkh-vRq9F-zPDFW-WMFY1',
        'Content-Type': 'application/json',
      };
      final body = jsonEncode({"Action": "Find", "Rows": []});
      final response = await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        List<VehicleYearModel> vehicleYearListHelper = [];

        for (var item in data) {
          VehicleYearModel vehicleYear = VehicleYearModel(
            vehicle_year: item['vehicle_year'] ?? 'NOTFOUND',
          );
          vehicleYearListHelper.add(vehicleYear);
        }

        _vehicleYearList = vehicleYearListHelper;
        _vehicleYearDataSource = VehicleYearDataSource(vehicleYears: _vehicleYearList);
        notifyListeners();
      } else {
        throw Exception("Failed to fetch vehicle years. ${response.body}");
      }
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> addVehicleYear(Map<String, dynamic> data) async {
    try {
      final url = staticVar.urlAPI + 'vehicle_year/Action';
      final headers = {
        'ApplicationAccessKey': 'V2-HPwgN-t1nZA-pHXjA-5UBkc-NAVkh-vRq9F-zPDFW-WMFY1',
        'Content-Type': 'application/json',
      };
      final body = jsonEncode({
        "Action": "Add",
        "Rows": [{'vehicle_year': data['vehicle_year']}]
      });

      final response = await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        VehicleYearModel newVehicleYear = VehicleYearModel(
          vehicle_year: data['vehicle_year'],
        );
        _vehicleYearList.add(newVehicleYear);
        _vehicleYearDataSource = VehicleYearDataSource(vehicleYears: _vehicleYearList);
        _successMessage = 'Vehicle year added successfully!';
        notifyListeners();
      } else {
        throw Exception("Failed to add vehicle year. ${response.body}");
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

