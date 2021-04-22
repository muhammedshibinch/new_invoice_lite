import 'dart:ui';
import 'package:invoice_lite_flutterv1/models/invoice.dart';
import 'package:invoice_lite_flutterv1/models/product.dart';

import '../models/item.dart';
import 'package:flutter/material.dart';
import 'package:invoice_lite_flutterv1/database/dataBase.dart';
import 'package:provider/provider.dart';

class AddLineRow extends StatefulWidget {
  //final Function totalsum;
  final Function itemname;
  final Function qtycount;
  final Function price;
  final Function amount;
  AddLineRow(
      //this.totalsum, 
      this.itemname, this.qtycount, this.price, this.amount);
  @override
  _AddLineRowState createState() => _AddLineRowState();
}

class _AddLineRowState extends State<AddLineRow> {
  var qtyController = TextEditingController();
  String _selectedObject;
  var price;
  Product product;
  var qtynum;
   double get lineamt{
     double line=0.0;
     line=qtynum * price;
     return line;
    }
    
  @override
  Widget build(BuildContext context) {
    //Provider.of<Item>(context,listen: false).addItem(product, qtynum, price,lineamt);
   // var qty = int.tryParse(qtyController.text);
    //final focusNode1 =FocusNode(); 
    final media = MediaQuery.of(context).size;
    final item = Provider.of<Data>(context).products;
    final productname = item.map((e) => e.itemname).toList();
    if(_selectedObject==null){
      price='';
    }else{
      final index =
        item.indexWhere((element) => element.itemname == _selectedObject);
    price = item[index].itemprice;
    product=item[index];
    }
    final pricecontroller = TextEditingController(text: '$price');
    final amountcontroller =
        TextEditingController(
          text: '${qtynum == null ? 0 : qtynum * price}'
          );
          
    //final itemlist = Provider.of<Item>(context,listen: false);
     final itemcount =Provider.of<Item>(context).items;
    //final invoice = Provider.of<InvoiceItem>(context).invoice;
    //Provider.of<Item>(context,listen: false).addItem(product, qtynum, price,lineamt);
   
    //-------------------------------print------------------------------
    


    


    // print(itemcount.length);
    // print(itemcount.map((e) => e.lineamt).toList());
    // print(itemcount.map((e) => e).toList());
    // print(itemcount.map((e) => e.itemqty).toList());
    // print(itemcount.map((e) => e.itemprice).toList());
    //print(invoice.length);
    // print(invoice.map((e) => e.invdate).toList());
    // print(invoice.map((e) => e.customer).toList());
    
    







    //------------------------------------------------------------
    
    
    
    
    
    
    return Row(
      children: [
//--------------------------------item section----------------------------------------
        Container(
          width: media.width * .4,
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
                        value,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                      ),
                    );
                  }).toList(),
                  isExpanded: true,
                  hint: Text('Select Item',style: TextStyle(fontSize: 18),),
                  onChanged: (value) {
                    setState(() {
                      _selectedObject = value;
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

       

//---------------------------------qty section------------------------------------------------
        Container(
          width: media.width * .1,
          height: 45,
          decoration: BoxDecoration(border: Border.all(width: 1,color: Colors.grey),),
          child: TextFormField(
            //initialValue: '0',
            enabled: _selectedObject==null?false:true,
            onSaved: (_) {
              widget.qtycount(qtynum);
            },
            // decoration: InputDecoration(
            //   border:
            //       OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
            // ),
            keyboardType: TextInputType.number,
            controller: qtyController,
            onFieldSubmitted: (value) {
              qtynum=int.parse(value);
              //FocusScope.of(context).requestFocus(focusNode1);
              //final lineamt=double.parse(value) * price;
              //qtynum=value;
              // widget.totalsum(lineamt);
             Provider.of<Item>(context,listen: false).addItem(product, qtynum, price,lineamt);
            },
          ),
        ),
//----------------------------------price section-----------------------------------------
        Container(
          width: media.width * .2,
          height: 45,
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          child: TextFormField(
            onSaved: (_) {
              widget.price(price);
            },
            controller: pricecontroller,
            enabled: false,
          ),
        ),

//----------------------------------amount section------------------------------------------
        Container(
          width: media.width * .2,
          height: 45,
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          child: TextFormField(
        //focusNode: focusNode1,
            //initialValue: '${qtynum == null ? 0 : qtynum * price}',
            enabled: false,
            onSaved: (_) {
                widget.amount(lineamt);
            },
            // onFieldSubmitted: (_){
            //   Provider.of<Item>(context,listen: false).addItem(product, qtynum, price,lineamt);
            //   FocusNode().unfocus();
            // },
           controller: amountcontroller,
          //enabled: false,
          ),
          
        ),
      ],
    );
  }
}
