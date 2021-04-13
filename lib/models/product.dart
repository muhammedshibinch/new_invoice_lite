import 'package:flutter/foundation.dart';

class Product {
  final int itemid;
  final String itemname;
  final double itemprice;
  final int openingqty;
  Product({
    @required this.itemid,
    @required this.itemname,
    @required this.itemprice,
    @required this.openingqty,
  });
}
