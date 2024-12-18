import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../models/botLVL/PaymentApprovalStatusModel.dart';
import '../../models/staticVar.dart';

class PaymentApprovalStatusProvider with ChangeNotifier {
  List<PaymentApprovalStatusModel> _paymentApprovalStatusList = [];
  late PaymentApprovalStatusDataSource _paymentApprovalStatusDataSource;
  String? _errorMessage;
  String? _successMessage;

  // Getters
  List<PaymentApprovalStatusModel> get paymentApprovalStatusList => _paymentApprovalStatusList;
  String? get errorMessage => _errorMessage;
  String? get successMessage => _successMessage;
  PaymentApprovalStatusDataSource get paymentApprovalStatusDataSource => _paymentApprovalStatusDataSource;

  bool get hasData => _paymentApprovalStatusList.isNotEmpty;

  PaymentApprovalStatusProvider() {
    fetchPaymentApprovalStatusesFromAPI();
  }

  Future<void> fetchPaymentApprovalStatusesFromAPI() async {
    if (_paymentApprovalStatusList.isNotEmpty) {
      print("Data is already loaded.");
      return;
    }
    print("Fetching payment approval statuses...");

    try {
      final url = staticVar.urlAPI + 'payment_approval_status/Action';
      final headers = {
        'ApplicationAccessKey': 'V2-HPwgN-t1nZA-pHXjA-5UBkc-NAVkh-vRq9F-zPDFW-WMFY1',
        'Content-Type': 'application/json',
      };
      final body = jsonEncode({"Action": "Find", "Rows": []});
      final response = await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        List<PaymentApprovalStatusModel> paymentApprovalStatusListHelper = [];

        for (var item in data) {
          PaymentApprovalStatusModel paymentApprovalStatus = PaymentApprovalStatusModel(
            payment_approval_status: item['payment_approval_status'] ?? 'NOTFOUND',
          );
          paymentApprovalStatusListHelper.add(paymentApprovalStatus);
        }

        _paymentApprovalStatusList = paymentApprovalStatusListHelper;
        _paymentApprovalStatusDataSource = PaymentApprovalStatusDataSource(paymentApprovalStatuses: _paymentApprovalStatusList);
        notifyListeners();
      } else {
        throw Exception("Failed to fetch payment approval statuses. ${response.body}");
      }
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> addPaymentApprovalStatus(Map<String, dynamic> data) async {
    try {
      final url = staticVar.urlAPI + 'payment_approval_status/Action';
      final headers = {
        'ApplicationAccessKey': 'V2-HPwgN-t1nZA-pHXjA-5UBkc-NAVkh-vRq9F-zPDFW-WMFY1',
        'Content-Type': 'application/json',
      };
      final body = jsonEncode({
        "Action": "Add",
        "Rows": [{'payment_approval_status': data['payment_approval_status']}]
      });

      final response = await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        PaymentApprovalStatusModel newPaymentApprovalStatus = PaymentApprovalStatusModel(
          payment_approval_status: data['payment_approval_status'],
        );
        _paymentApprovalStatusList.add(newPaymentApprovalStatus);
        _paymentApprovalStatusDataSource = PaymentApprovalStatusDataSource(paymentApprovalStatuses: _paymentApprovalStatusList);
        _successMessage = 'Payment approval status added successfully!';
        notifyListeners();
      } else {
        throw Exception("Failed to add payment approval status. ${response.body}");
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

