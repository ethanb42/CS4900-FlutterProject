//Predefined imports
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//Package Imports
import 'TextFiledFormatters.dart';
import 'tip.dart';
import "ResultPage.dart";
import 'AlertDialogs.dart';
import 'SwitchWidget.dart';

//Runs the app
void main() => runApp(MyApp());

//Variables
var one = new SwitchWidget();
var two = new SwitchWidget();

// The total value of tips
double total = 0;
//Used to total card/cash tips
double notCard = 0;
double card = 0;
//The number of deliveries
int count = 0;
//The Starting Odometer
int startMileage = 0;
//The Ending Odometer
int endingMileage = 0;

//Switch overrides
bool switchOverride = false;

//Used to determine a cash vs card tip for each entry method
bool cashOne = false;
bool cashTwo = false;

//Used to swap between tip-entry method
bool first = true;

//Used to swap between start and end shift
bool start = true;

//Keeps track of each tip
List<tip> myList = List<tip>();

//the mileage rate per mile (default is 0.38)
double milePay = 0.38;
//the amount paid out
double milePayment = 0;

//Used to tell if we are done
bool finished = false;

//A map to hold results to display
Map<String, double> dataMap = new Map();

//Text controllers for text fields
//Assigned to the dialog popups
TextEditingController controller = new TextEditingController();
//Used for the single tip entry text field
TextEditingController textControl = new TextEditingController();
//Used for the received text field
TextEditingController textControlR = new TextEditingController();
//Used for the order total text field
TextEditingController textControlT = new TextEditingController();

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
     debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,

      ),
      home: MyHomePage(title: 'Delivery Assistant'),
    );
  }
}


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text("Simply Tips Tracker"),
        leading: IconButton(
          icon: Icon(Icons.swap_horiz),
          onPressed: () {
            if (first) {
              first = false;
            } else {
              first = true;
            }
            setState(() {});
          },
        ),
        actions: <Widget>[
          PopupMenuButton(
            icon: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onSelected: (String result) {
              if (result == "1") {
                createAlertDialogMiles(context).then((onValue) {
                  milePay = double.parse(onValue);
                  //round it
                  milePay = num.parse(milePay.toStringAsFixed(2));
                  neverSatisfied(context).then((onValue) {});
                  print("Mile Pay changed to " + milePay.toString());
                });
              } else if (result == "2") {

                  resetAll();


                setState(() {});
              }

            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem(value: "1", child: Text("Set Remburment Rate")),
              PopupMenuItem(value: "2", child: Text("Restart App")),
            ],
          ),
        ],
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: 80,
            color: Colors.grey.withOpacity(0.4),
            child: Row(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      color: Colors.grey.withOpacity(0.4),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Total:  ",
                            textScaleFactor: 1.4,
                          ),
                          Icon(
                            Icons.attach_money,
                          ),
                          Container(
                            child: Text(
                              total.toStringAsFixed(2),
                              textScaleFactor: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      color: Colors.grey.withOpacity(0.4),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Credit: ",
                            textScaleFactor: 1.4,
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          Icon(
                            Icons.attach_money,
                          ),
                          Container(
                            child: Text(
                              card.toStringAsFixed(2),
                              textScaleFactor: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      color: Colors.grey.withOpacity(0.4),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Cash : ",
                            textScaleFactor: 1.5,
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          Icon(
                            Icons.attach_money,
                          ),
                          Container(
                            child: Text(
                              notCard.toStringAsFixed(2),
                              textScaleFactor: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(width: 0, color: Colors.black,),
                Column(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      color: Colors.grey.withOpacity(0.4),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Initial Odometer",
                            textScaleFactor: 1.5,
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                          ),

                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      color: Colors.grey.withOpacity(0.4),
                    child: Text(
                      startMileage.toString() + " miles",
                      textScaleFactor: 1.5,

                    ),),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      color: Colors.grey.withOpacity(0.4),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Delivery #  : ",
                            textScaleFactor: 1.4,
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          Container(
                            child: Text(
                              "$count",
                              textScaleFactor: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            children: <Widget>[
              AnimatedCrossFade(
                duration: const Duration(seconds: 0),
                firstChild: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 75,
                  color: Colors.grey.withOpacity(1),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 0.07,
                        child: Icon(
                          Icons.attach_money,
                          size: 35,
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width * 0.42,
                        height: 10,
                        color: Colors.white.withOpacity(0.95),
                        margin: EdgeInsets.all(6),
                        child: TextField(
                          inputFormatters: [
                            DecimalTextInputFormatter(decimalRange: 2),
                            RegExInputFormatter.withRegex(
                                '^\$|^(0|([1-9][0-9]{0,}))(\\.[0-9]{0,})?\$'),
                            LengthLimitingTextInputFormatter(10),
                          ],
                          controller: textControl,
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                          style: TextStyle(
                            fontSize: 26,
                          ),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(1, 0, 0, 0),
                            border: OutlineInputBorder(),
                            hintText: '0.00',
                          ),
                        ),
                      ),
                      Container(
                        width: (MediaQuery.of(context).size.width * 0.16),
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: 6,
                            ),
                            Text(
                              "Cash",
                              textScaleFactor: 1.3,
                            ),
                            one,
                          ],
                        ),
                      ),
                      Container(
                        width: 5,
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          color: Colors.blueGrey.withOpacity(0.9),
                          child: FlatButton(
                            onPressed: () {
                              FocusScope.of(context).requestFocus(FocusNode());
                              double tipTotal = double.parse(textControl.text);
                              total +=
                                  double.parse((tipTotal).toStringAsFixed(2));
                              if (cashOne == true) {
                                notCard +=
                                    double.parse((tipTotal).toStringAsFixed(2));
                              } else {
                                card +=
                                    double.parse((tipTotal).toStringAsFixed(2));
                              }

                              setState(() {
                                //Add a new tip to the list
                                myList.add(new tip(tipTotal, cashOne));
                                count++;
                                textControl.clear();

                                print("Tip added!");
                              });
                            },
                            child: Text(
                              "ADD TIP",
                              textScaleFactor: 1.5,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                secondChild: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      height: 90,
                      color:Colors.grey.withOpacity(1),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Icon(
                                Icons.attach_money,
                                size: 35,
                              ),
                              Container(
                                height: 8,
                              ),
                              Icon(
                                Icons.attach_money,
                                size: 35,
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.42,
                                height: 40,
                                color: Colors.white.withOpacity(0.95),
                                margin: EdgeInsets.all(2),
                                child: TextField(
                                  inputFormatters: [
                                    DecimalTextInputFormatter(decimalRange: 2),
                                    RegExInputFormatter.withRegex(
                                        '^\$|^(0|([1-9][0-9]{0,}))(\\.[0-9]{0,})?\$'),
                                    LengthLimitingTextInputFormatter(10),
                                  ],
                                  controller: textControlR,
                                  textAlignVertical: TextAlignVertical.bottom,
                                  keyboardType: TextInputType.numberWithOptions(
                                      decimal: true),
                                  style: TextStyle(
                                    fontSize: 22,
                                  ),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(0),
                                    labelText: ' Total Collected',
                                    labelStyle: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                    hintText: '0.00',
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.42,
                                height: 40,
                                color: Colors.white.withOpacity(0.95),
                                margin: EdgeInsets.all(2),
                                child: TextField(
                                  inputFormatters: [
                                    DecimalTextInputFormatter(decimalRange: 2),
                                    RegExInputFormatter.withRegex(
                                        '^\$|^(0|([1-9][0-9]{0,}))(\\.[0-9]{0,})?\$'),
                                    LengthLimitingTextInputFormatter(10),
                                  ],
                                  controller: textControlT,
                                  textAlignVertical: TextAlignVertical.bottom,
                                  keyboardType: TextInputType.numberWithOptions(
                                      decimal: true),
                                  style: TextStyle(
                                    fontSize: 22,
                                  ),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(0),
                                    labelText: ' Order Total',
                                    labelStyle: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                    hintText: '0.00',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: (MediaQuery.of(context).size.width * 0.16),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  height: 12,
                                ),
                                Text(
                                  "Cash",
                                  textScaleFactor: 1.3,
                                ),
                                two,
                              ],
                            ),
                          ),
                          Container(
                            width: 9,
                          ),
                          Expanded(
                            child: Container(
                              color: Colors.blueGrey.withOpacity(0.9),
                              child: FlatButton(
                                onPressed: () {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  double tipTotal =
                                      double.parse(textControlR.text) -
                                          double.parse(textControlT.text);
                                  total += double.parse(
                                      (tipTotal).toStringAsFixed(2));
                                  if (cashTwo == true) {
                                    notCard += double.parse(
                                        (tipTotal).toStringAsFixed(2));
                                  } else {
                                    card += double.parse(
                                        (tipTotal).toStringAsFixed(2));
                                  }

                                  setState(() {
                                    //Add a new tip to the list
                                    myList.add(new tip(tipTotal, cashTwo));
                                    count++;
                                    print("Tip added!");
                                    //Lose focus of keyboard

                                    //Clear the input
                                    textControl.clear();
                                    textControlT.clear();
                                    textControlR.clear();
                                  });
                                },
                                child: Text(
                                  "ADD TIP",
                                  textScaleFactor: 1.5,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                crossFadeState: first
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
              ),
            ],
          ),
          //  Container(height: 300, child: HomePageBody()),

          Container(
            height: 5,
            child: Text(""),
          ),

          Expanded(
            child: ListView(
                children: myList
                    .map((element) => Dismissible(
                        key: UniqueKey(),
                        child: Card(
                            color: Colors.grey.withOpacity(0.7),
                            child: Column(
                              children: <Widget>[
                                ListTile(
                                  title: Row(
                                    children: <Widget>[
                                      element.i,
                                      Text(
                                        " " +
                                            element.value.toStringAsFixed(2) +
                                            " tip",
                                        style: TextStyle(fontSize: 24),
                                      ),
                                    ],
                                  ),
                                  leading: Text(
                                    (myList.indexOf(element) + 1).toString() +
                                        ')',
                                    textScaleFactor: 2,
                                  ),
                                ),
                              ],
                            )),
                        onDismissed: (DismissDirection direction) {
                          //We need to delete the element from the list

                          total = total - element.value;
                          if (element.isCash) {
                            notCard = notCard - element.value;
                          } else {
                            card = card - element.value;
                          }
                          count--;
                          setState(() {
                            myList.remove(element);
                          });
                        }))
                    .toList()),
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
          child: AnimatedCrossFade(
        alignment: Alignment.center,
        duration: const Duration(seconds: 1),
        firstChild: Container(
          height: 48,
          width: MediaQuery.of(context).size.width,
          child: FlatButton(
            color: Colors.blueGrey.withOpacity(0.60),
            onPressed: () {
              createAlertDialog(context).then((onValue) {
                startMileage = int.parse(onValue);

                start = false;
              });

              setState(() {});
            },
            child: Text(
              "Start Shift",
              textScaleFactor: 2,
            ),
          ),
        ),
        secondChild: Container(
          height: 48,
          width: MediaQuery.of(context).size.width,
          child: FlatButton(
            color: Colors.blueGrey,
            onPressed: () {
              createAlertDialogTwo(context).then((onValue) {
                endingMileage = int.parse(onValue);
                milePayment = (endingMileage - startMileage) * milePay;
                print("Mile Pay: " + milePayment.toString());
                dataMap.putIfAbsent("Cash", () => notCard);
                dataMap.putIfAbsent("Credit", () => card);
                dataMap.putIfAbsent("Mileage", () => milePayment);
                dataMap.putIfAbsent("Bonus", () => 0);

                print("Complete");
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ResultPage()),
                );
                start = true;
              });
            },
            child: Text(
              "End Shift",
              textScaleFactor: 2,
            ),
          ),
        ),
        crossFadeState:
            start ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      )),
    );
  }
}

//Resets all data
void resetAll() {
  print("Resting all....");
  dataMap.clear();
  total = 0;
  count = 0;
  startMileage = 0;
  endingMileage = 0;
  milePayment = 0;

  first = true;
  start = true;

  notCard = 0;
  card = 0;

  myList.clear();
  finished = false;

  controller.clear();
  textControl.clear();
  textControlR.clear();
  textControlT.clear();

  switchOverride = true;
  one = new SwitchWidget();
  two = new SwitchWidget();
}


