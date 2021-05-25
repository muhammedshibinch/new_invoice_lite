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
