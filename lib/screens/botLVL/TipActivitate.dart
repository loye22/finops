import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TipActivitate extends StatefulWidget {
  const TipActivitate({super.key});

  @override
  State<TipActivitate> createState() => _TipActivitateState();
}

class _TipActivitateState extends State<TipActivitate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text('Tip Activitate'),
      ),
    );
  }
}
