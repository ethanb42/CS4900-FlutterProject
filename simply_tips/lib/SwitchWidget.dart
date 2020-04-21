import 'package:flutter/material.dart';
import "main.dart";


int count =0;

//The switch for the cash option
class SwitchWidget extends StatefulWidget {
  @override
  SwitchWidgetClass createState() => new SwitchWidgetClass();

}

class SwitchWidgetClass extends State {


  bool switchControl = false;
  var textHolder = 'Switch is OFF';



  void toggleSwitch(bool value) {
    if (switchControl == false) {
      setState(() {
        switchControl = true;
        if (first) {
          cashOne = true;
        } else {
          cashTwo = true;
        }

        textHolder = 'Switch is ON';
      });
      print('Switch is ON');
      // Put your code here which you want to execute on Switch ON event.

    } else {
      setState(() {
        if (first) {
          cashOne = false;
        } else {
          cashTwo = false;
        }
        switchControl = false;
        textHolder = 'Switch is OFF';
      });
      print('Switch is OFF');
      // Put your code here which you want to execute on Switch OFF event.
    }
  }

 void resetSwitch(){
    switchControl = false;
    count++;
    if(count==2){
      switchOverride=false;
      count = 0;
    }


  }

  @override
  Widget build(BuildContext context) {
    print(switchOverride);
    if(switchOverride == true){
      resetSwitch();
      cashOne = false;
      cashTwo = false;
    }

    return Switch(
      onChanged: toggleSwitch,
      value: switchControl,
      activeColor: Colors.white,
      activeTrackColor: Colors.green,
      inactiveThumbColor: Colors.white,
      inactiveTrackColor: Colors.white,

    );
  }
}
