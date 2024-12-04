import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TipDocument extends StatefulWidget {
  const TipDocument({super.key});

  @override
  State<TipDocument> createState() => _TipDocumentState();
}

class _TipDocumentState extends State<TipDocument> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text('Tip Document'),
      ),
    );
  }
}
