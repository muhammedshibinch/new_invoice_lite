import 'package:flutter/material.dart';

import 'newLine.dart';

class TableSection extends StatefulWidget {
  final Function total;
  TableSection(this.total);
  @override
  _TableSectionState createState() => _TableSectionState();
}

class _TableSectionState extends State<TableSection> {
  int count = 1;
  void _addrow() {
    setState(() {
      count = count + 1;
    });
  }

  int qty;
  String itemName;
  double price;
  double amount;

  int _qtyCount(qtycnt) {
    return qty = qtycnt;
  }

  String _itemname(itmname) {
    return itemName = itmname;
  }

  double _priceitem(value) {
    return price = value;
  }

  double _amount(value) {
    return amount = value;
  }

  // double get _totalAmount{
  //   double _total =0.0;
  //   final list =Provider.of<Item>(context).items;
  //   list.forEach((element) {
  //     _total=_total+element.lineamt;
  //   });
  //   return _total;
  // }

  //  double _totalAmount=0.0;
  // void _total(double amount){
  //    setState(() {
  //      _totalAmount = _totalAmount + amount;
  //    });
  // }

  Widget container(String text, double wth) {
    return Container(
      padding: EdgeInsets.only(left: 5, top: 2),
      decoration:
          BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
      width: MediaQuery.of(context).size.width * wth,
      height: 25,
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final totalController = TextEditingController(text: '$_totalAmount');
    // final labelStyle =
    //     TextStyle(fontSize: 16, color: Theme.of(context).primaryColor);
    return Container(
      //margin: EdgeInsets.symmetric(vertical: 5),
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Items:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              ElevatedButton(
                  onPressed: _addrow,
                  child: Text('Add Line'),
                  style: ElevatedButton.styleFrom(primary: Colors.black)),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              container('ITEM', .33),
              container('QTY', .1),
              container('PRICE', .23),
              container('AMOUNT', .23)
            ],
          ),
          Container(
            height: 145,
            child: ListView.builder(
              itemCount: count,
              itemBuilder: (ctx, i) => NewLine(
                widget.total,
                _itemname,
                _qtyCount,
                _priceitem,
                _amount,
              ),
            ),
          ),
          // SizedBox(width: 20),
          // Container(
          //         padding: EdgeInsets.only(bottom: 25),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.end,
          //           children: [
          //             Container(
          //               width: 200,
          //               height: 40,
          //               child: TextFormField(
          //                 onSaved: (_) {
          //                   // widget.total(_total);
          //                 },
          //                 controller: totalController,
          //                 enabled: false,
          //                 style: TextStyle(fontWeight: FontWeight.bold),
          //                 decoration: InputDecoration(
          //                   labelText: 'TotalAmount',
          //                   labelStyle: labelStyle,
          //                   contentPadding: EdgeInsets.all(10),
          //                   disabledBorder: OutlineInputBorder(
          //                     borderSide:
          //                         BorderSide(width: 2, color: Colors.grey),
          //                     borderRadius: BorderRadius.circular(15.0),
          //                   ),
          //                 ),
          //               ),
          //             ),
          //             SizedBox(width: 20)
          //           ],
          //         ),
          //       ),
        ],
      ),
    );
  }
}
