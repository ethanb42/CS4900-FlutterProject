import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'TextFiledFormatters.dart';
import 'main.dart';

//Handles the start shift dialog box
Future<String> createAlertDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Enter Starting Milage"),
          content: TextField(
            autofocus: true,
            inputFormatters: [
              WhitelistingTextInputFormatter.digitsOnly,
              RegExInputFormatter.withRegex(
                  '^\$|^(0|([1-9][0-9]{0,}))(\\.[0-9]{0,})?\$'),
            ],
            keyboardType: TextInputType.number,
            controller: controller,
          ),
          actions: <Widget>[
            MaterialButton(
              elevation: 5.0,
              child: Text("Submit"),
              onPressed: () {
                Navigator.of(context).pop(controller.text.toString());
                controller.clear();

              },
            )
          ],
        );
      });
}

//Handles the end shift dialog box
Future<String> createAlertDialogTwo(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Enter Ending Milage"),
          content: TextField(
            inputFormatters: [
              WhitelistingTextInputFormatter.digitsOnly,
              RegExInputFormatter.withRegex(
                  '^\$|^(0|([1-9][0-9]{0,}))(\\.[0-9]{0,})?\$'),
            ],
            keyboardType: TextInputType.number,
            controller: controller,
          ),
          actions: <Widget>[
            MaterialButton(
              elevation: 5.0,
              child: Text("Submit"),
              onPressed: () {
                Navigator.of(context).pop(controller.text.toString());
                controller.clear();
              },
            )
          ],
        );
      });
}

//Handles the end shift dialog box
Future<String> createAlertDialogMiles(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Enter Reimbursement Rate per Mile\n",textScaleFactor: 1.2,),
          content: TextField(
            style: TextStyle(fontSize: 24),
            inputFormatters: [
              DecimalTextInputFormatter(decimalRange: 2),
              RegExInputFormatter.withRegex(
                  '^\$|^(0|([1-9][0-9]{0,}))(\\.[0-9]{0,})?\$'),
            ],
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            controller: controller,
          ),
          actions: <Widget>[
            MaterialButton(
              elevation: 5.0,
              child: Text("Submit",textScaleFactor: 1.3,),

              onPressed: () {
                Navigator.of(context).pop(controller.text.toString());
                controller.clear();
              },
            )
          ],
        );
      });
}

Future<void> neverSatisfied(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {


      return AlertDialog(
        title: Text('Milage Rate set!'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(milePay.toStringAsFixed(2) + '/mi'),

            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}