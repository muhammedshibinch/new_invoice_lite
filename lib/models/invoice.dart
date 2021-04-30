import 'customer.dart';
import 'package:flutter/foundation.dart';
import 'item.dart';
import 'product.dart';
import 'package:intl/intl.dart';

class Invoice {
  final String id;
  final int invno;
  final String invdate;
  final Customer customer;
  final double totalamount;
  final List<ItemData> itemlist;
  Invoice(
      {@required this.id,
      @required this.invno,
      @required this.invdate,
      @required this.customer,
      @required this.totalamount,
      @required this.itemlist});
}

class InvoiceItem with ChangeNotifier {
  List<Invoice> _invoice = [
    Invoice(
        id: DateTime.now().toString(),
        invno: 1,
        invdate: '2021-04-19',
        customer: Customer(
            custid: 1,
            custname: 'Alex Jones',
            openingbal: 120000,
            custaddress: 'PO BOX 804'),
        totalamount: 120000,
        itemlist: [
          ItemData(
              product: Product(
                  itemid: 1,
                  itemname: 'Lenovo Laptop',
                  itemprice: 40000,
                  openingqty: 10),
              itemqty: 3,
              itemprice: 40000,
              lineamt: 120000),
          ItemData(
              product: Product(
                  itemid: 2,
                  itemname: 'iPhone 6',
                  itemprice: 40000,
                  openingqty: 10),
              itemqty: 3,
              itemprice: 40000,
              lineamt: 120000),
        ]),
  ];
  List<Invoice> get invoice {
    return [..._invoice];
  }

  void addInvoice(int invoiceno, String date, Customer customerdetail,
      double totalamt, List<ItemData> itemslist) {
    final newInvoice = Invoice(
        id: DateTime.now().toString(),
        invno: invoiceno,
        invdate: date,
        customer: customerdetail,
        totalamount: totalamt,
        itemlist: itemslist);
    _invoice.add(newInvoice);
  }

  void removeInvoice(String id) {
    _invoice.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  notifyListeners();
}
