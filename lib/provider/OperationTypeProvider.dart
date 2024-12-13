import 'dart:convert';
import 'package:finops/models/OperationTypeModel.dart';
import 'package:finops/models/staticVar.dart';
import 'package:finops/widgets/ErrorDialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OperationTypeProvider with ChangeNotifier {
  List<OperationTypeModel> _operationTypesList = [];
  late OperationTypeDataSource _operationTypeDataSource;
  String? _errorMessage;
  // Getter for error message
  String? get errorMessage => _errorMessage;

  String? _successMessage;
  String? get successMessage => _successMessage;


  OperationTypeDataSource get operationTypeDataSource =>
      _operationTypeDataSource;

  bool get hasData => _operationTypesList.isNotEmpty;

  OperationTypeProvider() {
    fetchOperationTypesFromAppSheet();
  }

  Future<void> fetchOperationTypesFromAppSheet() async {
    if (_operationTypesList.isNotEmpty) {
      print("Data is already loaded from the provider.");
      return;
    }
    print("Calling the AppSheet API for operation types...");

    try {
      final url = staticVar.urlAPI + 'operation_type/Action';
      final headers = {
        'ApplicationAccessKey':
            'V2-HPwgN-t1nZA-pHXjA-5UBkc-NAVkh-vRq9F-zPDFW-WMFY1',
        'Content-Type': 'application/json',
      };
      final body = jsonEncode({"Action": "Find", "Properties": {}, "Rows": []});
      final response =
          await http.post(Uri.parse(url), headers: headers, body: body);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        List<OperationTypeModel> operationTypesListHelper = [];

        for (var item in data) {
          OperationTypeModel operationType = OperationTypeModel(
            operation_type: item['operation_type'] ?? 'NOTFOUND',
          );
          operationTypesListHelper.add(operationType);
        }

        _operationTypesList = operationTypesListHelper;
        _operationTypeDataSource =
            OperationTypeDataSource(operationTypes: _operationTypesList);
        notifyListeners();
      } else {
        throw Exception("Failed to fetch operation types. ${response.body}");
        print('Failed to load operation types: ${response.reasonPhrase}');
      }
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners(); // Notify the UI about the error
      print('Error fetching operation types from AppSheet API: $e');
    }
  }

// Function to add a new operation type
  Future<void> addOperation(Map<String, dynamic> data) async {
    try {
      final url = staticVar.urlAPI + 'operation_type/Action';
      final headers = {
        'ApplicationAccessKey':
        'V2-HPwgN-t1nZA-pHXjA-5UBkc-NAVkh-vRq9F-zPDFW-WMFY1',
        'Content-Type': 'application/json',
      };
      final body = jsonEncode({
        "Action": "Add",
        "Properties": {},  // Passing the dynamic map as properties
        "Rows": [ {'operation_type': data['operation_type']}]
      });

      final response = await http.post(Uri.parse(url), headers: headers, body: body);
      print('LVL response : ${response.reasonPhrase}');

      if (response.statusCode == 200) {
        // Create the new operation type model object
        OperationTypeModel newOperationType = OperationTypeModel(
          operation_type: data['operation_type'], // Set the operation type from the data map
        );

        // Add the new operation type to the local list
        _operationTypesList.add(newOperationType);

        // Update the data source
        _operationTypeDataSource = OperationTypeDataSource(operationTypes: _operationTypesList);
        _successMessage = 'Tipul de operațiune a fost adăugat cu succes!';

        // Notify listeners to update the UI
        notifyListeners();
        print('Operation type added successfully and updated in the list.');
      } else {
        print('Failed to add operation type: ${response.body}');
        throw Exception("Failed to add operation type. ${response.body}");

      }
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      print('Error adding operation type: $e');
    }
  }

  void clearSuccessMessage() {
    _successMessage = null;
    notifyListeners();
  }

  // Clear the error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  Future<void> refreshData() async {
    _operationTypesList = [];
    await fetchOperationTypesFromAppSheet();
  }
}
