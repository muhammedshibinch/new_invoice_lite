import 'package:flutter/material.dart';
import 'package:invoice_lite_flutterv1/database/dataBase.dart';
import 'package:invoice_lite_flutterv1/widgets/formfield.dart';
import 'package:provider/provider.dart';
import 'invoicescreen.dart';

class CustomerScreen extends StatelessWidget {
  static const routeName = '/customer';
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    int _id;
    String _name;
    double _bal;
    String _address;
     final itemid = Provider.of<Data>(context).customers.map((e) => e.custid).toList();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white10,
        title: Padding(
          padding: const EdgeInsets.only(left: 60),
          child: Text(
            'Customer Entry',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 23),
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pushNamed(InvoiceScreen.routeName);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'Add your customer details here',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                FormFieldArea(
                    'Enter Customer Id', 'Customer Id', TextInputType.number, 1,
                    (value) {
                  if (value.isEmpty) {
                    return 'Enter an Id';
                  }else if (itemid.contains(int.parse(value))){
                    return 'This Id is already existed';
                  }
                }, (data) {
                  _id = int.parse(data);
                }),
                FormFieldArea('Enter Customer Name', 'Customer Name',
                    TextInputType.text, 1, (value) {
                  if (value.isEmpty) {
                    return 'Enter a Name';
                  } else if (value.length <= 3) {
                    return 'Enter correct name';
                  }
                }, (data) {
                  _name = data;
                }),
                FormFieldArea(
                    'Enter Opening Balance',
                    'Customer Opening Balance',
                    TextInputType.number,
                    1, (value) {
                  if (value.isEmpty) {
                    return 'Enter opening Balance';
                  }
                }, (data) {
                  _bal = double.parse(data);
                }),
                FormFieldArea('Enter Customer Address', 'Customer Address',
                    TextInputType.multiline, 2, (value) {
                  if (value.isEmpty) {
                    return 'Enter an address';
                  }
                }, (data) {
                  _address = data;
                }),
                SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    final valid = formKey.currentState.validate();
                    formKey.currentState.save();
                    if (valid) {
                      Provider.of<Data>(context,listen: false).addCustomer(
                        _id,
                        _name,
                        _bal,
                        _address,
                      );
                      Navigator.of(context)
                       .pushReplacementNamed(InvoiceScreen.routeName);
                    } 
                  },
                  child: Container(
                      width: MediaQuery.of(context).size.width * .7,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Theme.of(context).primaryColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 1.0,
                              spreadRadius: 0.0,
                              offset: Offset(1.0, 1.0),
                            )
                          ]),
                      child: Center(
                          child: Text(
                        'Add Customer',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ))),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
