import 'customer.dart';
import 'package:flutter/foundation.dart';

class Invoice {
  final int invno;
  final DateTime invdate;
  final Customer customer;
  final double totalamount;
  final List<Map<String, Object>> itemlist;
  Invoice(
      {@required this.invno,
      @required this.invdate,
      @required this.customer,
      @required this.totalamount,
      @required this.itemlist});
}
