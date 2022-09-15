import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import '../widgets/adaptivebutton.dart';
import 'package:intl/intl.dart';

class New_Transaction extends StatefulWidget {
  final Function addTx;

  New_Transaction(this.addTx) {
    print('constructor new transaction');
  }

  @override
  _New_TransactionState createState() {
    print('createstate new transaction');
    return _New_TransactionState();
  }
}

class _New_TransactionState extends State<New_Transaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;
  _New_TransactionState() {
    print('new constructor');
  }
  @override
  void initState() {
    print('init state()');
    super.initState();
  }

  @override
  void didUpdateWidget(covariant New_Transaction oldWidget) {
    print('didUpdateWidget()');
    super.didUpdateWidget(oldWidget);
  }
  @override
  void dispose() {
    print('dispose()');
    super.dispose();
  }

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }
    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
    print('...');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
          elevation: 5,
          child: Container(
              padding: EdgeInsets.only(
                  top: 10,
                  left: 10,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 10,
                  right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(labelText: 'title'),
                    controller: _titleController,
                    onSubmitted: (_) => _submitData(),
                    //onChanged: (val) {
                    // titleInput = val;
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Amount'),
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    onSubmitted: (_) => _submitData(),
                    // onChanged: (val) {
                    //  amountInput = val;
                  ),
                  Container(
                    height: 70,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(_selectedDate == null
                              ? 'no date choosen'
                              : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}'),
                        ),
                        Adaptivflatebutton('choose Date', _presentDatePicker)
                      ],
                    ),
                  ),
                  RaisedButton(
                    child: Text('add transaction'),
                    color: Theme.of(context).primaryColor,
                    textColor: Theme.of(context).textTheme.button.color,
                    onPressed: _submitData,
                  ),
                ],
              ))),
    );
  }
}
