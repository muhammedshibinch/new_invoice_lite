import 'package:flutter/material.dart';
import 'package:invoice_lite_flutterv1/database/dataBase.dart';
import 'package:provider/provider.dart';

class AddLineRow extends StatefulWidget {
  final Function totalsum;
  final Function itemname;
  final Function qtycount;
  final Function price;
  final Function amount;
  AddLineRow(this.totalsum,this.itemname,this.qtycount,this.price,this.amount);
  @override
  _AddLineRowState createState() => _AddLineRowState();
}

class _AddLineRowState extends State<AddLineRow> {
  
  String selectedObject = 'Lenovo Laptop';
  final qtyController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    int qty=int.tryParse(qtyController.text);
    final media = MediaQuery.of(context).size;
    final item = Provider.of<Data>(context).products;
    final productname = item.map((e) => e.itemname).toList();
    final index =
        item.indexWhere((element) => element.itemname == selectedObject);
    var price = item[index].itemprice;
    final pricecontroller = TextEditingController(text: '$price');
    final amountcontroller = TextEditingController(text:'${qty ==null ?0: qty*price}');
    //print(amountcontroller.text);
   
    return   
           Row(
            children: [
//--------------------------------item section----------------------------------------
              Container(
                  
                  width: media.width * .4,
                  height: 25,
                  child: FormField<String>(
                    builder: (FormFieldState<String> state) {
                      return InputDecorator(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(5.0, 4.0, 5.0, 3.0),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: 2),
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                        isEmpty: selectedObject == '',
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedObject,
                            isDense: true,
                            onChanged: (String newValue) {
                              setState(() {
                                selectedObject = newValue;
                                state.didChange(newValue);
                              });
                            },
                            items: productname.map((value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    },
                    onSaved: (value){
                      setState(() {
                        widget.itemname(value);
                      });
                    },
                  ),


                  ),

//---------------------------------qty section------------------------------------------------
              Container(
                width: media.width * .1,
                height: 25,
                child: TextFormField(
                  onSaved: (value){
                     widget.qtycount(value);
                  },
                  decoration: InputDecoration(
                    border:
                        OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
                  ),
                  keyboardType: TextInputType.number,
                  controller: qtyController,
                  onFieldSubmitted: (value) {
                    
                      widget.totalsum(double.parse(value)*price);
                    
                  },
                  // onSaved: (value){
                  //   widget.totalsum(double.parse(value)*price);
                  // },
                ),
              ),
//----------------------------------price section-----------------------------------------
              Container(
                width: media.width * .2,
                height: 25,
                decoration:
                    BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
                child: TextFormField(
                  onSaved: (value){
                     widget.price(value);
                  },
                  controller: pricecontroller,
                  enabled: false,
                ),
                //Center(child: Text('$price')),
              ),

//----------------------------------amount section------------------------------------------
              Container(
                width: media.width * .2,
                height: 25,
                decoration:
                    BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
                child: TextFormField(
                  enabled: false,
                  onSaved: (value){
                    widget.amount(value);
                  },
                   controller:amountcontroller,
                 // enabled: false,
                ),
                // Center(
                //     child:
                //         qtycount == null ? Text('0') : Text('${price * qtycount}')),
              ),
            ],  
    );
  }
}
