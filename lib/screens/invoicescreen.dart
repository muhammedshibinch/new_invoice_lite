import 'package:flutter/material.dart';
import 'package:invoice_lite_flutterv1/widgets/customerdetails.dart';
import 'package:invoice_lite_flutterv1/widgets/tablesectionwidget.dart';

class InvoiceScreen extends StatefulWidget {
  @override
  _InvoiceScreenState createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  DateTime date;
  String invoicenum;
  String customerName;
  // String itemName;
 
  // String price;
  // String amount;
  //String customerAddress;
  
DateTime selectedDate(datesel){
    date=datesel;
}
String _invoice(invno){
  invoicenum = invno;
}
String _custname(custname){
  customerName=custname;
}
// String _itemname(itmname){
//    itemName=itmname;
// }

// String priceitem(value){
//   price=value;
// }
// String _amount(value){
//   amount=value;
// }

  final formkey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Invoice'),
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
                CustomerEntry(selectedDate,_invoice,_custname),
                TableSection(),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: ElevatedButton.icon(
                    
                      onPressed: () {
                         final isValid =formkey.currentState.validate();
                         if(isValid){
                         formkey.currentState.save();
                         final message = '$date\n$invoicenum\n$customerName';
                         print(message);
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
