// entity_provider.dart
import 'dart:convert';
import 'package:finops/models/botLVL/EntityTypeModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/staticVar.dart';

class EntityTypeProvider with ChangeNotifier {
  List<EntityTypeModel> _entityList = [];
  late EntityTypeDataSource _entityTypeDataSource;
  String? _errorMessage;
  String? _successMessage;

  // Getter for error message
  String? get errorMessage => _errorMessage;

  // Getter for success message
  String? get successMessage => _successMessage;

  EntityTypeDataSource get entityTypeDataSource => _entityTypeDataSource;

  bool get hasData => _entityList.isNotEmpty;

  EntityTypeProvider() {
    fetchEntityTypesFromAPI();
  }

  Future<void> fetchEntityTypesFromAPI() async {
    if (_entityList.isNotEmpty) {
      print("Data is already loaded.");
      return;
    }
    print("Fetching entity types...");

    try {
      final url = staticVar.urlAPI + 'entity_type/Action';
      final headers = {
        'ApplicationAccessKey': 'V2-HPwgN-t1nZA-pHXjA-5UBkc-NAVkh-vRq9F-zPDFW-WMFY1',
        'Content-Type': 'application/json',
      };
      final body = jsonEncode({"Action": "Find", "Rows": []});
      final response = await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        List<EntityTypeModel> entityListHelper = [];

        for (var item in data) {
          EntityTypeModel entity = EntityTypeModel(
            entity_type: item['entity_type'] ?? 'NOTFOUND',
          );
          entityListHelper.add(entity);
        }

        _entityList = entityListHelper;
        _entityTypeDataSource = EntityTypeDataSource(entities: _entityList);
        notifyListeners();
      } else {
        throw Exception("Failed to fetch entity types.${response.body}");
      }
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> addEntityType(Map<String, dynamic> data) async {
    try {
      final url = staticVar.urlAPI + 'entity_type/Action';
      final headers = {
        'ApplicationAccessKey': 'V2-HPwgN-t1nZA-pHXjA-5UBkc-NAVkh-vRq9F-zPDFW-WMFY1',
        'Content-Type': 'application/json',
      };
      final body = jsonEncode({
        "Action": "Add",
        "Rows": [{'entity_type': data['entity_type']}]
      });

      final response = await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        EntityTypeModel newEntity = EntityTypeModel(
          entity_type: data['entity_type'],
        );
        _entityList.add(newEntity);
        _entityTypeDataSource = EntityTypeDataSource(entities: _entityList);
        _successMessage = 'Tipul de entitate a fost adăugat cu succes!';
        notifyListeners();
      } else {
        throw Exception("Failed to add entity type.${response.body}");
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
