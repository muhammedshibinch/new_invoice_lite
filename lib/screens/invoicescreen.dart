import 'package:flutter/material.dart';
import 'package:invoice_lite_flutterv1/models/customer.dart';
import 'package:invoice_lite_flutterv1/models/invoice.dart';
import 'package:invoice_lite_flutterv1/widgets/customerdetails.dart';
import 'package:invoice_lite_flutterv1/widgets/drawer.dart';
import 'package:invoice_lite_flutterv1/widgets/tablesectionwidget.dart';
import 'package:provider/provider.dart';
import '../models/item.dart';

class InvoiceScreen extends StatefulWidget {
  static const routeName='/invoice';
  @override
  _InvoiceScreenState createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  DateTime date;
  int invoicenum;
  String customerName;
  Customer cust;
  double total;
  final invController = TextEditingController();
  DateTime selectedDate(datesel) {
    return date = datesel;
  }

  int _invoice(invno) {
    return invoicenum = invno;
  }

  String _custname(custname) {
    return customerName = custname;
  }
  void _custmersDetails(customerdetail){
    cust = customerdetail;
  }
  double totalamt(amount){
      return total=amount;
  }
 
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    List<ItemData> itemslist=Provider.of<Item>(context).items;
    final invoice = Provider.of<InvoiceItem>(context).invoice;
    
    //final inolist = Provider.of<InvoiceItem>(context, listen: false);
    return Scaffold(
      drawer: Drawer(
        child: CustomDrawer(),
      ),
      appBar: AppBar(
        title: Text('Invoice')
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * .8,
          margin: EdgeInsets.all(10),
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomerEntry(selectedDate, _invoice, _custname,_custmersDetails),
                TableSection(totalamt),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: ElevatedButton.icon(
                      onPressed: () {
                        final isValid = formkey.currentState.validate();
                        if (isValid) {
                          formkey.currentState.save();
                        //  final message = '$date\n$invoicenum\n$customerName';
                        //  print(message);
                         print(invoice.map((e) => e.invdate).toList());
                         print(invoice.map((e) => e.customer).toList());
                         print(invoice.length);
                         print(invoice.map((e) => e.invno).toList());
                         print(invoice.map((e) => e.itemlist).toList());
                         print(invoice.map((e) => e.totalamount).toList());
                          Provider.of<InvoiceItem>(context, listen: false).addInvoice(
                            invoicenum,
                            date,
                            cust,
                            total,
                            itemslist
                          );
                        }
                         
                      },
                      icon: Icon(Icons.save),
                      label: Text('SAVE')),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
