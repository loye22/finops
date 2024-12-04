import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TipImobil extends StatefulWidget {
  const TipImobil({super.key});

  @override
  State<TipImobil> createState() => _TipImobilState();
}

class _TipImobilState extends State<TipImobil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text('Tip Imobil'),
      ),
    );
  }
}
