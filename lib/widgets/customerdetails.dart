import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:invoice_lite_flutterv1/database/dataBase.dart';
import 'package:invoice_lite_flutterv1/models/customer.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../models/invoice.dart';
//import 'package:dropdown_formfield/dropdown_formfield.dart';

class CustomerEntry extends StatefulWidget {
  final Function selectDate;
  final Function invoice;
  final Function custName;
  final Function custm;
  CustomerEntry(this.selectDate, this.invoice, this.custName, this.custm);
  @override
  _CustomerEntryState createState() => _CustomerEntryState();
}

class _CustomerEntryState extends State<CustomerEntry> {
  final formKey = GlobalKey<FormState>();
  String _nameController;
  DateTime _selectedDate;
  String custAddress;
  Customer customers;
  final invoiceController = TextEditingController();

  void dateSelector() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((value) {
      setState(() {
        _selectedDate = value;
        widget.selectDate(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final customer = Provider.of<Data>(context).customers;
    final custName = customer.map((e) => e.custname).toList();
    if (_nameController == null) {
      custAddress = '';
    } else {
      final index =
          customer.indexWhere((element) => element.custname == _nameController);
      custAddress = customer[index].custaddress;
      customers = customer[index];
    }

    final media = MediaQuery.of(context).size;
    return Container(
      width: media.width,
      child: Form(
        key: formKey,
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
                            border: Border.all(width: 1, color: Colors.grey),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Text(
                              _selectedDate == null
                                  ? 'Select'
                                  : DateFormat.yMd().format(_selectedDate),
                              style: TextStyle(
                                  fontWeight: _selectedDate == null
                                      ? FontWeight.normal
                                      : FontWeight.bold,
                                  fontSize: _selectedDate == null ? 15 : 18),
                            ),
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
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter invoice number';
                            } else {
                              return null;
                            }
                          },
                          controller: invoiceController,
                          onSaved: (value) {
                            setState(() {
                              widget.invoice(int.parse(value));
                            });
                          },
                          style: TextStyle(fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.fromLTRB(10.0, 4.0, 10.0, 3.0),
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
                    child: FormField(onSaved: (value) {
                      setState(() {
                        widget.custName(value);
                        widget.custm(customers);
                      });
                    },
                        // validator: (value){
                        //   if(value==null){
                        //     return 'Select a name';
                        //   }else{
                        //     return null;
                        //   }
                        // },
                        builder: (_) {
                      return InputDecorator(
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.fromLTRB(5.0, 3.0, 3.0, 1.0),
                          //labelStyle: textStyle,
                          // errorStyle: TextStyle(
                          //     color: Colors.redAccent, fontSize: 16.0),
                          // hintText: 'Please select expense',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: 2),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(border: InputBorder.none),
                          value: _nameController,
                          items: custName
                              .map((label) => DropdownMenuItem(
                                    child: Text(
                                      label.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    value: label,
                                  ))
                              .toList(),
                          hint: Text('Customer Name'),
                          onChanged: (value) {
                            setState(() {
                              _nameController = value;
                            });
                          },
                        ),
                      );
                    }),
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
                  custAddress,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
