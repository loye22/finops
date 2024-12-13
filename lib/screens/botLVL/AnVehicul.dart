
import 'package:finops/widgets/testPopUp.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../models/staticVar.dart';

class AnVehicul extends StatefulWidget {
  const AnVehicul({super.key});

  @override
  State<AnVehicul> createState() => _AnVehiculState();
}

class _AnVehiculState extends State<AnVehicul> {
  final DataGridController _dataGridController = DataGridController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Adaugă Tip Utilitate',
        backgroundColor: staticVar.themeColor,
        onPressed: () async {
          showUtilityTypeDialog(context);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Center()
    );
  }
}

// Show dialog for adding a utility type
void showUtilityTypeDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AddCustomerDialog();
    },
  );
}
