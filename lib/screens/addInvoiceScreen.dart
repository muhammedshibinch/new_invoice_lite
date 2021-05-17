import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:invoice_lite_flutterv1/models/invoice.dart';
import 'package:invoice_lite_flutterv1/models/customer.dart';
import 'package:invoice_lite_flutterv1/models/item.dart';
import 'package:invoice_lite_flutterv1/screens/invoicescreen.dart';
import 'package:invoice_lite_flutterv1/widgets/tablePart.dart';
import 'package:provider/provider.dart';
import 'package:invoice_lite_flutterv1/database/dataBase.dart';

class InvoiceEntry extends StatefulWidget {
  static const routeName = '/invoiceentry';

  @override
  _InvoiceEntryState createState() => _InvoiceEntryState();
}

class _InvoiceEntryState extends State<InvoiceEntry> {
  final List<ItemData> tableitem = [];
  final formKey = GlobalKey<FormState>();
  int invoiceNum;
  String _nameController;
  String custAddress;
  Customer customers;
  String _dateSelected;
  double totalAmount = 0.0;
  void dateSelector() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((value) {
      setState(() {
        _dateSelected = DateFormat.yMd().format(value);
      });
    });
  }

  double _totalAmount = 0.0;
  void _total(double amount) {
    setState(() {
      _totalAmount = _totalAmount + amount;
    });
  }

  @override
  Widget build(BuildContext context) {
    final totalController = TextEditingController(text: '$_totalAmount');
    final customer = Provider.of<Data>(context).customers;
    final custName = customer.map((e) => e.custname).toList();
    if (_nameController == null) {
      custAddress = '';
    } else {
      final index =
          customer.indexWhere((element) => element.custname == _nameController);
      custAddress = customer[index].custaddress;
      customers = customer[index];
    }

    final dateController = TextEditingController(
        text: '${_dateSelected == null ? '' : _dateSelected}');
    final addressController = TextEditingController(
        text: '${custAddress.isEmpty ? '' : custAddress}');
    final labelStyle =
        TextStyle(fontSize: 16, color: Theme.of(context).primaryColor);

    return Scaffold(
      appBar: AppBar(
        title: Text('Invoice Entry'),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_sharp),
            onPressed: () {
              Navigator.of(context)
                  .pushReplacementNamed(InvoiceScreen.routeName);
            }),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height * .8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
//Container which wrap the Row which contain both Invoice Number Section and Date Section.
                    Container(
                      padding: EdgeInsets.only(bottom: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
//Invoive Number Section
                          InvoiceNumberSection(
                            labelStyle: labelStyle,
                            onChanged: (value) {
                              setState(() {
                                invoiceNum = int.parse(value);
                              });
                            },
                          ),
//Date Selection
                          DateSelectionSection(
                            dateSelected: _dateSelected,
                            dateController: dateController,
                            labelStyle: labelStyle,
                            onTap: dateSelector,
                          ),
                        ],
                      ),
                    ),
//Container which wrap the row contain both Customer Name section and Customer Address section.
                    Container(
                      padding: EdgeInsets.only(bottom: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
//Customer Name Section
                          CustomerNameSection(
                            nameController: _nameController,
                            custName: custName,
                            onChanged: (value) {
                              setState(() {
                                _nameController = value;
                              });
                            },
                          ),
//Customer Address
                          CustomerAddressSection(
                            addressController: addressController,
                            labelStyle: labelStyle,
                          ),
                        ],
                      ),
                    ),
//Table Section
                    TableSection(_total, tableitem),

                    SizedBox(width: 20),
//Total Amount Section
                    TotalAmountSection(
                        totalController: totalController,
                        labelStyle: labelStyle),
//Save Button Section
                    SaveButtonSection(
                      tableitem: tableitem,
                      formKey: formKey,
                      invoiceNum: invoiceNum,
                      dateSelected: _dateSelected,
                      customers: customers,
                      totalController: totalController,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

InputBorder _outlinedInputBorder(double width, Color color) =>
    OutlineInputBorder(
      borderSide: BorderSide(width: width, color: color),
      borderRadius: BorderRadius.circular(15),
    );
InputDecoration _decoration(String text, BuildContext context) {
  return InputDecoration(
      labelText: text,
      helperText: ' ',
      labelStyle: TextStyle(
          fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
      focusedBorder: _outlinedInputBorder(3, Colors.black),
      enabledBorder: _outlinedInputBorder(1, Colors.grey),
      errorBorder: _outlinedInputBorder(3, Colors.red),
      focusedErrorBorder: _outlinedInputBorder(3, Colors.red),
      disabledBorder: _outlinedInputBorder(1, Colors.grey),
      );
}

class InvoiceNumberSection extends StatelessWidget {
  const InvoiceNumberSection({
    Key key,
    @required this.labelStyle,
    @required this.onChanged,
  }) : super(key: key);

  final TextStyle labelStyle;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .4,
      height: 65,
      child: TextFormField(
       autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value.isEmpty) {
            return 'Enter a Invoice Number';
          }
          return null;
        },
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        decoration: _decoration('Invoice Number', context),
        keyboardType: TextInputType.number,
        onChanged: onChanged,
      ),
    );
  }
}

class DateSelectionSection extends StatelessWidget {
  const DateSelectionSection({
    Key key,
    @required String dateSelected,
    @required this.dateController,
    @required this.labelStyle,
    @required this.onTap,
  })  : _dateSelected = dateSelected,
        super(key: key);

  final String _dateSelected;
  final TextEditingController dateController;
  final TextStyle labelStyle;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .4,
      height: 65,
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value.isEmpty) {
            return 'Select a date';
          }
          return null;
        },
        onTap: onTap,
        enabled: _dateSelected == null ? true : false,
        controller: dateController,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
        decoration: _decoration('Date', context),
      ),
    );
  }
}

class CustomerNameSection extends StatelessWidget {
  const CustomerNameSection({
    Key key,
    @required String nameController,
    @required this.custName,
    @required this.onChanged,
  })  : _nameController = nameController,
        super(key: key);

  final String _nameController;
  final List<String> custName;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return  Container(
        width: MediaQuery.of(context).size.width * .4,
        height: 75,
        child:
            DropdownButtonFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          isDense: true,
          isExpanded: true,
          items: custName
                .map(
                  (label) => DropdownMenuItem(
                                      child: Text(
                        label.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13),
                      ),
                    
                    value: label,
                  ),
                )
                .toList(),
          validator: (value) => value == null ? 'Please select a customer' : null,
          decoration: _decoration('Customer Name', context),
          value: _nameController,
          onChanged: onChanged,
        ),
    );
  }
}

class CustomerAddressSection extends StatelessWidget {
  const CustomerAddressSection({
    Key key,
    @required this.addressController,
    @required this.labelStyle,
  }) : super(key: key);

  final TextEditingController addressController;
  final TextStyle labelStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .4,
      child: Center(
        child: TextFormField(
          autovalidateMode: AutovalidateMode.always,
          enabled: false,
          maxLines: 2,
          controller: addressController,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
          decoration: _decoration('Address', context),
        ),
      ),
    );
  }
}

class TotalAmountSection extends StatelessWidget {
  const TotalAmountSection({
    Key key,
    @required this.totalController,
    @required this.labelStyle,
  }) : super(key: key);

  final TextEditingController totalController;
  final TextStyle labelStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: 200,
            height: 40,
            child: TextFormField(
              onSaved: (_) {},
              controller: totalController,
              enabled: false,
              style: TextStyle(fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                labelText: 'TotalAmount',
                labelStyle: labelStyle,
                contentPadding: EdgeInsets.all(10),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: Colors.grey),
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
            ),
          ),
          SizedBox(width: 20)
        ],
      ),
    );
  }
}

class SaveButtonSection extends StatelessWidget {
  const SaveButtonSection({
    Key key,
    @required this.tableitem,
    @required this.formKey,
    @required this.invoiceNum,
    @required String dateSelected,
    @required this.customers,
    @required this.totalController,
  })  : _dateSelected = dateSelected,
        super(key: key);

  final List<ItemData> tableitem;
  final GlobalKey<FormState> formKey;
  final int invoiceNum;
  final String _dateSelected;
  final Customer customers;
  final TextEditingController totalController;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton.icon(
          onPressed: () {
            final isValid = formKey.currentState.validate();
            if (!isValid) {
              return null;
            } else {
              formKey.currentState.save();
              Provider.of<InvoiceItem>(context, listen: false).addInvoice(
                  invoiceNum,
                  _dateSelected,
                  customers,
                  double.parse(totalController.text),
                  tableitem.toList());
            }

            Navigator.of(context).pushReplacementNamed(InvoiceScreen.routeName);
          },
          icon: Icon(Icons.save),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 70),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          label: Text('SAVE')),
    );
  }
}
