import 'package:flutter/material.dart';
import 'package:invoice_lite_flutterv1/database/dataBase.dart';
import 'package:invoice_lite_flutterv1/models/invoice.dart';
import 'package:provider/provider.dart';
import './screens/invoicescreen.dart';
import './models/item.dart';
import './screens/customerScreen.dart';
import './screens/productScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Data(),
        ),
        ChangeNotifierProvider.value(
          value:Item(), 
        ),
        ChangeNotifierProvider.value(
          value: InvoiceItem()
          )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: InvoiceScreen(),
        routes:{
         InvoiceScreen.routeName:(ctx)=>InvoiceScreen(),
         ProductScreen.routeName:(ctx)=>ProductScreen(),
         CustomerScreen.routeName:(ctx)=>CustomerScreen(),
        }
         
        
      ),
    );
  }
}
