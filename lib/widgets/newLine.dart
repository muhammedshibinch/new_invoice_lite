import 'package:flutter/material.dart';
import 'package:invoice_lite_flutterv1/database/dataBase.dart';
import 'package:invoice_lite_flutterv1/models/product.dart';
import 'package:provider/provider.dart';

class NewLine extends StatefulWidget {
  final Function giveTotal;
  final Function additem;

  NewLine(this.giveTotal, this.additem);

  _NewLineState createState() => _NewLineState();
}

class _NewLineState extends State<NewLine> {
  double price = 0;
  final _qtyController = TextEditingController();
  int _qtycount = 0;
  String _selectedObject;
  Product product;
  @override
  void initState() {
    super.initState();
    _qtyController.addListener(_onqtyCountChanged);
  }

  _onqtyCountChanged() {
    setState(() {
      _qtycount = int.tryParse(_qtyController.text) ?? 0;
    });
  }

  getTotalAmount() {
    if (_qtycount > 0 || price > 0) {
      return price * _qtycount;
    }
    return 0.0;
  }

  @override
  void dispose() {
    _qtyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final amountcontroller =
        TextEditingController(text: getTotalAmount().toString());
    final media = MediaQuery.of(context).size;
    final item = Provider.of<Data>(context).products;
    final productname = item.map((e) => e.itemname).toList();
    if (_selectedObject == null) {
      price = 0;
    } else {
      final index =
          item.indexWhere((element) => element.itemname == _selectedObject);
      price = item[index].itemprice;
      product = item[index];
    }
    final pricecontroller = TextEditingController(text: '$price');
    return Row(
      children: [
//--------------------------------item section----------------------------------------
        Container(
          width: media.width * .33,
          height: 45,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: DropdownButtonFormField(
            decoration: InputDecoration(border: InputBorder.none),
            value: _selectedObject,
            items: productname.map((value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              );
            }).toList(),
            isExpanded: true,
            hint: Text(
              'Select Item',
              style: TextStyle(fontSize: 15),
            ),
            onChanged: (value) {
              setState(() {
                _selectedObject = value;
                widget.giveTotal(getTotalAmount());
              });
            },
          ),
        ),

//--------------------------------- qty section ------------------------------------------------
        Container(
          width: media.width * .1,
          height: 45,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: TextFormField(
            controller: _qtyController,
            validator: (value) {
              if (value.isEmpty) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('Enter a Quantity')));
              }
              return null;
            },
            enabled: _selectedObject == null ? false : true,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                _qtycount = int.parse(value, onError: (source) => 0);
                widget.giveTotal(getTotalAmount());
                widget.additem(
                  product,
                  _qtycount,
                  price,
                  getTotalAmount(),
                );
              });
            },
          ),
        ),
//---------------------------------- price section -----------------------------------------
        Container(
          width: media.width * .23,
          height: 45,
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          child: TextFormField(
            controller: pricecontroller,
            enabled: false,
          ),
        ),
//----------------------------------amount section------------------------------------------
        Container(
          width: media.width * .23,
          height: 45,
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          child: TextFormField(
            controller: amountcontroller,
          ),
        ),
      ],
    );
  }
}
