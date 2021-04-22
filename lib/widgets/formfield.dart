import 'package:flutter/material.dart';
class FormFieldArea extends StatelessWidget {
  final String hint;
  final String label;
  final TextInputType value;
  final int line;
  final Function val;
  final Function saved;
  FormFieldArea(this.hint,this.label,this.value,this.line,this.val,this.saved);
  @override
  Widget build(BuildContext context) {
    return Container(
             width: MediaQuery.of(context).size.width*7,
                padding: const EdgeInsets.only(right: 20, left: 20, top: 15),
                child: TextFormField(
                  validator:val,
                  onSaved: saved,
                  maxLines: line,
                  decoration: InputDecoration(
                    hintText: hint,
                    labelText: label,
                    labelStyle:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.black),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.red),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.red),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  keyboardType: value,
                ),
              );
  }
}