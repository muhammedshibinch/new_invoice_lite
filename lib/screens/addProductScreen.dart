import 'package:flutter/material.dart';
import 'package:invoice_lite_flutterv1/database/dataBase.dart';
import 'package:invoice_lite_flutterv1/screens/productScreen.dart';
import 'package:invoice_lite_flutterv1/widgets/saveButton.dart';
import 'package:provider/provider.dart';
import '../widgets/formfield.dart';

class AddProductScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  static const routeName = '/addproduct';
  @override
  Widget build(BuildContext context) {
    final idList =
        Provider.of<Data>(context).products.map((e) => e.itemid).toList();
    int id;
    String name;
    double price;
    int qty;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white10,
        title: Text(
          'Product Entry',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 23),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(ProductScreen.routeName);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Text(
                'Add your product details here',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              FormFieldArea(
                'Enter Product Id',
                'Product Id',
                TextInputType.number,
                1,
                (value) {
                  if (value.isEmpty) {
                    return 'Enter an Id';
                  } else if (idList.contains(int.parse(value))) {
                    return 'This Id is already existed';
                  }
                },
                (data) {
                  id = int.parse(data);
                },
              ),
              FormFieldArea(
                'Enter Product Name',
                'Product Name',
                TextInputType.text,
                1,
                (value) {
                  if (value.isEmpty) {
                    return 'Enter  name';
                  }
                },
                (data) {
                  name = data;
                },
              ),
              FormFieldArea(
                'Enter Product Price',
                'Product Price',
                TextInputType.number,
                1,
                (value) {
                  if (value.isEmpty) {
                    return 'Enter  price';
                  }
                },
                (data) {
                  price = double.parse(data);
                },
              ),
              FormFieldArea(
                'Enter Product Quantity',
                'Product Quantity',
                TextInputType.number,
                1,
                (value) {
                  if (value.isEmpty) {
                    return 'Enter product quantity';
                  }
                },
                (data) {
                  qty = int.parse(data);
                },
              ),
              SizedBox(height: 20),
              SaveButton(
                () {
                  final valid = formKey.currentState.validate();
                  formKey.currentState.save();
                  if (valid) {
                    Provider.of<Data>(context, listen: false).addProduct(
                      id,
                      name,
                      price,
                      qty,
                    );
                    Navigator.of(context)
                        .pushReplacementNamed(ProductScreen.routeName);
                  }
                },
                'Add Product',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
