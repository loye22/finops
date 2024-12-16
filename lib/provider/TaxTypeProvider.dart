import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/TaxTypeModel.dart';
import '../models/staticVar.dart';

class TaxTypeProvider with ChangeNotifier {
  List<TaxTypeModel> _taxList = [];
  late TaxTypeDataSource _taxTypeDataSource;
  String? _errorMessage;
  String? _successMessage;

  // Getters
  List<TaxTypeModel> get taxList => _taxList;
  String? get errorMessage => _errorMessage;
  String? get successMessage => _successMessage;
  TaxTypeDataSource get taxTypeDataSource => _taxTypeDataSource;

  bool get hasData => _taxList.isNotEmpty;

  TaxTypeProvider() {
    fetchTaxTypesFromAPI();
  }

  Future<void> fetchTaxTypesFromAPI() async {
    if (_taxList.isNotEmpty) {
      print("Data is already loaded.");
      return;
    }
    print("Fetching tax types...");

    try {
      final url = staticVar.urlAPI + 'tax_type/Action';
      final headers = {
        'ApplicationAccessKey': 'V2-HPwgN-t1nZA-pHXjA-5UBkc-NAVkh-vRq9F-zPDFW-WMFY1',
        'Content-Type': 'application/json',
      };
      final body = jsonEncode({"Action": "Find", "Rows": []});
      final response = await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        List<TaxTypeModel> taxListHelper = [];

        for (var item in data) {
          TaxTypeModel tax = TaxTypeModel(
            tax_type: item['tax_type'] ?? 'NOTFOUND',
          );
          taxListHelper.add(tax);
        }

        _taxList = taxListHelper;
        _taxTypeDataSource = TaxTypeDataSource(taxes: _taxList);
        notifyListeners();
      } else {
        throw Exception("Failed to fetch tax types. ${response.body}");
      }
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> addTaxType(Map<String, dynamic> data) async {
    try {
      final url = staticVar.urlAPI + 'tax_type/Action';
      final headers = {
        'ApplicationAccessKey': 'V2-HPwgN-t1nZA-pHXjA-5UBkc-NAVkh-vRq9F-zPDFW-WMFY1',
        'Content-Type': 'application/json',
      };
      final body = jsonEncode({
        "Action": "Add",
        "Rows": [{'tax_type': data['tax_type']}]
      });

      final response = await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        TaxTypeModel newTax = TaxTypeModel(
          tax_type: data['tax_type'],
        );
        _taxList.add(newTax);
        _taxTypeDataSource = TaxTypeDataSource(taxes: _taxList);
        _successMessage = 'Tax type added successfully!';
        notifyListeners();
      } else {
        throw Exception("Failed to add tax type. ${response.body}");
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

