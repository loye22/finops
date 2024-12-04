import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ClasaDocument extends StatefulWidget {
  const ClasaDocument({super.key});

  @override
  State<ClasaDocument> createState() => _ClasaDocumentState();
}

class _ClasaDocumentState extends State<ClasaDocument> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text('Clasa Document'),
      ),
    );
  }
}
