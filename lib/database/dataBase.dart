import 'package:flutter/material.dart';
import 'package:invoice_lite_flutterv1/models/customer.dart';
import 'package:invoice_lite_flutterv1/models/product.dart';

class Data with ChangeNotifier {
  final List<Product> _products = [
    Product(
        itemid: 1, itemname: 'Lenovo Laptop', itemprice: 40000, openingqty: 10),
    Product(itemid: 2, itemname: 'iPhone 11', itemprice: 80000, openingqty: 25),
    Product(
        itemid: 3, itemname: 'Samsung Note7', itemprice: 28000, openingqty: 18),
  ];

  List<Product> get products {
    return [..._products];
  }

  void addProduct(int id, String name, double price, int qty) {
    final newProduct = Product(
      itemid: id,
      itemname: name,
      itemprice: price,
      openingqty: qty,
    );
    _products.add(newProduct);
  }

  void removeProduct(int id) {
    _products.removeWhere((tx) => tx.itemid == id);
    notifyListeners();
  }

  final List<Customer> _customers = [
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

  List<Customer> get customers {
    return [..._customers];
  }

  void addCustomer(int id, String name, double bal, String address) {
    final newCust = Customer(
      custid: id,
      custname: name,
      openingbal: bal,
      custaddress: address,
    );
    _customers.add(newCust);
  }

  void romoveCustomer(int id) {
    _customers.removeWhere((element) => element.custid == id);
    notifyListeners();
  }

  notifyListeners();
}
