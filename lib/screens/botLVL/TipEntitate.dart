import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TipEntitate extends StatefulWidget {
  const TipEntitate({super.key});

  @override
  State<TipEntitate> createState() => _TipEntitateState();
}

class _TipEntitateState extends State<TipEntitate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text('Tip Entitate'),
      ),
    );
  }
}
