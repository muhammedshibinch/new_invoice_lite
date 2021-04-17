import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:invoice_lite_flutterv1/database/dataBase.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
//import 'package:dropdown_formfield/dropdown_formfield.dart';

class CustomerEntry extends StatefulWidget {
  final Function selectDate;
  final Function invoice;
  final Function custName;
  CustomerEntry(this.selectDate,this.invoice,this.custName);
  @override
  _CustomerEntryState createState() => _CustomerEntryState();
}

class _CustomerEntryState extends State<CustomerEntry> {
  //final List<String> subjects = ['hy', 'hi', 'yu'];
  String selectedObject = 'Alex Jones';
  DateTime _selectedDate;
  final invoiceController = TextEditingController();
  

  void dateSelector(){
     showDatePicker(
      context: context, 
      initialDate: DateTime.now(), 
      firstDate: DateTime(2019), 
      lastDate: DateTime.now()).then((value) {
        setState(() {
          _selectedDate = value;
          widget.selectDate(value);
        }); 
      });
  }

  @override
  Widget build(BuildContext context) {
    // print(selectedObject);
    // print(_selectedDate);

    final customer = Provider.of<Data>(context).customers;
    final custname = customer.map((e) => e.custname).toList();
    final index =
        customer.indexWhere((element) => element.custname == selectedObject);
    final cuaddress = customer[index].custaddress;
    final media = MediaQuery.of(context).size;
    return Container(
      width: media.width,
     
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              width: media.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
//------------------------------------Date Section-----------------------------------
                  Row(
                    children: [
                      Text('Date :  '),
                      InkWell(
                        onTap: dateSelector,
                        child: Container(
                          width: 100,
                          height: 40,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1,color: Colors.grey),
                            borderRadius:BorderRadius.circular(15), 
                          ),
                          child: Center(child: Text(_selectedDate==null ?'Select': DateFormat.yMd().format(_selectedDate),
                          style: TextStyle(
                            fontWeight:_selectedDate==null?FontWeight.normal: FontWeight.bold,
                            fontSize:_selectedDate==null?15: 18
                          ),),
                        ),
                      ),
                      ),
                    ],
                  ),

//-----------------------------------Invoice Section-------------------------------

                  Row(
                    children: [
                      Text('Invoice No :  '),
                      Container(
                        width: 100,
                        height: 40,
                        child: TextFormField(
                          validator: (value){
                            if(value.isEmpty){
                              return 'Enter invoice number';
                            }
                            else{
                              return null;
                            }
                          },
                          controller: invoiceController,
                          onSaved: (value){
                            setState(() {
                              widget.invoice(value);
                            });
                          },
                          style: TextStyle(fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(10.0, 4.0, 10.0, 3.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),

//---------------------------------------CustomerName section-----------------------------------------
            Container(
              width: media.width,
              child: Row(
                children: [
                  Text('Customer :  '),
                  Container(
                    width: 150,
                    height: 45,
                    //padding: EdgeInsets.only(left: 16, right: 16),
                    // decoration: BoxDecoration(
                    //     border: Border.all(color: Colors.grey, width: 1),
                    //     borderRadius: BorderRadius.circular(15)),
                    child: FormField<String>(
                      onSaved: (value){
                        widget.custName(value);
                      },
                      builder: (FormFieldState<String> state) {
                        return InputDecorator(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(8.0, 4.0, 5.0, 3.0),
                            //labelStyle: textStyle,
                            // errorStyle: TextStyle(
                            //     color: Colors.redAccent, fontSize: 16.0),
                            // hintText: 'Please select expense',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(width: 2),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                          isEmpty: selectedObject == '',
                          child: 
                          DropdownButtonHideUnderline(
                            child: 
                            DropdownButton<String>(
                              value: selectedObject,
                              isDense: true,
                              onChanged: (String newValue) {
                                setState(() {
                                  selectedObject = newValue;
                                  
                                  state.didChange(newValue);
                                });
                              },
                              items: custname.map((value) {
                                return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                    ),);
                              }).toList(),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),

//------------------------------------Customer Address section---------------------------------------------
            Text('Customer Address'),

            Container(
              width: 250,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                border: Border.all(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text(
                  cuaddress,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
    );
  }
}
