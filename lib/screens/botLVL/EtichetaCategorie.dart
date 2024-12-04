import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EtichetaCategorie extends StatefulWidget {
  const EtichetaCategorie({super.key});

  @override
  State<EtichetaCategorie> createState() => _EtichetaCategorieState();
}

class _EtichetaCategorieState extends State<EtichetaCategorie> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text('Eticheta Categorie'),
      ),
    );
  }
}
