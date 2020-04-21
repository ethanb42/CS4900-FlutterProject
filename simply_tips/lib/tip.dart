import 'package:flutter/material.dart';


//A tip object that holds information
class tip extends StatelessWidget {
  //Has a value that represents money
  double value;
  //A boolean to determine cash or card transaction
  bool isCash;
  //An icon associated with the tip type
  Icon i;


  tip(double val, bool isCash) {
    value = val;
    this.isCash = isCash;
    if (isCash) {
      i = Icon(Icons.monetization_on,color: Colors.black,size: 35,);
    }
    else {
      i = Icon(Icons.credit_card,color: Colors.black,size: 35);
    }
  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return null;
  }
}
