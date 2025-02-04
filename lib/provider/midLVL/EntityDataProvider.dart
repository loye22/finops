import 'dart:convert';
import 'package:finops/models/midLVL/BankAccountModel.dart';
import 'package:finops/models/midLVL/EntityDataModel/EntityDataModel.dart';
import 'package:finops/provider/midLVL/BankAccountProvider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../models/staticVar.dart'; // Adjust this import based on your project structure.

class EntityProvider with ChangeNotifier {
  List<EntityData> _entityList = [];
  late EntityDataSource _entityDataSource;
  String? _errorMessage;
  String? _successMessage;

  final BankAccountProvider _bankAccountProvider;


  // Getters
  List<EntityData> get entityList => _entityList;

  String? get errorMessage => _errorMessage;

  String? get successMessage => _successMessage;

  EntityDataSource get entityDataSource => _entityDataSource;

  bool get hasData => _entityList.isNotEmpty;

  EntityProvider(this._bankAccountProvider) {
    fetchEntitiesFromAPI();
  }
  // Ensures that BankAccountProvider is loaded


  Future<void> fetchEntitiesFromAPI() async {
    while(!_bankAccountProvider.hasData){
      await Future.delayed(Duration(seconds: 1));
    }


    if (_entityList.isNotEmpty) {
      print("Data is already loaded.");
      return;
    }
    print("Fetching entities...");

    try {
      final url = staticVar.urlAPI + 'entities/Action';
      final headers = {
        'ApplicationAccessKey':
            'V2-HPwgN-t1nZA-pHXjA-5UBkc-NAVkh-vRq9F-zPDFW-WMFY1',
        'Content-Type': 'application/json',
      };
      final body = jsonEncode({"Action": "Find", "Rows": []});
      final response =
          await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        List<EntityData> entityListHelper = [];

        for (var item in data) {
          entityListHelper.add(EntityData(
            EntitateName: item['entity_name'] ,
            entity_id: item['entity_id'],
            iban: _bankAccountProvider.getIbanByOwnerId(item['entity_id']),

          ));
        }

        _entityList = entityListHelper;
        _entityDataSource = EntityDataSource(entities: _entityList);
        notifyListeners();
      } else {
        throw Exception("Failed to fetch entities. ${response.body}");
      }
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // Future<void> addEntity(Map<String, dynamic> data) async {
  //   try {
  //     final url = staticVar.urlAPI + 'entity/Action';
  //     final headers = {
  //       'ApplicationAccessKey':
  //           'V2-HPwgN-t1nZA-pHXjA-5UBkc-NAVkh-vRq9F-zPDFW-WMFY1',
  //       'Content-Type': 'application/json',
  //     };
  //     final body = jsonEncode({
  //       "Action": "Add",
  //       "Rows": [
  //         {
  //           'denumireEntitate': data['denumireEntitate'],
  //           'cui': data['cui'],
  //           'iban': data['iban'],
  //           'asocieri': data['asocieri'],
  //         }
  //       ]
  //     });
  //
  //     final response =
  //         await http.post(Uri.parse(url), headers: headers, body: body);
  //
  //     if (response.statusCode == 200) {
  //       EntityData newEntity = EntityData(
  //         EntitateName: data['denumireEntitate'],
  //         cui: data['cui'],
  //         iban: data['iban'],
  //         asocieri: data['asocieri'],
  //       );
  //       _entityList.add(newEntity);
  //       _entityDataSource = EntityDataSource(entities: _entityList);
  //       _successMessage = 'Entity added successfully!';
  //       notifyListeners();
  //     } else {
  //       throw Exception("Failed to add entity. ${response.body}");
  //     }
  //   } catch (e) {
  //     _errorMessage = e.toString();
  //     notifyListeners();
  //   }
  // }



  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  void clearSuccessMessage() {
    _successMessage = null;
    notifyListeners();
  }


}
