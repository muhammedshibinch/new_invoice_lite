import 'package:flutter/material.dart';
import 'addlinerow.dart';

class TableSection extends StatefulWidget {
  @override
  _TableSectionState createState() => _TableSectionState();
}

class _TableSectionState extends State<TableSection> {
  int count = 1;
  double sum = 0.0;
  void _addrow() {
    setState(() {
      count = count + 1;
    });
  }

  void totalAmount(double total) {
    setState(() {
      sum = sum + total;
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
                itemBuilder: (ctx, i) => AddLineRow(totalAmount)),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('Total Amount  '),
              Container(
                width: 150,
                height: 40,
                child: TextField(
                  decoration: InputDecoration(
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
