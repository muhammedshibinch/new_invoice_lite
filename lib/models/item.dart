import 'package:flutter/material.dart';
import 'product.dart';
class ItemData {
  final Product product;
  final int itemqty;
  final double itemprice;
  final double lineamt;
  ItemData({
    @required this.product,
    @required this.itemqty,
    @required this.itemprice,
    @required this.lineamt
  });
}

class Item with ChangeNotifier{
  List<ItemData> _items=[];
  List<ItemData> get items{
    return [..._items];
  }

  

  void addItem(Product ourproduct,int qty,double price,double lineamount){
    
    // double amt;
    // if(qty==null){
    //   amt=price * double.parse(qty);
    // }else{
    //   amt= price * qty;
    // }
     final newitem=ItemData(
       product: ourproduct, 
       itemqty: qty, 
       itemprice: price, 
       lineamt: lineamount);
     _items.add(newitem);
  }
  notifyListeners();

  double get totalAmt {
    double amount =0.0;
    _items.forEach((element) {
      amount += element.lineamt;
     });
     return amount;
  }
}