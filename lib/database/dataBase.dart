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

  List<Invoice>_invoice=[
    Invoice(
      invno: 1, 
      invdate:DateTime.now() , 
      customer: Customer(custid: 1,custname:'Alex Jones',openingbal: 120000,custaddress:'PO BOX 804' ), 
      totalamount: 120000, 
      itemlist:[
        ItemData(product:Product(itemid: 1, itemname: 'Lenovo Laptop', itemprice: 40000, openingqty: 10),itemqty: 3,itemprice: 40000,lineamt: 120000), 
      ]),
  ];
 List<Invoice> get invoice{
     return [..._invoice];
 }
}
