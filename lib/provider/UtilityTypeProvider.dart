import 'dart:convert';
import 'package:finops/models/UtilityTypeModel.dart';
import 'package:finops/models/staticVar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';



class UtilityTypeProvider with ChangeNotifier {
  List<UtilityTypeModel> _utilityTypesList = []; // Holds the utility types data
  late UtilityTypeDataSource _utilityTypeDataSource;

  // Getter for UtilityTypeDataSource
  UtilityTypeDataSource get utilityTypeDataSource => _utilityTypeDataSource;

  // Check if data has already been fetched
  bool get hasData => _utilityTypesList.isNotEmpty;

  UtilityTypeProvider() {
    fetchUtilityTypesFromAppSheet();
  }

  Future<void> fetchUtilityTypesFromAppSheet() async {
    if (_utilityTypesList.isNotEmpty) {
      print("Data is already loaded from the provider.");
      return;
    }
    print("Calling the AppSheet API...");

    try {
      final url = staticVar.urlAPI + 'utility_type/Action'; // Updated API endpoint
      final headers = {
        'ApplicationAccessKey': 'V2-2dg45-2w8YO-iH13Z-VQ6km-3Trkw-pVerZ-YwCj7-pZDxp',
        'Content-Type': 'application/json',
      };
      final body = jsonEncode({
        "Action": "Find",
        "Properties": {},
        "Rows": []
      });

      // Make the API call
      final response = await http.post(Uri.parse(url), headers: headers, body: body);


     // print('response.statusCode : ${response.statusCode}');
     // print(response.body);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);


        List<UtilityTypeModel> utilityTypesListHelper = [];

        for (var item in data) {
          UtilityTypeModel utilityType = UtilityTypeModel(
            utility_type: item['utility_type'] ?? 'NOTFOUND',
            utility_type_description: item['utility_type_description'] ?? 'NOTFOUND',
          );
          utilityTypesListHelper.add(utilityType);
        }

        _utilityTypesList = utilityTypesListHelper;
        _utilityTypeDataSource = UtilityTypeDataSource(utilityTypes: _utilityTypesList);
        notifyListeners();  // Notify UI about changes
      } else {
        print('Failed to load utility types: ${response.reasonPhrase}');
      }
    } catch (e) {

      print('Error fetching utility types from AppSheet API: $e');
    }
  }

  Future<void> refreshData() async {
    _utilityTypesList = [];
    await fetchUtilityTypesFromAppSheet();
  }


}
