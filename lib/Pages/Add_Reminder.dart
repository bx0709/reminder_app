import 'dart:io';
// import 'dart:js';
// import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'conditional_builder.dart';

// List<CameraDescription> cameras;

enum repeat_list { Daily, Weekly, Monthly, Yearly }

class Add_Reminder extends StatefulWidget {
  @override
  _Add_ReminderState createState() => _Add_ReminderState();
}

class _Add_ReminderState extends State<Add_Reminder> {
  //all variables used are defined here
  String title = '';
  String notes = '';
  bool isSwitched = false;
  bool isTime = false;
  DateTime _dateTime = DateTime.now();
  DateTime time = null;
  bool email = false;
  String repeat = 'Never';
  // DateTime now = new DateTime.now();
  DateTime date = DateTime.now().subtract(Duration(days: 1));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      //AppBar
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Add Reminder',
          style: TextStyle(
            fontSize: 25,
            color: Colors.amber,
          ),
        ),
        titleSpacing: 20,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            //First Text Field to input title
            Padding(
              padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 0.0),
              child: Card(
                margin: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                color: Colors.transparent,
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  textCapitalization: TextCapitalization.sentences,
                  autofocus: true,
                  maxLines: 2,
                  minLines: 1,
                  enableInteractiveSelection: true,
                  enableSuggestions: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.add_box,
                      color: Colors.amber,
                      size: 30.0,
                    ),
                    hintText: 'Title',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                    focusColor: Colors.amber,
                  ),
                  onChanged: (String str) {
                    setState(() {
                      title = str;
                    });
                  },
                ),
              ),
            ),
            SizedBox(
              width: 300.0,
              child: Divider(
                color: Colors.amberAccent,
              ),
            ),
            //Second text field to input notes
            Padding(
              padding: const EdgeInsets.fromLTRB(12.0, 4.0, 12.0, 4.0),
              child: Card(
                margin: EdgeInsets.fromLTRB(8.0, 2.0, 8.0, 2.0),
                color: Colors.transparent,
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  textCapitalization: TextCapitalization.sentences,
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  minLines: 1,
                  autofocus: true,
                  enableInteractiveSelection: true,
                  enableSuggestions: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.note_add,
                      color: Colors.amber,
                      size: 30.0,
                    ),
                    hintText: 'Notes',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                    focusColor: Colors.white,
                  ),
                  onChanged: (String str) {
                    setState(() {
                      notes = str;
                    });
                  },
                ),
              ),
            ),
            SizedBox(
              width: 300.0,
              child: Divider(
                color: Colors.amberAccent,
              ),
            ),
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(8.0, 2.0, 8.0, 0.0),
                  padding: EdgeInsets.only(left: 12.0),
                  alignment: Alignment.topLeft,
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Icon(
                          Icons.email,
                          color: Colors.amber,
                          size: 30.0,
                        ),
                      ),
                      Text(
                        '   Email',
                        style: TextStyle(
                          color: Colors.amber,
                          fontSize: 20.0,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 160),
                        color: Colors.transparent,
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            unselectedWidgetColor: Colors.white,
                          ),
                          child: Checkbox(
                            value: email,
                            activeColor: Colors.amber,
                            onChanged: (bool value) {
                              setState(() {
                                email = value;
                              });
                              // print(email);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 300.0,
              child: Divider(
                color: Colors.amberAccent,
              ),
            ),
            //following container contains the Remind me on a day function
            Container(
              margin: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 10.0),
              padding: EdgeInsets.only(left: 20.0),
              alignment: Alignment.topLeft,
              child: Row(
                children: <Widget>[
                  Text(
                    'Remind me on a Day',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.amberAccent.shade400,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 60),
                    child: CupertinoSwitch(
                      value: isSwitched,
                      // inactiveThumbColor: Colors.white,
                      // inactiveTrackColor: Colors.grey.shade300,
                      onChanged: (value) {
                        setState(() {
                          isSwitched = value;
                        });
                      },
                      // activeTrackColor: Colors.lightBlueAccent.shade200,
                      trackColor: Colors.grey.shade800,
                      activeColor: Colors.amber.shade500,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 300.0,
              child: Divider(
                color: Colors.amberAccent,
              ),
            ),
            ConditionalBuilder(
              condition: isSwitched && isTime,
              builder: (context) {
                return Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 5.0, horizontal: 12.0),
                  child: SizedBox(
                    height: 170.0,
                    width: 700.0,
                    child: CupertinoTheme(
                      data: CupertinoThemeData(
                        textTheme: CupertinoTextThemeData(
                          dateTimePickerTextStyle:
                              TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                      child: CupertinoDatePicker(
                        backgroundColor: Colors.black,
                        initialDateTime: _dateTime,
                        use24hFormat: true,
                        // mode: CupertinoDatePickerMode.time,
                        onDateTimeChanged: (dateTime) {
                          setState(() {
                            _dateTime = dateTime;
                          });
                          // print(time);
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
            ConditionalBuilder(
              condition: isSwitched && !isTime,
              builder: (context) {
                return Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 5.0, horizontal: 12.0),
                  // margin: EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 170.0,
                    width: 700.0,
                    child: CupertinoTheme(
                      data: CupertinoThemeData(
                        textTheme: CupertinoTextThemeData(
                          dateTimePickerTextStyle:
                              TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                      child: CupertinoDatePicker(
                        backgroundColor: Colors.black,
                        initialDateTime: DateTime.now(),
                        mode: CupertinoDatePickerMode.date,
                        onDateTimeChanged: (dateTime) {
                          setState(() {
                            _dateTime = dateTime;
                            // date = dateTime;
                          });
                          // print(_dateTime);
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
            ConditionalBuilder(
              condition: isSwitched,
              builder: (context) {
                return Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
                  // margin: EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        width: 300.0,
                        child: Divider(
                          color: Colors.amberAccent,
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 10.0),
                            // padding: EdgeInsets.only(left: 12.0),
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Remind me on a Time',
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.amberAccent.shade400,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 40),
                            child: CupertinoSwitch(
                              value: isTime,
                              // inactiveThumbColor: Colors.white,
                              // inactiveTrackColor: Colors.grey.shade300,
                              onChanged: (value) {
                                setState(() {
                                  isTime = value;
                                });
                              },
                              // activeTrackColor: Colors.lightBlueAccent.shade200,
                              activeColor: Colors.amber.shade500,
                              trackColor: Colors.grey.shade800,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 300.0,
                        child: Divider(
                          color: Colors.amberAccent,
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Icon(
                              Icons.repeat,
                              size: 30.0,
                              color: Colors.amber,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Repeat',
                              style: TextStyle(
                                color: Colors.amber,
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 145,
                            ),
                            child: IconButton(
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.white,
                                  size: 30.0,
                                ),
                                onPressed: () {
                                  print(_dateTime);
                                }),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),

            // ConditionalBuilder(
            //   condition: date.isBefore(_dateTime) && isSwitched,
            //   builder: (context) {
            //     return Container(
            //       padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 0.0),
            //       child: Row(
            //         children: <Widget>[
            //           FlatButton(
            //             child: Container(
            //               margin: EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 10.0),
            //               // padding: EdgeInsets.only(left: 12.0),
            //               alignment: Alignment.topLeft,
            //               child: Text(
            //                 'Repeat',
            //                 style: TextStyle(
            //                   fontSize: 20.0,
            //                   color: Colors.blue.shade300,
            //                 ),
            //               ),
            //             ),
            //             // onPressed: ,
            //           ),
            //         ],
            //       ),
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}

//following button was added to just check
//the working of the app
// FlatButton(
//   onPressed: () {
//     print(title);
//   },
//   child: Text(
//     'Save Reminder',
//     style: TextStyle(
//       color: Colors.white,
//       fontSize: 20.0,
//       fontWeight: FontWeight.bold,
//     ),
//   ),
// ),
