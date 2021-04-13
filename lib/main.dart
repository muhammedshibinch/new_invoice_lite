import 'package:flutter/material.dart';
import 'package:invoice_lite_flutterv1/database/dataBase.dart';
import 'package:provider/provider.dart';
import './screens/invoicescreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: Data(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: InvoiceScreen(),
      ),
    );
  }
}
