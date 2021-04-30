import 'package:flutter/material.dart';
import 'package:invoice_lite_flutterv1/database/dataBase.dart';
import 'package:invoice_lite_flutterv1/screens/addCustomerScreen.dart';
import 'package:provider/provider.dart';

class CustomerScreen extends StatelessWidget {
  static const routeName = '/customer';
  @override
  Widget build(BuildContext context) {
    final customerList =
        Provider.of<Data>(context).customers.map((e) => e).toList();
    final style = TextStyle(fontSize: 15, fontWeight: FontWeight.bold);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Our Customers',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.person_add),
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(AddCustomerScreen.routeName);
              }),
        ],
      ),
      body: ListView.builder(
        itemCount: customerList.length,
        itemBuilder: (ctx, index) => Card(
          elevation: 10,
          margin: EdgeInsets.symmetric(vertical: 6, horizontal: 15),
          child: Container(
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Center(
                      child: Text(
                        customerList[index].custname,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.delete_outlined,
                        color: Theme.of(context).errorColor,
                      ),
                      onPressed: () {
                        Provider.of<Data>(context, listen: false)
                            .romoveCustomer(customerList[index].custid);
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Customer ID         : ${customerList[index].custid}',
                  style: style,
                ),
                Text(
                  'Address                 : ${customerList[index].custaddress}',
                  style: style,
                ),
                Text(
                  'Opening Balance : ${customerList[index].openingbal.toStringAsFixed(2)}',
                  style: style,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
