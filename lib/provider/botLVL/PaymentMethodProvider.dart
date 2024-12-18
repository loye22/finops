import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../models/botLVL/PaymentMethodModel.dart';
import '../../models/staticVar.dart';

class PaymentMethodProvider with ChangeNotifier {
  List<PaymentMethodModel> _paymentMethodList = [];
  late PaymentMethodDataSource _paymentMethodDataSource;
  String? _errorMessage;
  String? _successMessage;

  // Getters
  List<PaymentMethodModel> get paymentMethodList => _paymentMethodList;
  String? get errorMessage => _errorMessage;
  String? get successMessage => _successMessage;
  PaymentMethodDataSource get paymentMethodDataSource => _paymentMethodDataSource;

  bool get hasData => _paymentMethodList.isNotEmpty;

  PaymentMethodProvider() {
    fetchPaymentMethodsFromAPI();
  }

  Future<void> fetchPaymentMethodsFromAPI() async {
    if (_paymentMethodList.isNotEmpty) {
      print("Data is already loaded.");
      return;
    }
    print("Fetching payment methods...");

    try {
      final url = staticVar.urlAPI + 'payment_method/Action';
      final headers = {
        'ApplicationAccessKey': 'V2-HPwgN-t1nZA-pHXjA-5UBkc-NAVkh-vRq9F-zPDFW-WMFY1',
        'Content-Type': 'application/json',
      };
      final body = jsonEncode({"Action": "Find", "Rows": []});
      final response = await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        List<PaymentMethodModel> paymentMethodListHelper = [];

        for (var item in data) {
          PaymentMethodModel paymentMethod = PaymentMethodModel(
            payment_method: item['payment_method'] ?? 'NOTFOUND',
          );
          paymentMethodListHelper.add(paymentMethod);
        }

        _paymentMethodList = paymentMethodListHelper;
        _paymentMethodDataSource = PaymentMethodDataSource(paymentMethods: _paymentMethodList);
        notifyListeners();
      } else {
        throw Exception("Failed to fetch payment methods. ${response.body}");
      }
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> addPaymentMethod(Map<String, dynamic> data) async {
    try {
      final url = staticVar.urlAPI + 'payment_method/Action';
      final headers = {
        'ApplicationAccessKey': 'V2-HPwgN-t1nZA-pHXjA-5UBkc-NAVkh-vRq9F-zPDFW-WMFY1',
        'Content-Type': 'application/json',
      };
      final body = jsonEncode({
        "Action": "Add",
        "Rows": [{'payment_method': data['payment_method']}]
      });

      final response = await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        PaymentMethodModel newPaymentMethod = PaymentMethodModel(
          payment_method: data['payment_method'],
        );
        _paymentMethodList.add(newPaymentMethod);
        _paymentMethodDataSource = PaymentMethodDataSource(paymentMethods: _paymentMethodList);
        _successMessage = 'Payment method added successfully!';
        notifyListeners();
      } else {
        throw Exception("Failed to add payment method. ${response.body}");
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

