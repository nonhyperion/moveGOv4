import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:move_go_v4/StepScreen.dart';

void main() {
  runApp(MaterialApp(home: StartScreen(), theme: ThemeData.dark()));
}

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  var _open = -1;

  int get open {
    return _open;
  }

  set open(int val) {
    if (val == _open) {
      _open = -1;
    } else {
      _open = val;
    }
  }

  var gender = 1;
  var year = 2026;
  var weight = 55;
  var height = 170;
  var target = 5500;
  var targetC = false;
  late PageController pageController;
  late FixedExtentScrollController yearController;
  late FixedExtentScrollController weightController;
  late FixedExtentScrollController heightController;

  @override
  void initState() {
    pageController = PageController(initialPage: 0);
    yearController = FixedExtentScrollController(initialItem: DateTime.now().year - 1901);
    weightController = FixedExtentScrollController(initialItem: 55);
    heightController = FixedExtentScrollController(initialItem: 170);
    to();
    super.initState();
  }

  Future<void> to() async {
    if (!await File("/data/data/com.example.move_go_v4/files/data").exists()) {
      File(
        "/data/data/com.example.move_go_v4/files/data",
      ).writeAsString(await rootBundle.loadString("assets/data.json"));
    }
    if (await File("/data/data/com.example.move_go_v4/files/setting").exists()) {
      Navigator.of(context)
        ..pop()
        ..push(MaterialPageRoute(builder: (context) => StepScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: PageView(
          controller: pageController,
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 75),
                  Text("設置", style: TextStyle(fontSize: 30)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "獲取精確的步數,距離和卡路里計算",
                      style: TextStyle(fontSize: 16, color: Colors.white24),
                    ),
                  ),
                  SizedBox(height: 100),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 100000,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ListTile(
                                onTap: () {
                                  open = 1;
                                  setState(() {});
                                },
                                leading: Icon(Icons.directions_walk, color: Colors.blue),
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("性別"),
                                    Row(
                                      children: [
                                        Text(gender == 0 ? "女" : "男"),
                                        AnimatedRotation(
                                          curve: Curves.ease,
                                          turns: open == 1 ? 0.25 : 0,
                                          duration: Duration(milliseconds: 300),
                                          child: Icon(Icons.arrow_forward_ios),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                curve: Curves.ease,
                                height: open == 1 ? 120 : 0,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      RadioGroup<int>(
                                        groupValue: gender,
                                        onChanged: (value) {
                                          setState(() {
                                            gender = value!;
                                          });
                                        },
                                        child: Column(
                                          children: [
                                            RadioListTile<int>(value: 0, title: Text("女")),
                                            RadioListTile<int>(value: 1, title: Text("男")),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Divider(indent: 10, endIndent: 10),
                              ListTile(
                                onTap: () {
                                  open = 2;
                                  setState(() {});
                                },
                                leading: Icon(Icons.cake_outlined, color: Colors.blue),
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("出生年次"),
                                    Row(
                                      children: [
                                        Text(year.toString()),
                                        AnimatedRotation(
                                          turns: open == 2 ? 0.25 : 0,
                                          curve: Curves.ease,
                                          duration: Duration(milliseconds: 300),
                                          child: Icon(Icons.arrow_forward_ios),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              AnimatedContainer(
                                height: open == 2 ? 100 : 0,
                                curve: Curves.ease,
                                duration: Duration(milliseconds: 300),
                                child: ListWheelScrollView.useDelegate(
                                  useMagnifier: true,
                                  magnification: 1.3,
                                  diameterRatio: 1.5,
                                  physics: FixedExtentScrollPhysics(),
                                  onSelectedItemChanged: (a) {
                                    year = a + 1901;
                                    setState(() {});
                                  },
                                  itemExtent: 30,
                                  controller: yearController,
                                  childDelegate: ListWheelChildBuilderDelegate(
                                    childCount: DateTime.now().year - 1900,
                                    builder: (context, index) => Text(
                                      (1901 + index).toString(),
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                ),
                              ),
                              Divider(indent: 10, endIndent: 10),
                              ListTile(
                                onTap: () {
                                  open = 3;
                                  setState(() {});
                                },
                                leading: Icon(Icons.monitor_weight_outlined, color: Colors.blue),
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("重量"),
                                    Row(
                                      children: [
                                        Text("${weight}KG"),
                                        AnimatedRotation(
                                          curve: Curves.ease,
                                          turns: open == 3 ? 0.25 : 0,
                                          duration: Duration(milliseconds: 300),
                                          child: Icon(Icons.arrow_forward_ios),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                height: open == 3 ? 100 : 0,
                                curve: Curves.ease,
                                child: ListWheelScrollView.useDelegate(
                                  useMagnifier: true,
                                  magnification: 1.3,
                                  physics: FixedExtentScrollPhysics(),
                                  onSelectedItemChanged: (a) {
                                    weight = a;
                                    setState(() {});
                                  },
                                  itemExtent: 30,
                                  controller: weightController,
                                  diameterRatio: 1.5,
                                  childDelegate: ListWheelChildBuilderDelegate(
                                    childCount: 200,
                                    builder: (context, index) =>
                                        Text(index.toString(), style: TextStyle(fontSize: 20)),
                                  ),
                                ),
                              ),
                              Divider(indent: 10, endIndent: 10),
                              ListTile(
                                onTap: () {
                                  open = 4;
                                  setState(() {});
                                },
                                leading: Icon(Icons.height, color: Colors.blue),
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("身高"),
                                    Row(
                                      children: [
                                        Text("${height}CM"),
                                        AnimatedRotation(
                                          curve: Curves.ease,
                                          turns: open == 4 ? 0.25 : 0,
                                          duration: Duration(milliseconds: 300),
                                          child: Icon(Icons.arrow_forward_ios),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                height: open == 4 ? 100 : 0,
                                curve: Curves.ease,
                                child: ListWheelScrollView.useDelegate(
                                  useMagnifier: true,
                                  magnification: 1.3,
                                  physics: FixedExtentScrollPhysics(),
                                  onSelectedItemChanged: (a) {
                                    height = a;
                                    setState(() {});
                                  },
                                  itemExtent: 30,
                                  controller: heightController,
                                  diameterRatio: 1.5,
                                  childDelegate: ListWheelChildBuilderDelegate(
                                    childCount: 250,
                                    builder: (context, index) =>
                                        Text(index.toString(), style: TextStyle(fontSize: 20)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      width: 10000,
                      child: FilledButton(
                        onPressed: () {
                          pageController.animateToPage(
                            1,
                            duration: Duration(milliseconds: 250),
                            curve: Curves.ease,
                          );
                        },
                        style: FilledButton.styleFrom(
                          backgroundColor: ColorScheme.of(context).surfaceContainerLow,
                        ),
                        child: Text(
                          "下一步",
                          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                SizedBox(height: 75),
                Text("設定你的每日步數目標", style: TextStyle(fontSize: 30)),
                SizedBox(height: 100),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 10000,
                    child: GestureDetector(
                      onTap: () {
                        targetC = false;
                        setState(() {});
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: !targetC ? Colors.blue : Colors.transparent,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("5500步數", style: TextStyle(fontSize: 25)),
                              Text("建議", style: TextStyle(color: Colors.green, fontSize: 20)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      targetC = true;
                      setState(() {});
                    },
                    child: SizedBox(
                      width: 10000,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: targetC ? Colors.blue : Colors.transparent,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("客制目標", style: TextStyle(fontSize: 25)),
                                  AnimatedRotation(
                                    turns: targetC ? 0.25 : 0,
                                    curve: Curves.ease,
                                    duration: Duration(milliseconds: 300),
                                    child: Icon(Icons.arrow_forward_ios),
                                  ),
                                ],
                              ),
                              AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                height: targetC ? 50 : 5,
                                curve: Curves.ease,
                                child: SingleChildScrollView(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.remove),
                                        onPressed: () {
                                          if (target > 100) target -= 100;
                                          setState(() {});
                                        },
                                      ),
                                      Text(target.toString(), style: TextStyle(fontSize: 30)),
                                      IconButton(
                                        icon: Icon(Icons.add),
                                        onPressed: () {
                                          target += 100;
                                          setState(() {});
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 147),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 10000,
                    child: FilledButton(
                      onPressed: () {
                        var date = {
                          "gender": gender.toString(),
                          "year": year.toString(),
                          "weight": weight.toString(),
                          "height": height.toString(),
                          "target": targetC ? target.toString() : "5500",
                        };
                        File("/data/data/com.example.move_go_v4/files/setting")
                          ..create()
                          ..writeAsString(jsonEncode(date));
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => StepScreen()),
                        );
                      },
                      style: FilledButton.styleFrom(backgroundColor: Colors.blue),
                      child: Text(
                        "繼續",
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
