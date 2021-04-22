import 'package:flutter/material.dart';
import 'package:invoice_lite_flutterv1/models/invoice.dart';
import 'package:provider/provider.dart';
import 'addlinerow.dart';
import '../models/item.dart';

class TableSection extends StatefulWidget {
  final Function total;
  TableSection(this.total);
  @override
  _TableSectionState createState() => _TableSectionState();
}

class _TableSectionState extends State<TableSection> {
 
  int qty;
  String itemName;
  double price;
  double amount;
  int qtyCount(qtycnt){
    return qty = qtycnt;
}
String _itemname(itmname){
   return itemName=itmname;
}

double priceitem(value){
  return price=value;
}
double _amount(value){
  return amount=value;
}
  int count = 1;
  var sum = 0.0;
  var _total =0.0;
  void _addrow() {
    setState(() {
      count = count + 1;
    });
  }

  // void totalAmount(double total) {  
  //     sum = sum + total;   
  // }
  double get _totalAmount{
    double _total =0.0;
    final list =Provider.of<Item>(context).items;
    list.forEach((element) { 
      _total=_total+element.lineamt;
    });
    return _total;
  }
  
  Widget container(String text, double wth) {
    return Container(
      padding: EdgeInsets.only(left: 5, top: 2),
      decoration:
          BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
      width: MediaQuery.of(context).size.width * wth,
      height: 25,
      child: Text(text),
    );
  }

  @override
  Widget build(BuildContext context) {

    //final sumtotal=Provider.of<Item>(context).totalAmt;
    
    
    final tamountController=TextEditingController(
       text: '$_totalAmount'
     // text: '$sumtotal'
      );
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Items:'),
              ElevatedButton(
                  onPressed: _addrow,
                  child: Text('Add Line'),
                  style: ElevatedButton.styleFrom(primary: Colors.black))
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              container('ITEM', .4),
              container('QTY', .1),
              container('PRICE', .2),
              container('AMOUNT', .2)
            ],
          ),
          Container(
            height: 145,
            child: ListView.builder(
                itemCount: count,
                itemBuilder: (ctx, i) => AddLineRow(
                  //totalAmount,
                  _itemname,
                  qtyCount,
                  priceitem,
                  _amount,
                  ),),
          ),
          SizedBox(
            height: 10,
          ),

//-----------------------------------Total Amount--------------------------------------
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('Total Amount  '),
              Container(
                width: 150,
                height: 40,
                child: TextFormField(
                  onSaved: (_){
                    widget.total(_total);
                  },
                  controller: tamountController,
                  enabled: false,
                  style: TextStyle(fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
