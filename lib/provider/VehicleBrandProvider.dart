import 'dart:convert';
import 'package:finops/models/botLVL/VehicleBrandModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/staticVar.dart';

class VehicleBrandProvider with ChangeNotifier {
  List<VehicleBrandModel> _vehicleBrandList = [];
  late VehicleBrandDataSource _vehicleBrandDataSource;
  String? _errorMessage;
  String? _successMessage;

  // Getters
  List<VehicleBrandModel> get vehicleBrandList => _vehicleBrandList;
  String? get errorMessage => _errorMessage;
  String? get successMessage => _successMessage;
  VehicleBrandDataSource get vehicleBrandDataSource => _vehicleBrandDataSource;

  bool get hasData => _vehicleBrandList.isNotEmpty;

  VehicleBrandProvider() {
    fetchVehicleBrandsFromAPI();
  }

  Future<void> fetchVehicleBrandsFromAPI() async {
    if (_vehicleBrandList.isNotEmpty) {
      print("Data is already loaded.");
      return;
    }
    print("Fetching vehicle brands...");

    try {
      final url = staticVar.urlAPI + 'vehicle_brand/Action';
      final headers = {
        'ApplicationAccessKey': 'V2-HPwgN-t1nZA-pHXjA-5UBkc-NAVkh-vRq9F-zPDFW-WMFY1',
        'Content-Type': 'application/json',
      };
      final body = jsonEncode({"Action": "Find", "Rows": []});
      final response = await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        List<VehicleBrandModel> vehicleBrandListHelper = [];

        for (var item in data) {
          VehicleBrandModel vehicleBrand = VehicleBrandModel(
            vehicle_brand: item['vehicle_brand'] ?? 'NOTFOUND',
          );
          vehicleBrandListHelper.add(vehicleBrand);
        }

        _vehicleBrandList = vehicleBrandListHelper;
        _vehicleBrandDataSource = VehicleBrandDataSource(vehicleBrands: _vehicleBrandList);
        notifyListeners();
      } else {
        throw Exception("Failed to fetch vehicle brands. ${response.body}");
      }
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> addVehicleBrand(Map<String, dynamic> data) async {
    try {
      final url = staticVar.urlAPI + 'vehicle_brand/Action';
      final headers = {
        'ApplicationAccessKey': 'V2-HPwgN-t1nZA-pHXjA-5UBkc-NAVkh-vRq9F-zPDFW-WMFY1',
        'Content-Type': 'application/json',
      };
      final body = jsonEncode({
        "Action": "Add",
        "Rows": [{'vehicle_brand': data['vehicle_brand']}]
      });

      final response = await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        VehicleBrandModel newVehicleBrand = VehicleBrandModel(
          vehicle_brand: data['vehicle_brand'],
        );
        _vehicleBrandList.add(newVehicleBrand);
        _vehicleBrandDataSource = VehicleBrandDataSource(vehicleBrands: _vehicleBrandList);
        _successMessage = 'Vehicle brand added successfully!';
        notifyListeners();
      } else {
        throw Exception("Failed to add vehicle brand. ${response.body}");
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

