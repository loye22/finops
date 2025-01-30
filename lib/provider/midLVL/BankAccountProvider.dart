import 'dart:convert';
import 'package:finops/models/midLVL/BankAccountModel.dart';
import 'package:finops/models/staticVar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BankAccountProvider with ChangeNotifier {
  List<BankAccountModel> _bankAccountList = [];
  late BankAccountDataSource _bankAccountDataSource;
  String? _errorMessage;
  String? _successMessage;

  // Getters
  List<BankAccountModel> get bankAccountList => _bankAccountList;
  String? get errorMessage => _errorMessage;
  String? get successMessage => _successMessage;
  BankAccountDataSource get bankAccountDataSource => _bankAccountDataSource;
  bool get hasData => _bankAccountList.isNotEmpty;

  BankAccountProvider() {
    fetchBankAccountsFromAPI();
  }

  Future<void> fetchBankAccountsFromAPI() async {
    
    if (_bankAccountList.isNotEmpty) {
      print("Bank accounts already loaded.");
      return;
    }
    print("Fetching bank accounts...");

    try {
      final url = staticVar.urlAPI  +  'bank_accounts/Action'; // Replace with your API endpoint.
      final headers = {
        'ApplicationAccessKey': 'V2-HPwgN-t1nZA-pHXjA-5UBkc-NAVkh-vRq9F-zPDFW-WMFY1', // Replace with your key.
        'Content-Type': 'application/json',
      };
      final body = jsonEncode({"Action": "Find", "Rows": []});
      final response =
      await http.post(Uri.parse(url), headers: headers, body: body);

      //print("===>" + response.body);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        List<BankAccountModel> bankAccountListHelper = [];

        for (var item in data) {
          bankAccountListHelper.add(BankAccountModel(
            bankAccountIban: item['bank_account_iban'],
            userEmail: item['user_email'],
            userTimestamp: DateTime.now(), // fix this shit
            section1: item['section_1'],
            bankName: item['bank_name'],
            ownerId: item['owner_id'],
            currency: item['currency'],
            administration: item['administration'],
            active: item['active'],
          ));
        }

        _bankAccountList = bankAccountListHelper;
        _bankAccountDataSource =
            BankAccountDataSource(bankAccounts: _bankAccountList);
        notifyListeners();
      } else {
        throw Exception("Failed to fetch bank accounts. ${response.body}");
      }
    } catch (e) {
      print("error $e");
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> addBankAccount(Map<String, dynamic> data) async {
    try {
      final url = 'https://your-api-url.com/bankAccounts'; // Replace with your API endpoint.
      final headers = {
        'ApplicationAccessKey': 'Your-Access-Key', // Replace with your key.
        'Content-Type': 'application/json',
      };
      final body = jsonEncode({
        "Action": "Add",
        "Rows": [
          {
            'bank_account_iban': data['bankAccountIban'],
            'user_email': data['userEmail'],
            'user_timestamp': data['userTimestamp'].toIso8601String(),
            'section_1': data['section1'],
            'bank_name': data['bankName'],
            'owner_id': data['ownerId'],
            'currency': data['currency'],
            'administration': data['administration'],
            'active': data['active'],
          }
        ]
      });

      final response =
      await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        BankAccountModel newBankAccount = BankAccountModel(
          bankAccountIban: data['bankAccountIban'],
          userEmail: data['userEmail'],
          userTimestamp: data['userTimestamp'],
          section1: data['section1'],
          bankName: data['bankName'],
          ownerId: data['ownerId'],
          currency: data['currency'],
          administration: data['administration'],
          active: data['active'],
        );
        _bankAccountList.add(newBankAccount);
        _bankAccountDataSource =
            BankAccountDataSource(bankAccounts: _bankAccountList);
        _successMessage = 'Bank account added successfully!';
        notifyListeners();
      } else {
        throw Exception("Failed to add bank account. ${response.body}");
      }
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  String getIbanByOwnerId(String ownerId) {
    // Search for the account with the matching ownerId
    for (var account in _bankAccountList) {
      // print("account.ownerId ${account.ownerId}") ;
      // print("passed id  ${ownerId}" );
      if (account.ownerId == ownerId) {
        return account.bankAccountIban; // Return IBAN if a match is found
      }
    }

    // Return "404NOtfound" if no matching ownerId is found
    return "404NOtfound";
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
