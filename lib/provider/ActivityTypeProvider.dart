import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/ActivityTypeModel.dart';
import '../models/staticVar.dart';

class ActivityTypeProvider with ChangeNotifier {
  List<ActivityTypeModel> _activityTypeList = [];
  late ActivityTypeDataSource _activityTypeDataSource;
  String? _errorMessage;
  String? _successMessage;

  // Getters
  List<ActivityTypeModel> get activityTypeList => _activityTypeList;
  String? get errorMessage => _errorMessage;
  String? get successMessage => _successMessage;
  ActivityTypeDataSource get activityTypeDataSource => _activityTypeDataSource;

  bool get hasData => _activityTypeList.isNotEmpty;

  ActivityTypeProvider() {
    fetchActivityTypesFromAPI();
  }

  Future<void> fetchActivityTypesFromAPI() async {
    if (_activityTypeList.isNotEmpty) {
      print("Data is already loaded.");
      return;
    }
    print("Fetching activity types...");

    try {
      final url = staticVar.urlAPI + 'activity_type/Action';
      final headers = {
        'ApplicationAccessKey': 'V2-HPwgN-t1nZA-pHXjA-5UBkc-NAVkh-vRq9F-zPDFW-WMFY1',
        'Content-Type': 'application/json',
      };
      final body = jsonEncode({"Action": "Find", "Rows": []});
      final response = await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        List<ActivityTypeModel> activityTypeListHelper = [];

        for (var item in data) {
          ActivityTypeModel activityType = ActivityTypeModel(
            activity_type: item['activity_type'] ?? 'NOTFOUND',
          );
          activityTypeListHelper.add(activityType);
        }

        _activityTypeList = activityTypeListHelper;
        _activityTypeDataSource = ActivityTypeDataSource(activityTypes: _activityTypeList);
        notifyListeners();
      } else {
        throw Exception("Failed to fetch activity types. ${response.body}");
      }
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> addActivityType(Map<String, dynamic> data) async {
    try {
      final url = staticVar.urlAPI + 'activity_type/Action';
      final headers = {
        'ApplicationAccessKey': 'V2-HPwgN-t1nZA-pHXjA-5UBkc-NAVkh-vRq9F-zPDFW-WMFY1',
        'Content-Type': 'application/json',
      };
      final body = jsonEncode({
        "Action": "Add",
        "Rows": [{'activity_type': data['activity_type']}]
      });

      final response = await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        ActivityTypeModel newActivityType = ActivityTypeModel(
          activity_type: data['activity_type'],
        );
        _activityTypeList.add(newActivityType);
        _activityTypeDataSource = ActivityTypeDataSource(activityTypes: _activityTypeList);
        _successMessage = 'Activity type added successfully!';
        notifyListeners();
      } else {
        throw Exception("Failed to add activity type. ${response.body}");
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

