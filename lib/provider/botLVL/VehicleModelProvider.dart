import 'dart:convert';
import 'package:finops/models/botLVL/VehicleModel.dart';
import 'package:finops/models/staticVar.dart';
import 'package:finops/provider/botLVL/VehicleBrandProvider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



class VehicleModelProvider with ChangeNotifier {
  List<VehicleModel> _vehicleModelList = [];
  late VehicleModelDataSource _vehicleModelDataSource;
  String? _errorMessage;
  String? _successMessage;

  // Getters
  List<VehicleModel> get vehicleModelList => _vehicleModelList;
  String? get errorMessage => _errorMessage;
  String? get successMessage => _successMessage;
  VehicleModelDataSource get vehicleModelDataSource => _vehicleModelDataSource;

  bool get hasData => _vehicleModelList.isNotEmpty;

  VehicleModelProvider() {
    fetchVehicleModelsFromAPI();
  }

  Future<void> fetchVehicleModelsFromAPI() async {
    if (_vehicleModelList.isNotEmpty) {
      print("Data is already loaded.");
      return;
    }
    print("Fetching vehicle models...");

    try {
      final url = staticVar.urlAPI + 'vehicle_model/Action';
      final headers = {
        'ApplicationAccessKey': 'V2-HPwgN-t1nZA-pHXjA-5UBkc-NAVkh-vRq9F-zPDFW-WMFY1',
        'Content-Type': 'application/json',
      };
      final body = jsonEncode({"Action": "Find", "Rows": []});
      final response = await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        List<VehicleModel> vehicleModelListHelper = [];

        for (var item in data) {
          VehicleModel vehicleModel = VehicleModel(
            vehicle_model: item['vehicle_model'] ?? 'NOTFOUND',
            vehicle_brand: item['vehicle_brand'] ?? 'NOTFOUND',
          );
          vehicleModelListHelper.add(vehicleModel);
        }

        _vehicleModelList = vehicleModelListHelper;
        _vehicleModelDataSource = VehicleModelDataSource(vehicleModels: _vehicleModelList);
        notifyListeners();
      } else {
        throw Exception("Failed to fetch vehicle models. ${response.body}");
      }
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> addVehicleModel(Map<String, dynamic> data) async {
    try {
      final url = staticVar.urlAPI + 'vehicle_model/Action';
      final headers = {
        'ApplicationAccessKey': 'V2-HPwgN-t1nZA-pHXjA-5UBkc-NAVkh-vRq9F-zPDFW-WMFY1',
        'Content-Type': 'application/json',
      };
      final body = jsonEncode({
        "Action": "Add",
        "Rows": [
          {
            'vehicle_model': data['vehicle_model'],
            'vehicle_brand': data['vehicle_brand'],
          }
        ]
      });

      final response = await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        VehicleModel newVehicleModel = VehicleModel(
          vehicle_model: data['vehicle_model'],
          vehicle_brand: data['vehicle_brand'],
        );
        _vehicleModelList.add(newVehicleModel);
        _vehicleModelDataSource = VehicleModelDataSource(vehicleModels: _vehicleModelList);
        _successMessage = 'Vehicle model added successfully!';
        notifyListeners();
      } else {
        throw Exception("Failed to add vehicle model. ${response.body}");
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

