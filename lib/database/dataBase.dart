import 'package:flutter/material.dart';
import 'package:invoice_lite_flutterv1/models/customer.dart';
import 'package:invoice_lite_flutterv1/models/invoice.dart';
import 'package:invoice_lite_flutterv1/models/product.dart';

class Data with ChangeNotifier {
  final List<Product> products = [
    Product(
        itemid: 1, itemname: 'Lenovo Laptop', itemprice: 40000, openingqty: 10),
    Product(itemid: 2, itemname: 'iPhone 11', itemprice: 80000, openingqty: 25),
    Product(
        itemid: 3, itemname: 'Samsung Note7', itemprice: 28000, openingqty: 18),
  ];

  final List<Customer> customers = [
    Customer(
        custid: 1,
        custname: 'Alex Jones',
        openingbal: 120000,
        custaddress: 'PO BOX 804'),
    Customer(
        custid: 2,
        custname: 'Adam John',
        openingbal: 150000,
        custaddress: 'PO CROSS LINE 12'),
  ];

  final List<Invoice> invoices = [
    // Invoice(
    //   invno: 1,
    //   invdate: DateTime.now(),
    //   customer: null,
    //   totalamount: 12000,
    //   itemlist: [Product(itemid: itemid, itemname: itemname, itemprice: itemprice, openingqty: openingqty)])
  ];
}
