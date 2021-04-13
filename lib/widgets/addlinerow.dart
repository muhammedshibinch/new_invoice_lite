import 'package:flutter/material.dart';
import 'package:invoice_lite_flutterv1/database/dataBase.dart';
import 'package:provider/provider.dart';

class AddLineRow extends StatefulWidget {
  final Function totalsum;
  AddLineRow(this.totalsum);
  @override
  _AddLineRowState createState() => _AddLineRowState();
}

class _AddLineRowState extends State<AddLineRow> {
  final qtyController = TextEditingController();
  String selectedObject = 'Lenovo Laptop';
  int qtycount;

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    final item = Provider.of<Data>(context).products;
    final productname = item.map((e) => e.itemname).toList();
    final index =
        item.indexWhere((element) => element.itemname == selectedObject);
    var price = item[index].itemprice;
    return Row(
      children: [
        //item section
        //
        //
        Container(
            // padding: EdgeInsets.only(
            //   right: 5,
            // ),
            // decoration:
            //     BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
            width: media.width * .4,
            height: 25,
            child: FormField<String>(
              builder: (FormFieldState<String> state) {
                return InputDecorator(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(5.0, 4.0, 5.0, 3.0),
                    //labelStyle: textStyle,
                    // errorStyle: TextStyle(
                    //     color: Colors.redAccent, fontSize: 16.0),
                    // hintText: 'Please select expense',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 2),
                      borderRadius: BorderRadius.circular(0),
                    ),
                  ),
                  isEmpty: selectedObject == '',
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedObject,
                      isDense: true,
                      onChanged: (String newValue) {
                        setState(() {
                          selectedObject = newValue;
                          state.didChange(newValue);
                        });
                      },
                      items: productname.map((value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                );
              },
            )

            // DropdownButton(
            //     dropdownColor: Colors.white,
            //     icon: Icon(Icons.arrow_drop_down),
            //     iconSize: 20,
            //     underline: SizedBox(),
            //     style: TextStyle(color: Colors.black, fontSize: 17),
            //     value: selectedObject,
            //     onChanged: (value) {
            //       setState(() {
            //         selectedObject = value;
            //       });
            //     },
            //     items: productname.map<DropdownMenuItem<String>>((value) {
            //       return DropdownMenuItem(
            //         child: FittedBox(
            //           fit: BoxFit.cover,
            //           child: Container(
            //             width: 120,
            //             child: Text(
            //               value,
            //               style: TextStyle(
            //                   fontSize: 12, fontWeight: FontWeight.bold),
            //             ),
            //           ),
            //         ),
            //         value: value,
            //       );
            //     }).toList()),
            ),

        //qty section
        Container(
          width: media.width * .1,
          height: 25,
          child: TextFormField(
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
            ),
            keyboardType: TextInputType.number,
            controller: qtyController,
            onFieldSubmitted: (value) {
              qtycount = int.parse(value);
            },
          ),
        ),

        //price section
        Container(
          width: media.width * .2,
          height: 25,
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          child: Center(child: Text('$price')),
        ),

        //amount section
        Container(
          width: media.width * .2,
          height: 25,
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          child: Center(
              child:
                  qtycount == null ? Text('0') : Text('${price * qtycount}')),
        )
      ],
    );
  }
}
