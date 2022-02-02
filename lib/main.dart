//@dart=2.9
import 'package:age/age.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_time_patterns.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // var curDate;
  bool visible = false;
  @override
  void initState() {
    super.initState();
    // curDate = DateTime.now();
    selectedDate = DateTime.now();
  }

  void toggle() {
    setState(() {
      visible = true;
    });
  }

  // getValue(value) {
  //   setState(() {
  //     selectedDate = value;
  //   });
  // }

  DateTime selectedDate;
  final DateFormat formatter = DateFormat('dd / MM / yyyy');

  DateTime uDate;
  AgeDuration age = AgeDuration(
    years: 0,
    months: 0,
    days: 0,
  );
  DateTime nextBirthdayDate;
  AgeDuration nextBirthdayDuration;
  void getAge() {
    DateTime today = DateTime.now();

    // Find out your age
    age = Age.dateDifference(
        fromDate: selectedDate, toDate: today, includeToDate: false);

    print('Your age is ${age}'); // Your age is Years: 30, Months: 0, Days: 4

    // Find out when your next birthday will be.
    DateTime tempDate =
        DateTime(today.year, selectedDate.month, selectedDate.day);
    nextBirthdayDate = tempDate.isBefore(today)
        ? Age.add(date: tempDate, duration: AgeDuration(years: 1))
        : tempDate;
    nextBirthdayDuration =
        Age.dateDifference(fromDate: today, toDate: nextBirthdayDate);

    print(
        'You next birthday will be on $nextBirthdayDate or in $nextBirthdayDuration');
    // You next birthday will be on 2021-01-20 00:00:00.000 or in Years: 0, Months: 11, Days: 27
  }

  TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 200,
              child: CupertinoDatePicker(
                maximumYear: 2023,
                dateOrder: DatePickerDateOrder.dmy,
                minimumYear: 1947,
                mode: CupertinoDatePickerMode.date,
                initialDateTime: selectedDate,
                onDateTimeChanged: (value) {
                  if (value != null) {
                    setState(() {
                      // curDate = value;
                      selectedDate = value;
                    });
                  }
                },
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  print(_textEditingController.text);
                  setState(() {
                    getAge();
                    toggle();
                  });
                },
                child: Text("data"),
              ),
            ),
            Text("${formatter.format(selectedDate)}"),
            Visibility(
              visible: visible,
              child: Column(
                children: [
                  Text(
                      "( You are ${age.years} years, ${age.months} months and ${age.days} days old... )"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
