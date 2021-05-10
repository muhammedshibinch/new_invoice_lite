import 'package:flutter/material.dart';
import 'package:invoice_lite_flutterv1/database/dataBase.dart';
import 'package:invoice_lite_flutterv1/screens/addProductScreen.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  static const routeName = '/product';
  @override
  Widget build(BuildContext context) {
    final itemList = Provider.of<Data>(context).products.map((e) => e).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Products',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(Icons.add_shopping_cart_outlined),
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(AddProductScreen.routeName);
              }),
        ],
      ),
      body: ListView.builder(
        itemCount: itemList.length,
        itemBuilder: (ctx, index) => Card(
          elevation: 12,
          margin: EdgeInsets.symmetric(vertical: 6, horizontal: 15),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: Text(
                      '\$${itemList[index].itemprice.toStringAsFixed(0)}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              title: Text(
                itemList[index].itemname,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.delete_outline_outlined,
                  color: Theme.of(context).errorColor,
                ),
                onPressed: () {
                  Provider.of<Data>(context, listen: false)
                      .removeProduct(itemList[index].itemid);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
