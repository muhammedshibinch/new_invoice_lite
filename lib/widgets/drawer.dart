import 'package:flutter/material.dart';
import '../screens/productScreen.dart';
import '../screens/customerScreen.dart';
class CustomDrawer extends StatelessWidget {
  Widget _container(String title,Function onPress){
   return InkWell(
          onTap: onPress,
                  child: Container(
           height:45,
           child:
           Center(child: Text(title,
           style: TextStyle(
             fontSize:20,
             fontWeight: FontWeight.bold,
             ),
           ),),
          ),
        );
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          backgroundColor: Colors.black,
          leading:Container(),
        ),
        _container('Product',(){
          Navigator.of(context).pushNamed(ProductScreen.routeName);
          
        }),
        _container('Customer',(){
          Navigator.of(context).pushNamed(CustomerScreen.routeName);
        }),
      ],
    );
  }
}