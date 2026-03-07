import 'package:flutter/material.dart';
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
  var open = -1;
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
    yearController = FixedExtentScrollController(
      initialItem: DateTime.now().year - 1901,
    );
    weightController = FixedExtentScrollController(initialItem: 55);
    heightController = FixedExtentScrollController(initialItem: 170);
    super.initState();
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
                                leading: Icon(
                                  Icons.directions_walk,
                                  color: Colors.blue,
                                ),
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("性別"),
                                    Row(
                                      children: [
                                        Text(gender == 0 ? "女" : "男"),
                                        Icon(
                                          open == 1
                                              ? Icons.keyboard_arrow_down
                                              : Icons.arrow_forward_ios,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              if (open == 1)
                                Column(
                                  children: [
                                    RadioGroup(
                                      groupValue: gender,
                                      onChanged: (a) {
                                        gender = 0;
                                        setState(() {});
                                      },
                                      child: RadioListTile(
                                        value: 0,
                                        title: Text("女"),
                                      ),
                                    ),
                                    RadioGroup(
                                      groupValue: gender,
                                      onChanged: (a) {
                                        gender = 1;
                                        setState(() {});
                                      },
                                      child: RadioListTile(
                                        value: 1,
                                        title: Text("男"),
                                      ),
                                    ),
                                  ],
                                ),
                              Divider(indent: 10, endIndent: 10),
                              ListTile(
                                onTap: () {
                                  dayOpen = !dayOpen;
                                  setState(() {});
                                },
                                leading: Icon(
                                  Icons.cake_outlined,
                                  color: Colors.blue,
                                ),
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("出生年次"),
                                    Row(
                                      children: [
                                        Text(year.toString()),
                                        Icon(
                                          dayOpen
                                              ? Icons.keyboard_arrow_down
                                              : Icons.arrow_forward_ios,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              if (dayOpen)
                                SizedBox(
                                  height: 100,
                                  child: ListWheelScrollView.useDelegate(
                                    diameterRatio: 1.5,
                                    physics: FixedExtentScrollPhysics(),
                                    onSelectedItemChanged: (a) {
                                      year = a + 1901;
                                      setState(() {});
                                    },
                                    itemExtent: 30,
                                    controller: yearController,
                                    childDelegate:
                                        ListWheelChildBuilderDelegate(
                                          childCount:
                                              DateTime.now().year - 1900,
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
                                  weightOpen = !weightOpen;
                                  setState(() {});
                                },
                                leading: Icon(
                                  Icons.monitor_weight_outlined,
                                  color: Colors.blue,
                                ),
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("重量"),
                                    Row(
                                      children: [
                                        Text("${weight}KG"),
                                        Icon(
                                          weightOpen
                                              ? Icons.keyboard_arrow_down
                                              : Icons.arrow_forward_ios,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              if (weightOpen)
                                SizedBox(
                                  height: 100,
                                  child: ListWheelScrollView.useDelegate(
                                    physics: FixedExtentScrollPhysics(),
                                    onSelectedItemChanged: (a) {
                                      weight = a;
                                      setState(() {});
                                    },
                                    itemExtent: 30,
                                    controller: weightController,
                                    diameterRatio: 1.5,
                                    childDelegate:
                                        ListWheelChildBuilderDelegate(
                                          childCount: 200,
                                          builder: (context, index) => Text(
                                            index.toString(),
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ),
                                  ),
                                ),
                              Divider(indent: 10, endIndent: 10),
                              ListTile(
                                onTap: () {
                                  heightOpen = !heightOpen;
                                  setState(() {});
                                },
                                leading: Icon(Icons.height, color: Colors.blue),
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("身高"),
                                    Row(
                                      children: [
                                        Text("${height}CM"),
                                        Icon(
                                          heightOpen
                                              ? Icons.keyboard_arrow_down
                                              : Icons.arrow_forward_ios,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              AnimatedContainer(
                                duration: Duration(milliseconds: 200),
                                height: heightOpen ? 100 : 0,
                                curve: Curves.ease,
                                child: ListWheelScrollView.useDelegate(
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
                                    builder: (context, index) => Text(
                                      index.toString(),
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  FilledButton(
                    onPressed: () {
                      pageController.animateToPage(
                        1,
                        duration: Duration(milliseconds: 250),
                        curve: Curves.ease,
                      );
                    },
                    child: Text("下一步"),
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
                    height: 100,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("5500步數", style: TextStyle(fontSize: 25)),
                            Text("建議", style: TextStyle(color: Colors.green)),
                          ],
                        ),
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
