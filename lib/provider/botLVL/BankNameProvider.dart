// bank_provider.dart
import 'dart:convert';
import 'package:finops/models/botLVL/BankNameModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../models/staticVar.dart';

class BankNameProvider with ChangeNotifier {
  List<BankNameModel> _bankList = [];
  late BankNameDataSource _bankNameDataSource;
  String? _errorMessage;
  String? _successMessage;

  // Getter for error message
  String? get errorMessage => _errorMessage;

  // Getter for success message
  String? get successMessage => _successMessage;

  BankNameDataSource get bankNameDataSource => _bankNameDataSource;

  bool get hasData => _bankList.isNotEmpty;

  BankNameProvider() {
    fetchBankNamesFromAPI();
  }

  Future<void> fetchBankNamesFromAPI() async {
    if (_bankList.isNotEmpty) {
      print("Data is already loaded.");
      return;
    }
    print("Fetching bank names...");

    try {
      final url = staticVar.urlAPI + 'bank_name/Action';
      final headers = {
        'ApplicationAccessKey': 'V2-HPwgN-t1nZA-pHXjA-5UBkc-NAVkh-vRq9F-zPDFW-WMFY1',
        'Content-Type': 'application/json',
      };
      final body = jsonEncode({"Action": "Find", "Rows": []});
      final response = await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        List<BankNameModel> bankListHelper = [];

        for (var item in data) {
          BankNameModel bank = BankNameModel(
            bank_name: item['bank_name'] ?? 'NOTFOUND',
          );
          bankListHelper.add(bank);
        }

        _bankList = bankListHelper;
        _bankNameDataSource = BankNameDataSource(banks: _bankList);
        notifyListeners();
      } else {
        throw Exception("Failed to fetch bank names.${response.body}");
      }
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> addBankName(Map<String, dynamic> data) async {
    try {
      final url = staticVar.urlAPI + 'bank_name/Action';
      final headers = {
        'ApplicationAccessKey': 'V2-HPwgN-t1nZA-pHXjA-5UBkc-NAVkh-vRq9F-zPDFW-WMFY1',
        'Content-Type': 'application/json',
      };
      final body = jsonEncode({
        "Action": "Add",
        "Rows": [{'bank_name': data['bank_name']}]
      });

      final response = await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        BankNameModel newBank = BankNameModel(
          bank_name: data['bank_name'],
        );
        _bankList.add(newBank);
        _bankNameDataSource = BankNameDataSource(banks: _bankList);
        _successMessage = 'Numele băncii a fost adăugat cu succes!';
        notifyListeners();
      } else {
        throw Exception("Failed to add bank name.${response.body}");
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
