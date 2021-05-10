import 'package:flutter/material.dart';
import 'package:invoice_lite_flutterv1/models/invoice.dart';
import 'package:invoice_lite_flutterv1/screens/addInvoiceScreen.dart';
import 'package:invoice_lite_flutterv1/widgets/drawer.dart';
import 'package:provider/provider.dart';

class InvoiceScreen extends StatelessWidget {
  static const routeName = '/invoiceScreen';
  @override
  Widget build(BuildContext context) {
    final invoiceList =
        Provider.of<InvoiceItem>(context).invoice.map((e) => e).toList();

    final style = TextStyle(fontSize: 15, fontWeight: FontWeight.bold);
    return Scaffold(
      drawer: Drawer(
        child: CustomDrawer(),
      ),
      appBar: AppBar(
        
        title: Text('Invoices'),
        centerTitle:true,
        shape: RoundedRectangleBorder(
          borderRadius:BorderRadius.vertical(bottom: Radius.circular(10))),
        actions: [
          IconButton(
              icon: Icon(Icons.note_add_outlined),
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(InvoiceEntry.routeName);
              })
        ],
      ),
      body: ListView.builder(
        itemCount: invoiceList.length,
        itemBuilder: (ctx, index) => Dismissible(
          key: ValueKey(invoiceList[index].id),
          background: Container(
            color: Theme.of(context).errorColor,
            child: Icon(
              Icons.delete_outlined,
              color: Colors.white,
              size: 40,
            ),
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 20),
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          ),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            Provider.of<InvoiceItem>(context, listen: false)
                .removeInvoice(invoiceList[index].id);
          },
          child: Card(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      "INVOICE",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.red[800]),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text('Invoice Number : '),
                          Text(
                            '${invoiceList[index].invno}',
                            style: style,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text('Date : '),
                          Text(
                            '${invoiceList[index].invdate}',
                            style: style,
                          )
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Customer Name : '),
                      Text(
                        '${invoiceList[index].customer.custname}',
                        style: style,
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text('Customer Address : '),
                      Text(
                        '${invoiceList[index].customer.custaddress}',
                        style: style,
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text('Item Purchased : '),
                      ...invoiceList[index].itemlist.map((e) => Text(
                            '${e.product.itemname}, ',
                            style: style,
                          ))
                    ],
                  ),
                  Row(
                    children: [
                      Text('Total Amount : '),
                      Text(
                        '${invoiceList[index].totalamount.toStringAsFixed(2)}',
                        style: style,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
