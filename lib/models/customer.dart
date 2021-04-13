import 'package:flutter/foundation.dart';

class Customer {
  final int custid;
  final String custname;
  final double openingbal;
  final String custaddress;
  Customer(
      {@required this.custid,
      @required this.custname,
      @required this.openingbal,
      @required this.custaddress});
}
