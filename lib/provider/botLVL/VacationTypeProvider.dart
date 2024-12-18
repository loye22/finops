import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../models/botLVL/VacationTypeModel.dart';
import '../../models/staticVar.dart';

class VacationTypeProvider with ChangeNotifier {
  List<VacationTypeModel> _vacationTypeList = [];
  late VacationTypeDataSource _vacationTypeDataSource;
  String? _errorMessage;
  String? _successMessage;

  // Getters
  List<VacationTypeModel> get vacationTypeList => _vacationTypeList;
  String? get errorMessage => _errorMessage;
  String? get successMessage => _successMessage;
  VacationTypeDataSource get vacationTypeDataSource => _vacationTypeDataSource;

  bool get hasData => _vacationTypeList.isNotEmpty;

  VacationTypeProvider() {
    fetchVacationTypesFromAPI();
  }

  Future<void> fetchVacationTypesFromAPI() async {
    if (_vacationTypeList.isNotEmpty) {
      print("Data is already loaded.");
      return;
    }
    print("Fetching vacation types...");

    try {
      final url = staticVar.urlAPI + 'vacantion_type/Action';
      final headers = {
        'ApplicationAccessKey': 'V2-HPwgN-t1nZA-pHXjA-5UBkc-NAVkh-vRq9F-zPDFW-WMFY1',
        'Content-Type': 'application/json',
      };
      final body = jsonEncode({"Action": "Find", "Rows": []});
      final response = await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        List<VacationTypeModel> vacationTypeListHelper = [];

        for (var item in data) {
          VacationTypeModel vacationType = VacationTypeModel(
            vacation_type: item['vacantion_type'] ?? 'NOTFOUND',
          );
          vacationTypeListHelper.add(vacationType);
        }

        _vacationTypeList = vacationTypeListHelper;
        _vacationTypeDataSource = VacationTypeDataSource(vacationTypes: _vacationTypeList);
        notifyListeners();
      } else {
        throw Exception("Failed to fetch vacation types. ${response.body}");
      }
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> addVacationType(Map<String, dynamic> data) async {
    try {
      final url = staticVar.urlAPI + 'vacantion_type/Action';
      final headers = {
        'ApplicationAccessKey': 'V2-HPwgN-t1nZA-pHXjA-5UBkc-NAVkh-vRq9F-zPDFW-WMFY1',
        'Content-Type': 'application/json',
      };
      final body = jsonEncode({
        "Action": "Add",
        "Rows": [{'vacantion_type': data['vacantion_type']}]
      });

      final response = await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        VacationTypeModel newVacationType = VacationTypeModel(
          vacation_type: data['vacantion_type'],
        );
        _vacationTypeList.add(newVacationType);
        _vacationTypeDataSource = VacationTypeDataSource(vacationTypes: _vacationTypeList);
        _successMessage = 'Vacation type added successfully!';
        notifyListeners();
      } else {
        throw Exception("Failed to add vacation type. ${response.body}");
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

