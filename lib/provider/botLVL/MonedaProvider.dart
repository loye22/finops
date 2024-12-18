import 'dart:convert';
import 'package:finops/models/botLVL/MonedaModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../models/staticVar.dart';

class MonedaProvider with ChangeNotifier {
  List<MonedaModel> _monedaList = [];
  late MonedaDataSource _monedaDataSource;
  String? _errorMessage;
  String? _successMessage;

  // Getter for error message
  String? get errorMessage => _errorMessage;

  // Getter for success message
  String? get successMessage => _successMessage;

  MonedaDataSource get monedaDataSource => _monedaDataSource;

  bool get hasData => _monedaList.isNotEmpty;

  MonedaProvider() {
    fetchMonedaFromAPI();
  }

  Future<void> fetchMonedaFromAPI() async {
    if (_monedaList.isNotEmpty) {
      print("Data is already loaded.");
      return;
    }
    print("Fetching monedas...");

    try {
      final url = staticVar.urlAPI + 'currency/Action';
      final headers = {
        'ApplicationAccessKey': 'V2-HPwgN-t1nZA-pHXjA-5UBkc-NAVkh-vRq9F-zPDFW-WMFY1',
        'Content-Type': 'application/json',
      };
      final body = jsonEncode({"Action": "Find", "Rows": []});
      final response = await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        List<MonedaModel> monedaListHelper = [];

        for (var item in data) {
          MonedaModel moneda = MonedaModel(moneda: item['currency'] ?? 'NOTFOUND',
          );
          monedaListHelper.add(moneda);
        }

        _monedaList = monedaListHelper;
        _monedaDataSource = MonedaDataSource(monedas: _monedaList);
        notifyListeners();
      } else {
        throw Exception("Failed to fetch monedas.${response.body}");
      }
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> addMoneda(Map<String, dynamic> data) async {
    try {
      final url = staticVar.urlAPI + 'currency/Action';
      final headers = {
        'ApplicationAccessKey': 'V2-HPwgN-t1nZA-pHXjA-5UBkc-NAVkh-vRq9F-zPDFW-WMFY1',
        'Content-Type': 'application/json',
      };
      final body = jsonEncode({
        "Action": "Add",
        "Rows": [{'currency': data['currency']}]
      });

      final response = await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        MonedaModel newMoneda = MonedaModel(
          moneda: data['currency'],
        );
        _monedaList.add(newMoneda);
        _monedaDataSource = MonedaDataSource(monedas: _monedaList);
        _successMessage = 'Moneda a fost adăugată cu succes!';
        notifyListeners();
      } else {
        throw Exception("Failed to add moneda.${response.body}");
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
