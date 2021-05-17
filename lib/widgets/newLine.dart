import 'package:flutter/material.dart';
import 'package:invoice_lite_flutterv1/database/dataBase.dart';
import 'package:invoice_lite_flutterv1/models/item.dart';
import 'package:invoice_lite_flutterv1/models/product.dart';
import 'package:provider/provider.dart';

class NewLine extends StatefulWidget {
  @override
  final Function giveTotal;
  final Function itemname;
  final Function qtycount;
  final Function price;
  final Function amount;
  final List<ItemData> tableitem;

  NewLine(
      this.giveTotal, 
      this.itemname, 
      this.qtycount, 
      this.price, 
      this.amount,
      this.tableitem
      );

  _NewLineState createState() => _NewLineState();
}

class _NewLineState extends State<NewLine> {
  //double price=0;

  static const defaultQtycount = 0;
  double price = 0;

  final _qtyController =
      TextEditingController(text: defaultQtycount.toString());

// final _priceController =
  // TextEditingController(text: defaultPriceamount.toString());

  int _qtycount = defaultQtycount;

  //double _priceamount = defaultPriceamount;

  @override
  void initState() {
    super.initState();
    _qtyController.addListener(_onqtyCountChanged);
    // _priceController.addListener(_onamountChanged);
  }

  _onqtyCountChanged() {
    setState(() {
      _qtycount = int.tryParse(_qtyController.text) ?? 0;
    });
  }

  getTotalAmount() {
    if (_qtycount != 0 || price != 0) {
      return _qtycount * price;
    }
    return 0.0;
  }

  @override
  void dispose() {
    _qtyController.dispose();
    super.dispose();
  }

  final rowKey = GlobalKey<FormState>();
  //------------------------------
  String itemname;
  int quantity;
  double itemprice;
  double totalprice;
  //------------------------------
  //double price;
  String _selectedObject;
  double amount;
  int qty = 0;
  Product product;

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
    // setState(() {
    //  widget.giveTotal(getTotalAmount());
    // });

    return Row(
      children: [
//--------------------------------item section----------------------------------------
        Container(
          width: media.width * .33,
          height: 45,
          child: FormField<String>(
            builder: (FormFieldState<String> state) {
              return InputDecorator(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(5.0, 2.0, 0.0, 0.0),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 2),
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
                child: DropdownButtonFormField(
                  decoration: InputDecoration(border: InputBorder.none),
                  value: _selectedObject,
                  items: productname.map((value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
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
                  onSaved: (_) {
                    setState(() {
                      widget.itemname(_selectedObject);
                    });
                  },
                ),
              );
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
                qty = int.parse(value,onError: (source) => 0);
                widget.giveTotal(getTotalAmount());
              }
              );
              // widget.giveTotal(getTotalAmount());
              //amount = double.parse(value) * price;
              //  print(amount);
              //  print(qty);
            },
            onSaved: (_) {
              widget.qtycount(qty);
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
            onSaved: (_) {
              widget.price(price);
            },
          ),
        ),
//----------------------------------amount section------------------------------------------
        Container(
          width: media.width * .23,
          height: 45,
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          child: TextFormField(
            //enabled: false,
            controller: amountcontroller,
            onChanged: (value) {
              setState(() {
                //totalprice = double.parse(value);
                //widget.giveTotal(getTotalAmount());
              });
            },
            onSaved: (_) {
              setState(() {
                widget.amount(totalprice);
              });
            },
          ),
        ),
      ],
    );
  }
}
