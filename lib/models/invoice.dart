import 'customer.dart';
import 'package:flutter/foundation.dart';
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
class Invoice {
  final int invno;
  final DateTime invdate;
  final Customer customer;
  final double totalamount;
  final List<ItemData> itemlist;
  Invoice(
      {@required this.invno,
      @required this.invdate,
      @required this.customer,
      @required this.totalamount,
      @required this.itemlist});
}
