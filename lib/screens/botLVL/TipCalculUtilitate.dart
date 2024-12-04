import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TipCalculUtilitate extends StatefulWidget {
  const TipCalculUtilitate({super.key});

  @override
  State<TipCalculUtilitate> createState() => _TipCalculUtilitateState();
}

class _TipCalculUtilitateState extends State<TipCalculUtilitate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text('Tip Calcul Utilitate'),
      ),
    );
  }
}
