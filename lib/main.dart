import 'package:flutter/material.dart';
import 'package:invoice_lite_flutterv1/database/dataBase.dart';
import 'package:invoice_lite_flutterv1/models/invoice.dart';
import 'package:invoice_lite_flutterv1/screens/customerScreen.dart';
import 'package:invoice_lite_flutterv1/screens/addInvoiceScreen.dart';
import 'package:invoice_lite_flutterv1/screens/invoicescreen.dart';
import 'package:invoice_lite_flutterv1/screens/productScreen.dart';
import 'package:provider/provider.dart';
import './models/item.dart';
import 'screens/addCustomerScreen.dart';
import 'screens/addProductScreen.dart';

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
        ChangeNotifierProvider.value(value: InvoiceItem())
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.deepPurple,
          ),
          home: InvoiceScreen(),
          routes: {
            InvoiceScreen.routeName: (ctx) => InvoiceScreen(),
            InvoiceEntry.routeName: (ctx) => InvoiceEntry(),
            ProductScreen.routeName: (ctx) => ProductScreen(),
            CustomerScreen.routeName: (ctx) => CustomerScreen(),
            AddProductScreen.routeName: (ctx) => AddProductScreen(),
            AddCustomerScreen.routeName: (ctx) => AddCustomerScreen(),
          }),
    );
  }
}
