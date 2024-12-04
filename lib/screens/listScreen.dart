import 'package:finops/models/staticVar.dart';
import 'package:finops/screens/botLVL/AnVehicul.dart';
import 'package:finops/screens/botLVL/BrandVehicul.dart';
import 'package:finops/screens/botLVL/ClasaDocument.dart';
import 'package:finops/screens/botLVL/EtichetaBrand.dart';
import 'package:finops/screens/botLVL/EtichetaCategorie.dart';
import 'package:finops/screens/botLVL/EtichetaCuvantCheie.dart';
import 'package:finops/screens/botLVL/LocatieConsum.dart';
import 'package:finops/screens/botLVL/MetodaPlata.dart';
import 'package:finops/screens/botLVL/ModelVehicul.dart';
import 'package:finops/screens/botLVL/Moneda.dart';
import 'package:finops/screens/botLVL/NumarInmatriculareVehicul.dart';
import 'package:finops/screens/botLVL/NumeBanca.dart';
import 'package:finops/screens/botLVL/StatusAprobareaPlatii.dart';
import 'package:finops/screens/botLVL/StatusPlata.dart';
import 'package:finops/screens/botLVL/TipActivitate.dart';
import 'package:finops/screens/botLVL/TipAsigurare.dart';
import 'package:finops/screens/botLVL/TipCalculUtilitate.dart';
import 'package:finops/screens/botLVL/TipCitireIndex.dart';
import 'package:finops/screens/botLVL/TipCombustibil.dart';
import 'package:finops/screens/botLVL/TipDocument.dart';
import 'package:finops/screens/botLVL/TipEntitate.dart';
import 'package:finops/screens/botLVL/TipImobil.dart';
import 'package:finops/screens/botLVL/TipPlata.dart';
import 'package:finops/screens/botLVL/TipTaxa.dart';
import 'package:finops/screens/botLVL/TipUtilitate.dart';
import 'package:finops/screens/botLVL/TipVacanta.dart';
import 'package:finops/screens/botLVL/UnitateMasura.dart';
import 'package:finops/screens/botLVL/tipOperatiune.dart';
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
                    widget.openTabCallback('Tip Operatiune', tipOperatiune());
                  },
                ),
                gridItem(
                  title: 'Tip Document',
                  icon: Icons.insert_drive_file,
                  color: Colors.green,
                  onTap: () {
                    widget.openTabCallback('Tip Document', TipDocument());
                  },
                ),
                gridItem(
                  title: 'Tip Entitate',
                  icon: Icons.business,
                  color: Colors.orange,
                  onTap: () {
                    widget.openTabCallback('Tip Entitate', TipEntitate());
                  },
                ),
                gridItem(
                  title: 'Nume Banca',
                  icon: Icons.account_balance,
                  color: Colors.blueGrey,
                  onTap: () {
                    widget.openTabCallback('Nume Banca', NumeBanca());
                  },
                ),
                gridItem(
                  title: 'Moneda',
                  icon: Icons.monetization_on,
                  color: Colors.amber,
                  onTap: () {
                    widget.openTabCallback('Moneda', Moneda());
                  },
                ),
                gridItem(
                  title: 'Tip Taxa',
                  icon: Icons.attach_money,
                  color: Colors.cyan,
                  onTap: () {
                    widget.openTabCallback('Tip Taxa',TipTaxa());
                  },
                ),
                gridItem(
                  title: 'Tip Utilitate',
                  icon: Icons.local_fire_department,
                  color: Colors.red,
                  onTap: () {
                    widget.openTabCallback('Tip Utilitate',TipUtilitate() );
                  },
                ),
                gridItem(
                  title: 'Clasa Document',
                  icon: Icons.class_,
                  color: Colors.purple,
                  onTap: () {
                    widget.openTabCallback('Clasa Document', ClasaDocument());
                  },
                ),
                gridItem(
                  title: 'Unitate de Masura',
                  icon: Icons.scale,
                  color: Colors.teal,
                  onTap: () {
                    widget.openTabCallback('Unitate de Masura', UnitateMasura());
                  },
                ),
                gridItem(
                  title: 'Metoda de Plata',
                  icon: Icons.payment,
                  color: Colors.indigo,
                  onTap: () {
                    widget.openTabCallback('Metoda de Plata', MetodaPlata());
                  },
                ),
                gridItem(
                  title: 'Tip Plata',
                  icon: Icons.credit_card,
                  color: Colors.blueAccent,
                  onTap: () {
                    widget.openTabCallback('Tip Plata', TipPlata());
                  },
                ),
                gridItem(
                  title: 'Eticheta Categorie',
                  icon: Icons.label,
                  color: Colors.greenAccent,
                  onTap: () {
                    widget.openTabCallback('Eticheta Categorie', EtichetaCategorie());
                  },
                ),

                gridItem(
                  title: 'Eticheta Brandxx',
                  icon: Icons.branding_watermark,
                  color: Colors.blueAccent,

                  onTap: () {
                    widget.openTabCallback('Eticheta Brand', EtichetaBrand());
                  },
                ),

                gridItem(
                  title: 'Eticheta Cuvant Cheie',
                  icon: Icons.tag,
                  color: Colors.orangeAccent,
                  onTap: () {
                    widget.openTabCallback('Eticheta Cuvant Cheie', EtichetaCuvantCheie());
                  },
                ),
                gridItem(
                  title: 'Locatie Consum',
                  icon: Icons.location_on,
                  color: Colors.lightBlue,
                  onTap: () {
                    widget.openTabCallback('Locatie Consum',LocatieConsum());
                  },
                ),
                gridItem(
                  title: 'Tip Imobil',
                  icon: Icons.home,
                  color: Colors.blueGrey,
                  onTap: () {
                    widget.openTabCallback('Tip Imobil',TipImobil());
                  },
                ),
                gridItem(
                  title: 'Tip Activitate',
                  icon: Icons.work,
                  color: Colors.purpleAccent,
                  onTap: () {
                    widget.openTabCallback('Tip Activitate', TipActivitate());
                  },
                ),
                gridItem(
                  title: 'Tip Calcul Utilitate',
                  icon: Icons.calculate,
                  color: Colors.yellow,
                  onTap: () {
                    widget.openTabCallback('Tip Calcul Utilitate', TipCalculUtilitate());
                  },
                ),
                gridItem(
                  title: 'Tip Citire Index',
                  icon: Icons.search,
                  color: Colors.deepOrange,
                  onTap: () {
                    widget.openTabCallback('Tip Citire Index', TipCitireIndex());
                  },
                ),
                gridItem(
                  title: 'Status Plata',
                  icon: Icons.check_circle,
                  color: Colors.green,
                  onTap: () {
                    widget.openTabCallback('Status Plata', StatusPlata());
                  },
                ),
                gridItem(
                  title: 'Status Aprobarea Platii',
                  icon: Icons.lock,
                  color: Colors.redAccent,
                  onTap: () {
                    widget.openTabCallback('Status Aprobarea Platii',StatusAprobareaPlatii());
                  },
                ),
                gridItem(
                  title: 'Tip Vacanta',
                  icon: Icons.beach_access,
                  color: Colors.cyanAccent,
                  onTap: () {
                    widget.openTabCallback('Tip Vacanta', TipVacanta());
                  },
                ),
                gridItem(
                  title: 'Tip Asigurare',
                  icon: Icons.security,
                  color: Colors.blue,
                  onTap: () {
                    widget.openTabCallback('Tip Asigurare',TipAsigurare());
                  },
                ),
                gridItem(
                  title: 'Numar Inmatriculare Vehicul',
                  icon: Icons.car_repair,
                  color: Colors.green,
                  onTap: () {
                    widget.openTabCallback('Numar Inmatriculare Vehicul', NumarInmatriculareVehicul());
                  },
                ),
                gridItem(
                  title: 'Brand Vehicul',
                  icon: Icons.directions_car,
                  color: Colors.red,
                  onTap: () {
                    widget.openTabCallback('Brand Vehicul',BrandVehicul());
                  },
                ),
                gridItem(
                  title: 'Model Vehicul',
                  icon: Icons.directions_car,
                  color: Colors.orange,
                  onTap: () {
                    widget.openTabCallback('Model Vehicul', ModelVehicul());
                  },
                ),
                gridItem(
                  title: 'An Vehicul',
                  icon: Icons.calendar_today,
                  color: Colors.blueGrey,
                  onTap: () {
                    widget.openTabCallback('An Vehicul', AnVehicul());
                  },
                ),
                gridItem(
                  title: 'Tip Combustibil',
                  icon: Icons.local_gas_station,
                  color: Colors.amber,
                  onTap: () {
                    widget.openTabCallback('Tip Combustibil', TipCombustibil()) ;
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
