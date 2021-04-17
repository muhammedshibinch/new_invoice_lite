import 'package:flutter/material.dart';
import 'package:invoice_lite_flutterv1/models/invoice.dart';
import 'addlinerow.dart';
//import 'product.dart';

class TableSection extends StatefulWidget {
  @override
  _TableSectionState createState() => _TableSectionState();
}

class _TableSectionState extends State<TableSection> {
  String qty;
  String itemName;
 
  String price;
  String amount;
  String qtyCount(qtycnt){
    qty = qtycnt;
}
String _itemname(itmname){
   itemName=itmname;
}

String priceitem(value){
  price=value;
}
String _amount(value){
  amount=value;
}
   String tamt;
  int count = 1;
  var sum = 0.0;
  void _addrow() {
    setState(() {
      count = count + 1;
    });
  }

  void totalAmount(double total) {  
      sum = sum + total;   
  }
 final listItem=[
   ItemData(product:null,itemqty: 3,itemprice: 40000,lineamt: 120000), 
 ];
  void itemData(){
    final newList=ItemData(product: null, itemqty: int.parse(qty), 
    itemprice: double.parse(price), lineamt: double.parse(amount));
    setState(() {
      listItem.add(newList);
    });
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
    final tamountController=TextEditingController(text: '$sum');
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
                  totalAmount,
                  _itemname,
                  qtyCount,
                  priceitem,
                  _amount,
                  )),
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
