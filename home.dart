import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late int selectedNumber;
  late List dan;

  @override
  void initState() {
    super.initState();
    selectedNumber = 0;
    dan = List.generate(8, (index) => '${index + 2}');
  }

  @override
  Widget build(BuildContext context) {
    int danNumber = int.parse(dan[selectedNumber]);

    return Scaffold(
      appBar: AppBar(
        title: Text('${dan[selectedNumber]} 단'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 300,
              height: 250,
              child: CupertinoPicker(
                itemExtent: 50,
                scrollController:
                    FixedExtentScrollController(
                      initialItem: 0,
                    ),
                onSelectedItemChanged: (value) {
                  selectedNumber = value;
                  setState(() {});
                },
                children: List.generate(
                  dan.length,
                  (index) =>
                      Center(child: Text('${dan[index]}단')),
                ),
              ),
            ),

            Container(
              padding: EdgeInsets.all(30),
              color: Colors.deepPurple,
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: List.generate(
                  9,
                  (i) => Text(
                    '${danNumber} x ${i + 1} = ${danNumber * (i + 1)}',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      //fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
