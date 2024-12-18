import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../models/botLVL/VehicleRegistrationNumberModel.dart';
import '../../models/staticVar.dart';

class VehicleRegistrationNumberProvider with ChangeNotifier {
  List<VehicleRegistrationNumberModel> _vehicleRegistrationNumberList = [];
  late VehicleRegistrationNumberDataSource _vehicleRegistrationNumberDataSource;
  String? _errorMessage;
  String? _successMessage;

  // Getters
  List<VehicleRegistrationNumberModel> get vehicleRegistrationNumberList => _vehicleRegistrationNumberList;
  String? get errorMessage => _errorMessage;
  String? get successMessage => _successMessage;
  VehicleRegistrationNumberDataSource get vehicleRegistrationNumberDataSource => _vehicleRegistrationNumberDataSource;

  bool get hasData => _vehicleRegistrationNumberList.isNotEmpty;

  VehicleRegistrationNumberProvider() {
    fetchVehicleRegistrationNumbersFromAPI();
  }

  Future<void> fetchVehicleRegistrationNumbersFromAPI() async {
    if (_vehicleRegistrationNumberList.isNotEmpty) {
      print("Data is already loaded.");
      return;
    }
    print("Fetching vehicle registration numbers...");

    try {
      final url = staticVar.urlAPI + 'vehicle_registration_number/Action';
      final headers = {
        'ApplicationAccessKey': 'V2-HPwgN-t1nZA-pHXjA-5UBkc-NAVkh-vRq9F-zPDFW-WMFY1',
        'Content-Type': 'application/json',
      };
      final body = jsonEncode({"Action": "Find", "Rows": []});
      final response = await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        List<VehicleRegistrationNumberModel> vehicleRegistrationNumberListHelper = [];

        for (var item in data) {
          VehicleRegistrationNumberModel vehicleRegistrationNumber = VehicleRegistrationNumberModel(
            vehicle_registration_number: item['vehicle_registration_number'] ?? 'NOTFOUND',
          );
          vehicleRegistrationNumberListHelper.add(vehicleRegistrationNumber);
        }

        _vehicleRegistrationNumberList = vehicleRegistrationNumberListHelper;
        _vehicleRegistrationNumberDataSource = VehicleRegistrationNumberDataSource(vehicleRegistrationNumbers: _vehicleRegistrationNumberList);
        notifyListeners();
      } else {
        throw Exception("Failed to fetch vehicle registration numbers. ${response.body}");
      }
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> addVehicleRegistrationNumber(Map<String, dynamic> data) async {
    try {
      final url = staticVar.urlAPI + 'vehicle_registration_number/Action';
      final headers = {
        'ApplicationAccessKey': 'V2-HPwgN-t1nZA-pHXjA-5UBkc-NAVkh-vRq9F-zPDFW-WMFY1',
        'Content-Type': 'application/json',
      };
      final body = jsonEncode({
        "Action": "Add",
        "Rows": [{'vehicle_registration_number': data['vehicle_registration_number']}]
      });

      final response = await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        VehicleRegistrationNumberModel newVehicleRegistrationNumber = VehicleRegistrationNumberModel(
          vehicle_registration_number: data['vehicle_registration_number'],
        );
        _vehicleRegistrationNumberList.add(newVehicleRegistrationNumber);
        _vehicleRegistrationNumberDataSource = VehicleRegistrationNumberDataSource(vehicleRegistrationNumbers: _vehicleRegistrationNumberList);
        _successMessage = 'Vehicle registration number added successfully!';
        notifyListeners();
      } else {
        throw Exception("Failed to add vehicle registration number. ${response.body}");
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

