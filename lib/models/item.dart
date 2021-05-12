import 'package:flutter/material.dart';
import 'product.dart';

class ItemData {
   final Product product;
  final int itemqty;
  final double itemprice;
  final double lineamt;
  ItemData(
      {@required this.product,
      @required this.itemqty,
      @required this.itemprice,
      @required this.lineamt});
}

class Item with ChangeNotifier {
  double total = 0.0;
  List<ItemData> _items = [];
  List<ItemData> get items {
    return [..._items];
  }

  void addItem(Product ourproduct, int qty, double price, double lineamount) {
    
    final newitem = ItemData(
        product: ourproduct,
        itemqty: qty,
        itemprice: price,
        lineamt: lineamount);
    _items.add(newitem);
  }

  notifyListeners();

<<<<<<< HEAD
=======

// Farook: Use list.fold method below to find the sum
  double get totalAmount {
    final list = _items.map((e) => e.lineamt).toList();
    list.forEach((item) {
      total = total + item;
    });
    return total;
  }
>>>>>>> 022d4ee03245468c9a5a1099aaf0cd3e33a9fe13
}
