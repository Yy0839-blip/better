import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Property
  late String currentDateTime;
  DateTime? chosenDateTime; //null
  late bool _isRunning;

  late Color backgroundColor;
  late int count;

  @override
  void initState() {
    super.initState();
    currentDateTime = '';
    _isRunning = true; // timer

    backgroundColor = Colors.white;
    count = 0;

    Timer.periodic(Duration(milliseconds: 100), (timer) {
      if (!_isRunning) {
        timer.cancel();
      }
      _addItem();
      //setState(() {});
    });
  }

  @override //
  void dispose() {
    _isRunning = false;
    super.dispose();
  }

  _addItem() {
    DateTime now = DateTime.now();
    currentDateTime =
        ("${now.year} - ${now.month.toString().padLeft(2, "0")} - ${now.day.toString().padLeft(2, "0")} "
        "${_weekdayToString(now.weekday)} "
        "${now.hour.toString().padLeft(2, "0")}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}");

    //function//backgroundColor
    if (chosenDateTime != null &&
        now.year == chosenDateTime!.year &&
        now.month == chosenDateTime!.month &&
        now.day == chosenDateTime!.day &&
        now.hour == chosenDateTime!.hour &&
        now.minute == chosenDateTime!.minute) {
      if (now.second % 2 == 0) {
        backgroundColor = Colors.yellow;
      } else {
        //(now.second % 2 == 1)
        backgroundColor = Colors.red;
      }
    } else {
      backgroundColor = Colors.white;
    }

    setState(() {});
  }

  String _weekdayToString(int weekday) {
    String dateName = "";
    switch (weekday) {
      case 1:
        dateName = "월";
        break;
      case 2:
        dateName = "화";
        break;
      case 3:
        dateName = "수";
        break;
      case 4:
        dateName = "목";
        break;
      case 5:
        dateName = "금";
        break;
      case 6:
        dateName = "토";
        break;
      case 7:
        dateName = "일";
        break;
    }
    return dateName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text('알람 정하기'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '현재 시간 : $currentDateTime',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(
              height: 200,
              width: 300,
              child: CupertinoDatePicker(
                initialDateTime: DateTime.now(),
                use24hFormat: true,
                onDateTimeChanged: (value) {
                  chosenDateTime = value;
                  setState(() {});
                },
              ),
            ),

            Text(
              '선택 시간 : ${chosenDateTime != null ? _chosenItem(chosenDateTime!) : '시간을 선택하세요.'}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  //function
  String _chosenItem(DateTime now) {
    count++;
    String chosenDateTime =
        ("${now.year} - ${now.month.toString().padLeft(2, "0")} - ${now.day.toString().padLeft(2, "0")} ${_weekdayToString(now.weekday)} ${now.hour.toString().padLeft(2, "0")}:${now.minute.toString().padLeft(2, '0')}");
    return chosenDateTime;
  }
}
