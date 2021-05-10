import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:invoice_lite_flutterv1/models/invoice.dart';
import 'package:invoice_lite_flutterv1/models/customer.dart';
import 'package:invoice_lite_flutterv1/models/item.dart';
import 'package:invoice_lite_flutterv1/screens/invoicescreen.dart';
import 'package:invoice_lite_flutterv1/widgets/tablePart.dart';
import 'package:provider/provider.dart';
import 'package:invoice_lite_flutterv1/database/dataBase.dart';

class InvoiceEntry extends StatefulWidget {
  static const routeName = '/invoiceentry';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<InvoiceEntry> {
  final List<ItemData> tableitem = [];
  final formKey = GlobalKey<FormState>();
  int invoiceNum;
  //DateTime _selectedDate;
  String _nameController;
  String custAddress;
  Customer customers;
  String _dateSelected;
  double totalAmount = 0.0;
  void dateSelector() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((value) {
      setState(() {
        //String date = DateFormat.yMd().format(value);
        //_selectedDate = value;
        _dateSelected = DateFormat.yMd().format(value);
      });
    });
  }

  double _totalAmount = 0.0;
  void _total(double amount) {
    setState(() {
      _totalAmount = _totalAmount + amount;
    });
  }

  @override
  Widget build(BuildContext context) {
    final totalController = TextEditingController(text: '$_totalAmount');

    // final list = Provider.of<Item>(context).totalAmount;
    // print(list.map((e) => e.lineamt).toList());
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

    final dateController = TextEditingController(
        text: '${_dateSelected == null ? '' : _dateSelected}');
    final addressController = TextEditingController(
        text: '${custAddress.isEmpty ? '' : custAddress}');
    //final totalController = TextEditingController(text: '$list');
    final labelStyle =
        TextStyle(fontSize: 16, color: Theme.of(context).primaryColor);

    return Scaffold(
      appBar: AppBar(
        title: Text('Invoice Entry'),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_sharp),
            onPressed: () {
              Navigator.of(context)
                  .pushReplacementNamed(InvoiceScreen.routeName);
            }),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height * .8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.only(bottom: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //-----------------------------------------------------------   Invoive Number----------------------------------------------------------------
                          Container(
                            width: 150,
                            height: 40,
                            child: TextFormField(
                              validator: (value) {
                                if (value.isEmpty) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text('Enter a Invoice Number'),
                                    backgroundColor:
                                        Theme.of(context).errorColor,
                                  ));
                                }
                                return null;
                              },
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                labelText: 'Invoice No',
                                labelStyle: labelStyle,
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 3, color: Colors.black),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 1, color: Colors.grey),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 3, color: Colors.red),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 3, color: Colors.red),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              onSaved: (value) {
                                invoiceNum = int.parse(value);
                              },
                            ),
                          ),

                          //------------------------------------------------------------Date Selection-------------------------------------------------------------------------------

                          Row(
                            children: [
                              Container(
                                width: 150,
                                height: 40,
                                child: TextFormField(
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text('Select a date'),
                                        backgroundColor:
                                            Theme.of(context).errorColor,
                                      ));
                                    }
                                    return null;
                                  },
                                  onTap: dateSelector,
                                  enabled: _dateSelected == null ? true : false,
                                  controller: dateController,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    labelText: 'Date',
                                    labelStyle: labelStyle,
                                    disabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1, color: Colors.grey),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1, color: Colors.grey),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1, color: Colors.grey),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1, color: Colors.red),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1, color: Colors.red),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

//----------------------------------------------------------Customer Name-----------------------------------------------------------------------

                    Container(
                      padding: EdgeInsets.only(bottom: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 150,
                            height: 45,
                            child: FormField(onSaved: (value) {
                              setState(() {
                                // widget.custName(value);
                                // widget.custm(customers);
                              });
                            }, builder: (_) {
                              return InputDecorator(
                                decoration: InputDecoration(
                                  labelText: 'CustomerName',
                                  labelStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColor),
                                  contentPadding:
                                      EdgeInsets.fromLTRB(5.0, 3.0, 3.0, 1.0),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2),
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                ),
                                child: DropdownButtonFormField(
                                  validator: (value) {
                                    if (value == null) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text('Select Customer name'),
                                        backgroundColor:
                                            Theme.of(context).errorColor,
                                      ));
                                    }
                                    return null;
                                  },
                                  decoration:
                                      InputDecoration(border: InputBorder.none),
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

//----------------------------------------------------------Customer Address-----------------------------------------------------------------------------

                          Container(
                            width: 200,
                            child: Center(
                              child: TextFormField(
                                enabled: false,
                                maxLines: 2,
                                controller: addressController,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                    disabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1, color: Colors.grey),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    labelText: 'Address',
                                    labelStyle: labelStyle),

                                // ? 'Customer Address'
                                // : custAddress,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
//----------------------------------------------------------------------------
                    TableSection(_total,tableitem),
//-----------------------------------------------------------------------------

                    SizedBox(width: 20),
                    Container(
                      padding: EdgeInsets.only(bottom: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: 200,
                            height: 40,
                            child: TextFormField(
                              onSaved: (_) {
                                // widget.total(_total);
                              },
                              controller: totalController,
                              enabled: false,
                              style: TextStyle(fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                labelText: 'TotalAmount',
                                labelStyle: labelStyle,
                                contentPadding: EdgeInsets.all(10),
                                disabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 2, color: Colors.grey),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 20)
                        ],
                      ),
                    ),
                    Center(
                      child: ElevatedButton.icon(
                          onPressed: () {
                            print(tableitem.map((e) => e.itemqty).toList());
                            final isValid = formKey.currentState.validate();
                            if (isValid) {
                              formKey.currentState.save();
                              //  final message = '$date\n$invoicenum\n$customerName';
                              //   //  print(message);
                              //   print(invoice.map((e) => e.invdate).toList());
                              //   print(invoice.map((e) => e.customer).toList());
                              //   print(invoice.length);
                              //   print(invoice.map((e) => e.invno).toList());
                              //   print(invoice.map((e) => e.itemlist).toList());
                              //   print(invoice.map((e) => e.totalamount).toList());
                              Provider.of<InvoiceItem>(context, listen: false)
                                  .addInvoice(
                                      invoiceNum,
                                      _dateSelected,
                                      customers,
                                      double.parse(totalController.text), tableitem.toList());
                            }
                            Navigator.of(context)
                                .pushReplacementNamed(InvoiceScreen.routeName);
                          },
                          icon: Icon(Icons.save),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 70),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          label: Text('SAVE')),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
