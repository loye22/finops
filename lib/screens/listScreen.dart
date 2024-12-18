import 'package:finops/models/staticVar.dart';
import 'package:finops/screens/botLVL/VehicleYearUI.dart';
import 'package:finops/screens/botLVL/VehicleBrandUI.dart';
import 'package:finops/screens/botLVL/DocumentClassUI.dart';
import 'package:finops/screens/botLVL/BrandTagUI.dart';
import 'package:finops/screens/botLVL/CategoryTagUI.dart';
import 'package:finops/screens/botLVL/KeywordTagUI.dart';
import 'package:finops/screens/botLVL/ConsumptionLocationUI.dart';
import 'package:finops/screens/botLVL/PaymentMethodUI.dart';
import 'package:finops/screens/botLVL/ModelVehicul.dart';
import 'package:finops/screens/botLVL/MonedaUI.dart';
import 'package:finops/screens/botLVL/VehicleRegistrationNumberUI.dart';
import 'package:finops/screens/botLVL/bankNameUI.dart';
import 'package:finops/screens/botLVL/PaymentApprovalStatusUI.dart';
import 'package:finops/screens/botLVL/PaymentStatusUI.dart';
import 'package:finops/screens/botLVL/ActivityTypeUI.dart';
import 'package:finops/screens/botLVL/InsuranceTypeUI.dart';
import 'package:finops/screens/botLVL/UtilityCalculationTypeUI.dart';
import 'package:finops/screens/botLVL/IndexReadingTypeUI.dart';
import 'package:finops/screens/botLVL/FuelTypeUI.dart';
import 'package:finops/screens/botLVL/DocumentTypeUI.dart';
import 'package:finops/screens/botLVL/entityTypeUI.dart';
import 'package:finops/screens/botLVL/RealEstateTypeUI.dart';
import 'package:finops/screens/botLVL/PaymentTypeUI.dart';
import 'package:finops/screens/botLVL/TaxTypeUI.dart';
import 'package:finops/screens/botLVL/UtilityTypeUI.dart';
import 'package:finops/screens/botLVL/VacantionTypeUI.dart';
import 'package:finops/screens/botLVL/UnitMeasureUI.dart';
import 'package:finops/screens/botLVL/operationTypeUI.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class listScreen extends StatefulWidget {
  final Function(String tabTitle, Widget tabContent) openTabCallback;

  const listScreen({super.key, required this.openTabCallback});

  @override
  State<listScreen> createState() => _listScreenState();
}

class _listScreenState extends State<listScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: GridView.count(
              crossAxisCount: 9, // Number of items in a row
              crossAxisSpacing: 10, // Horizontal spacing
              mainAxisSpacing: 10, // Vertical spacing
              padding: EdgeInsets.all(10),
              children: [
                gridItem(
                  title: 'Tip Operatiune',
                  icon: Icons.settings,
                  color: Colors.blue,
                  onTap: () {
                    widget.openTabCallback('Tip Operatiune', operationTypeUI());
                  },
                ),
                gridItem(
                  title: 'Tip Document',
                  icon: Icons.insert_drive_file,
                  color: Colors.green,
                  onTap: () {
                    widget.openTabCallback('Tip Document', DocumentTypeUI());
                  },
                ),
                gridItem(
                  title: 'Tip Entitate',
                  icon: Icons.business,
                  color: Colors.orange,
                  onTap: () {
                    widget.openTabCallback('Tip Entitate', entityTypeUI());
                  },
                ),
                gridItem(
                  title: 'Nume Banca',
                  icon: Icons.account_balance,
                  color: Colors.blueGrey,
                  onTap: () {
                    widget.openTabCallback('Nume Banca', bankNameUI());
                  },
                ),
                gridItem(
                  title: 'Moneda',
                  icon: Icons.monetization_on,
                  color: Colors.amber,
                  onTap: () {
                    widget.openTabCallback('Moneda', MonedaUI());
                  },
                ),
                gridItem(
                  title: 'Tip Taxa',
                  icon: Icons.attach_money,
                  color: Colors.cyan,
                  onTap: () {
                    widget.openTabCallback('Tip Taxa',TaxTypeUI());
                  },
                ),
                gridItem(
                  title: 'Tip Utilitate',
                  icon: Icons.local_fire_department,
                  color: Colors.red,
                  onTap: () {
                    widget.openTabCallback('Tip Utilitate',UtilityTypeUI() );
                  },
                ),
                gridItem(
                  title: 'Clasa Document',
                  icon: Icons.class_,
                  color: Colors.purple,
                  onTap: () {
                    widget.openTabCallback('Clasa Document', DocumentClassUI());
                  },
                ),
                gridItem(
                  title: 'Unitate de Masura',
                  icon: Icons.scale,
                  color: Colors.teal,
                  onTap: () {
                    widget.openTabCallback('Unitate de Masura', UnitMeasureUI());
                  },
                ),
                gridItem(
                  title: 'Metoda de Plata',
                  icon: Icons.payment,
                  color: Colors.indigo,
                  onTap: () {
                    widget.openTabCallback('Metoda de Plata', PaymentMethodUI());
                  },
                ),
                gridItem(
                  title: 'Tip Plata',
                  icon: Icons.credit_card,
                  color: Colors.blueAccent,
                  onTap: () {
                    widget.openTabCallback('Tip Plata', PaymentTypeUI());
                  },
                ),
                gridItem(
                  title: 'Eticheta Categorie',
                  icon: Icons.label,
                  color: Colors.greenAccent,
                  onTap: () {
                    widget.openTabCallback('Eticheta Categorie', CategoryTagUI());
                  },
                ),

                gridItem(
                  title: 'Eticheta Brand',
                  icon: Icons.branding_watermark,
                  color: Colors.blueAccent,

                  onTap: () {
                    widget.openTabCallback('Eticheta Brand', BrandTagUI());
                  },
                ),

                gridItem(
                  title: 'Eticheta Cuvant Cheie',
                  icon: Icons.tag,
                  color: Colors.orangeAccent,
                  onTap: () {
                    widget.openTabCallback('Eticheta Cuvant Cheie', KeywordTagUI());
                  },
                ),
                gridItem(
                  title: 'Locatie Consum',
                  icon: Icons.location_on,
                  color: Colors.lightBlue,
                  onTap: () {
                    widget.openTabCallback('Locatie Consum',ConsumptionLocationUI());
                  },
                ),
                gridItem(
                  title: 'Tip Imobil',
                  icon: Icons.home,
                  color: Colors.blueGrey,
                  onTap: () {
                    widget.openTabCallback('Tip Imobil',RealEstateTypeUI());
                  },
                ),
                gridItem(
                  title: 'Tip Activitate',
                  icon: Icons.work,
                  color: Colors.purpleAccent,
                  onTap: () {
                    widget.openTabCallback('Tip Activitate', ActivityTypeUI());
                  },
                ),
                gridItem(
                  title: 'Tip Calcul Utilitate',
                  icon: Icons.calculate,
                  color: Colors.yellow,
                  onTap: () {
                    widget.openTabCallback('Tip Calcul Utilitate', UtilityCalculationTypeUI());
                  },
                ),
                gridItem(
                  title: 'Tip Citire Index',
                  icon: Icons.search,
                  color: Colors.deepOrange,
                  onTap: () {
                    widget.openTabCallback('Tip Citire Index', IndexReadingTypeUI());
                  },
                ),
                gridItem(
                  title: 'Status Plata',
                  icon: Icons.check_circle,
                  color: Colors.green,
                  onTap: () {
                    widget.openTabCallback('Status Plata', PaymentStatusUI());
                  },
                ),
                gridItem(
                  title: 'Status Aprobarea Platii',
                  icon: Icons.lock,
                  color: Colors.redAccent,
                  onTap: () {
                    widget.openTabCallback('Status Aprobarea Platii',PaymentApprovalStatusUI());
                  },
                ),
                gridItem(
                  title: 'Tip Vacanta',
                  icon: Icons.beach_access,
                  color: Colors.cyanAccent,
                  onTap: () {
                    widget.openTabCallback('Tip Vacanta', VacantionTypeUI());
                  },
                ),
                gridItem(
                  title: 'Tip Asigurare',
                  icon: Icons.security,
                  color: Colors.blue,
                  onTap: () {
                    widget.openTabCallback('Tip Asigurare',InsuranceTypeUI());
                  },
                ),
                gridItem(
                  title: 'Numar Inmatriculare Vehicul',
                  icon: Icons.car_repair,
                  color: Colors.green,
                  onTap: () {
                    widget.openTabCallback('Numar Inmatriculare Vehicul', VehicleRegistrationNumberUI());
                  },
                ),
                gridItem(
                  title: 'Brand Vehicul',
                  icon: Icons.directions_car,
                  color: Colors.red,
                  onTap: () {
                    widget.openTabCallback('Brand Vehicul',VehicleBrandUI());
                  },
                ),
                gridItem(
                  title: 'Model Vehicul',
                  icon: Icons.directions_car,
                  color: Colors.orange,
                  onTap: () {
                    widget.openTabCallback('Model Vehicul', VehicleModelUI());
                  },
                ),
                gridItem(
                  title: 'An Vehicul',
                  icon: Icons.calendar_today,
                  color: Colors.blueGrey,
                  onTap: () {
                    widget.openTabCallback('An Vehicul', VehicleYearUI());
                  },
                ),
                gridItem(
                  title: 'Tip Combustibil',
                  icon: Icons.local_gas_station,
                  color: Colors.amber,
                  onTap: () {
                    widget.openTabCallback('Tip Combustibil', VehicleYearUI()) ;
                  },
                ),
              ]

            ),
          ),

        ],
      ),

    );
  }

}

class gridItem extends StatefulWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const gridItem({
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  _gridItemState createState() => _gridItemState();
}

class _gridItemState extends State<gridItem> {
  bool isHovered = false; // Track hover state

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        setState(() {
          isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          isHovered = false;
        });
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200), // Smooth transition
          decoration: BoxDecoration(
            color: isHovered ? Colors.grey.shade200 : Colors.white, // Change background on hover
            border: Border.all(color: Colors.grey.shade300, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Icon(
                  widget.icon,
                  color: widget.color,
                  size: 40,
                ),
              ),
              SizedBox(height: 10),
              Flexible(
                child: Text(
                  widget.title,
                  style: TextStyle(
                    color: staticVar.themeColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
