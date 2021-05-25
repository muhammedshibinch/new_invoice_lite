import 'package:flutter/material.dart';
import 'package:invoice_lite_flutterv1/models/item.dart';
import 'package:invoice_lite_flutterv1/models/product.dart';
import 'newLine.dart';

class TableSection extends StatefulWidget  {
  final Function total;
  final List<ItemData> tableitem;
  TableSection(this.total, this.tableitem);
  @override
  _TableSectionState createState() => _TableSectionState();
}

class _TableSectionState extends State<TableSection> {
  void additem(
    Product product,
    int itemqty,
    double itemprice,
    double lineamt
    ){
    widget.tableitem.add(
      ItemData(
        product: product, 
        itemqty: itemqty, 
        itemprice: itemprice, 
        lineamt: lineamt
        ),
    );
  }

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
    return Container(

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
              itemBuilder: (ctx, i) =>
                  NewLine(
                widget.total, 
                additem
              ),
            ),
          ),
        ],
      ),
    );
  }
}
