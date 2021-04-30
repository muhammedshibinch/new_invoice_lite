import 'package:flutter/material.dart';

class SaveButton extends StatelessWidget {
  final Function press;
  final String title;
  SaveButton(this.press, this.title);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
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
            title,
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
