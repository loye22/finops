import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/botLVL/PaymentStatusModel.dart';
import '../models/staticVar.dart';

class PaymentStatusProvider with ChangeNotifier {
  List<PaymentStatusModel> _paymentStatusList = [];
  late PaymentStatusDataSource _paymentStatusDataSource;
  String? _errorMessage;
  String? _successMessage;

  // Getters
  List<PaymentStatusModel> get paymentStatusList => _paymentStatusList;
  String? get errorMessage => _errorMessage;
  String? get successMessage => _successMessage;
  PaymentStatusDataSource get paymentStatusDataSource => _paymentStatusDataSource;

  bool get hasData => _paymentStatusList.isNotEmpty;

  PaymentStatusProvider() {
    fetchPaymentStatusesFromAPI();
  }

  Future<void> fetchPaymentStatusesFromAPI() async {
    if (_paymentStatusList.isNotEmpty) {
      print("Data is already loaded.");
      return;
    }
    print("Fetching payment statuses...");

    try {
      final url = staticVar.urlAPI + 'payment_status/Action';
      final headers = {
        'ApplicationAccessKey': 'V2-HPwgN-t1nZA-pHXjA-5UBkc-NAVkh-vRq9F-zPDFW-WMFY1',
        'Content-Type': 'application/json',
      };
      final body = jsonEncode({"Action": "Find", "Rows": []});
      final response = await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        List<PaymentStatusModel> paymentStatusListHelper = [];

        for (var item in data) {
          PaymentStatusModel paymentStatus = PaymentStatusModel(
            payment_status: item['payment_status'] ?? 'NOTFOUND',
          );
          paymentStatusListHelper.add(paymentStatus);
        }

        _paymentStatusList = paymentStatusListHelper;
        _paymentStatusDataSource = PaymentStatusDataSource(paymentStatuses: _paymentStatusList);
        notifyListeners();
      } else {
        throw Exception("Failed to fetch payment statuses. ${response.body}");
      }
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> addPaymentStatus(Map<String, dynamic> data) async {
    try {
      final url = staticVar.urlAPI + 'payment_status/Action';
      final headers = {
        'ApplicationAccessKey': 'V2-HPwgN-t1nZA-pHXjA-5UBkc-NAVkh-vRq9F-zPDFW-WMFY1',
        'Content-Type': 'application/json',
      };
      final body = jsonEncode({
        "Action": "Add",
        "Rows": [{'payment_status': data['payment_status']}]
      });

      final response = await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        PaymentStatusModel newPaymentStatus = PaymentStatusModel(
          payment_status: data['payment_status'],
        );
        _paymentStatusList.add(newPaymentStatus);
        _paymentStatusDataSource = PaymentStatusDataSource(paymentStatuses: _paymentStatusList);
        _successMessage = 'Payment status added successfully!';
        notifyListeners();
      } else {
        throw Exception("Failed to add payment status. ${response.body}");
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

