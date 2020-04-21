import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import "main.dart";

//The results breakdown page
class ResultPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new ResultPageState();
  }
}

class ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: Implement build
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            //We are going back to let editing happen
            endingMileage = 0;
            start = false;
            Navigator.pop(context);
          },
        ),
        title: Text("Shift Result"),
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          Text(
            "Breakdown",
            style: TextStyle(fontSize: 25),
          ),
          PieChart(
            legendStyle: TextStyle(fontSize: 17),
            chartValueStyle: TextStyle(fontSize: 20, color: Colors.black),
            dataMap: dataMap,
            showChartValuesInPercentage: false,
            decimalPlaces: 2,
          ),
          Container(
            color: Colors.grey,
            padding: EdgeInsets.all(2),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      "Grand Total: \$",
                      textScaleFactor: 2.2,
                    ),
                    Text(
                      (total + milePayment).toStringAsFixed(2),
                      textScaleFactor: 2.0,
                    ),
                  ],
                ),
                Row(children: <Widget>[
                  Text("Total Tips: \$" + total.toStringAsFixed(2),textScaleFactor: 1.5,)
                ],),
                Row(
                  children: <Widget>[
                    Text(
                      "Cash Tips: \$",
                      textScaleFactor: 1.5,
                    ),
                    Text(
                      (notCard).toStringAsFixed(2),
                      textScaleFactor: 1.5,
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text(
                      "Card Tips: \$",
                      textScaleFactor: 1.5,
                    ),
                    Text(
                      (card).toStringAsFixed(2),
                      textScaleFactor: 1.5,
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text(
                      "Mile Pay: \$",
                      textScaleFactor: 1.5,
                    ),
                    Text(
                      (milePayment).toStringAsFixed(2),
                      textScaleFactor: 1.5,
                    ),
                    Text(
                      " (",
                      textScaleFactor: 1.3,
                    ),
                    Text(
                      (endingMileage - startMileage).toString(),
                      textScaleFactor: 1.3,
                    ),
                    Text(
                      " mi @ \$",
                      textScaleFactor: 1.3,
                    ),
                    Text(
                      milePay.toString(),
                      textScaleFactor: 1.3,
                    ),
                    Text(
                      "/mi)",
                      textScaleFactor: 1.3,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Text(""),
          ),
          ButtonTheme(
            minWidth: MediaQuery.of(context).size.width,
            child: RaisedButton(
              onPressed: () {
                resetAll();

                Navigator.pop(context);
              },
              child: Text(
                'Restart!',
                textScaleFactor: 1.5,
              ),
            ),
          ),
        ],
      )),
    );
  }
}
