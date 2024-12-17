import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/botLVL/InsuranceTypeModel.dart';
import '../models/staticVar.dart';

class InsuranceTypeProvider with ChangeNotifier {
  List<InsuranceTypeModel> _insuranceTypeList = [];
  late InsuranceTypeDataSource _insuranceTypeDataSource;
  String? _errorMessage;
  String? _successMessage;

  // Getters
  List<InsuranceTypeModel> get insuranceTypeList => _insuranceTypeList;
  String? get errorMessage => _errorMessage;
  String? get successMessage => _successMessage;
  InsuranceTypeDataSource get insuranceTypeDataSource => _insuranceTypeDataSource;

  bool get hasData => _insuranceTypeList.isNotEmpty;

  InsuranceTypeProvider() {
    fetchInsuranceTypesFromAPI();
  }

  Future<void> fetchInsuranceTypesFromAPI() async {
    if (_insuranceTypeList.isNotEmpty) {
      print("Data is already loaded.");
      return;
    }
    print("Fetching insurance types...");

    try {
      final url = staticVar.urlAPI + 'insurance_type/Action';
      final headers = {
        'ApplicationAccessKey': 'V2-HPwgN-t1nZA-pHXjA-5UBkc-NAVkh-vRq9F-zPDFW-WMFY1',
        'Content-Type': 'application/json',
      };
      final body = jsonEncode({"Action": "Find", "Rows": []});
      final response = await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        List<InsuranceTypeModel> insuranceTypeListHelper = [];

        for (var item in data) {
          InsuranceTypeModel insuranceType = InsuranceTypeModel(
            insurance_type: item['insurance_type'] ?? 'NOTFOUND',
          );
          insuranceTypeListHelper.add(insuranceType);
        }

        _insuranceTypeList = insuranceTypeListHelper;
        _insuranceTypeDataSource = InsuranceTypeDataSource(insuranceTypes: _insuranceTypeList);
        notifyListeners();
      } else {
        throw Exception("Failed to fetch insurance types. ${response.body}");
      }
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> addInsuranceType(Map<String, dynamic> data) async {
    try {
      final url = staticVar.urlAPI + 'insurance_type/Action';
      final headers = {
        'ApplicationAccessKey': 'V2-HPwgN-t1nZA-pHXjA-5UBkc-NAVkh-vRq9F-zPDFW-WMFY1',
        'Content-Type': 'application/json',
      };
      final body = jsonEncode({
        "Action": "Add",
        "Rows": [{'insurance_type': data['insurance_type']}]
      });

      final response = await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        InsuranceTypeModel newInsuranceType = InsuranceTypeModel(
          insurance_type: data['insurance_type'],
        );
        _insuranceTypeList.add(newInsuranceType);
        _insuranceTypeDataSource = InsuranceTypeDataSource(insuranceTypes: _insuranceTypeList);
        _successMessage = 'Insurance type added successfully!';
        notifyListeners();
      } else {
        throw Exception("Failed to add insurance type. ${response.body}");
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

