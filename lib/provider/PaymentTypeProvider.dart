import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/PaymentTypeModel.dart';
import '../models/staticVar.dart';

class PaymentTypeProvider with ChangeNotifier {
  List<PaymentTypeModel> _paymentTypeList = [];
  late PaymentTypeDataSource _paymentTypeDataSource;
  String? _errorMessage;
  String? _successMessage;

  // Getters
  List<PaymentTypeModel> get paymentTypeList => _paymentTypeList;
  String? get errorMessage => _errorMessage;
  String? get successMessage => _successMessage;
  PaymentTypeDataSource get paymentTypeDataSource => _paymentTypeDataSource;

  bool get hasData => _paymentTypeList.isNotEmpty;

  PaymentTypeProvider() {
    fetchPaymentTypesFromAPI();
  }

  Future<void> fetchPaymentTypesFromAPI() async {
    if (_paymentTypeList.isNotEmpty) {
      print("Data is already loaded.");
      return;
    }
    print("Fetching payment types...");

    try {
      final url = staticVar.urlAPI + 'payment_type/Action';
      final headers = {
        'ApplicationAccessKey': 'V2-HPwgN-t1nZA-pHXjA-5UBkc-NAVkh-vRq9F-zPDFW-WMFY1',
        'Content-Type': 'application/json',
      };
      final body = jsonEncode({"Action": "Find", "Rows": []});
      final response = await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        List<PaymentTypeModel> paymentTypeListHelper = [];

        for (var item in data) {
          PaymentTypeModel paymentType = PaymentTypeModel(
            payment_type: item['payment_type'] ?? 'NOTFOUND',
          );
          paymentTypeListHelper.add(paymentType);
        }

        _paymentTypeList = paymentTypeListHelper;
        _paymentTypeDataSource = PaymentTypeDataSource(paymentTypes: _paymentTypeList);
        notifyListeners();
      } else {
        throw Exception("Failed to fetch payment types. ${response.body}");
      }
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> addPaymentType(Map<String, dynamic> data) async {
    try {
      final url = staticVar.urlAPI + 'payment_type/Action';
      final headers = {
        'ApplicationAccessKey': 'V2-HPwgN-t1nZA-pHXjA-5UBkc-NAVkh-vRq9F-zPDFW-WMFY1',
        'Content-Type': 'application/json',
      };
      final body = jsonEncode({
        "Action": "Add",
        "Rows": [{'payment_type': data['payment_type']}]
      });

      final response = await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        PaymentTypeModel newPaymentType = PaymentTypeModel(
          payment_type: data['payment_type'],
        );
        _paymentTypeList.add(newPaymentType);
        _paymentTypeDataSource = PaymentTypeDataSource(paymentTypes: _paymentTypeList);
        _successMessage = 'Payment type added successfully!';
        notifyListeners();
      } else {
        throw Exception("Failed to add payment type. ${response.body}");
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
