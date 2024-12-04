import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TipTaxa extends StatefulWidget {
  const TipTaxa({super.key});

  @override
  State<TipTaxa> createState() => _TipTaxaState();
}

class _TipTaxaState extends State<TipTaxa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text('Tip Taxa'),
      ),
    );
  }
}
