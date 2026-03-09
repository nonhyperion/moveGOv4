import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:move_go_v4/User.dart';

class StepScreen extends StatefulWidget {
  const StepScreen({super.key});

  @override
  State<StepScreen> createState() => _StepScreenState();
}

class _StepScreenState extends State<StepScreen> {
  var steps = 1999;
  var target = 1000;
  var page = 0;
  late PageController controller;

  @override
  void initState() {
    controller = PageController(initialPage: 6);
    User().init();
    target = User().target;
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xff265863), Colors.black38, Colors.black],
              ),
            ),
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 50, width: 10),
                SizedBox(
                  height: 40,
                  width: 150,
                  child: Pill(children: [Text("日"), Text("週"), Text("月")]),
                ),
                SizedBox(
                  height: 350,
                  child: PageView.builder(
                    onPageChanged: (i) {
                      page = i;
                      setState(() {});
                    },
                    controller: controller,
                    itemCount: 7,
                    itemBuilder: (context, i) {
                      var rate =
                          User().stepList[User().stepList.length - (7 - i)].steps / User().target;
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(8, 25, 8, 8),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox.square(
                              dimension: 300,
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.white10,
                                value:
                                    User().stepList[User().stepList.length - (7 - i)].steps /
                                    User().target,
                                strokeWidth: 25,
                                strokeCap: StrokeCap.round,
                                color: rate < 0.5
                                    ? Color(0xFFFF4D4F)
                                    : rate >= 0.5 && rate < 1
                                    ? Color(0xffFFA940)
                                    : rate >= 1 && rate < 1.5
                                    ? Color(0xff52C41A)
                                    : rate >= 1.5 && rate < 2
                                    ? Color(0xff1677FF)
                                    : Color(0xff722ED1),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  User().stepList[User().stepList.length - (7 - i)].date ==
                                          DateTime.now().toString().substring(0, 10)
                                      ? "今天"
                                      : User().stepList[User().stepList.length - (7 - i)].date
                                            .replaceFirst('-', " 年 ")
                                            .replaceFirst('-', " 月 ")
                                            .replaceFirst('-', " 日 "),
                                  style: TextStyle(fontSize: 30, color: Color(0xff33abd3)),
                                ),
                                Text(
                                  User().stepList[User().stepList.length - (7 - i)].steps
                                      .toString(),
                                  style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 90,
                        child: Card(
                          shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(35)),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.local_fire_department_sharp, color: Colors.red),
                                    Text(
                                      User().stepList.reversed
                                          .takeWhile((m) => m.steps > User().target)
                                          .length
                                          .toString(),
                                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Text(
                                  "Streak",
                                  style: TextStyle(fontSize: 12, color: Colors.orange),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 90,
                      child: Card(
                        shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(35)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
                          child: Column(
                            children: [
                              Text(
                                User().stepList[User().stepList.length - (7 - page)].calories
                                    .toString(),
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              Text("大卡", style: TextStyle(fontSize: 12, color: Colors.white54)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 10000,
                    height: 100,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                        child: CustomPaint(
                          painter: Graph(
                            day: User().stepList.reversed
                                .take(7)
                                .toList()
                                .reversed
                                .map((m) => m.steps)
                                .toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Pill extends StatefulWidget {
  final List<Widget> children;

  const Pill({super.key, required this.children});

  @override
  State<Pill> createState() => _PillState();
}

class _PillState extends State<Pill> {
  var index = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(40),
      ),
      child: LayoutBuilder(
        builder: (context, c) => Stack(
          children: [
            AnimatedAlign(
              alignment: Alignment(index / (widget.children.length - 1) * 2 - 1, 0),
              duration: Duration(milliseconds: 300),
              curve: Curves.ease,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  width: c.maxWidth / widget.children.length,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: c.maxHeight,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: widget.children
                    .map(
                      (w) => GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          index = widget.children.indexOf(w);
                          setState(() {});
                        },
                        child: SizedBox(
                          width: c.maxWidth / widget.children.length,
                          child: Center(child: w),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Graph extends CustomPainter {
  List<int> day;

  Graph({required this.day});

  @override
  void paint(Canvas canvas, Size size) {
    var max = 1;
    for (var i in day) {
      if (i > max) max = i;
    }
    for (int i = 0; i < 7; i++) {
      canvas.drawLine(
        Offset(i * size.width / 6, 0),
        Offset(i * size.width / 6, size.height),
        Paint()
          ..color = Colors.white54
          ..strokeWidth = 1.5,
      );
    }
    List<Offset> point = [];
    for (int i = 0; i < 7; i++) {
      point.add(Offset(i * size.width / 6, (max - day[i]) / max * size.height));
    }
    canvas.drawPoints(
      PointMode.polygon,
      point,
      Paint()
        ..color = Colors.blue
        ..strokeWidth = 3,
    );
    point.insert(0, Offset(0, size.height));
    point.add(Offset(size.width, size.height));
    Path path = Path()..addPolygon(point, true);
    canvas.drawPath(path, Paint()..color = Colors.white);
    for (int i = 0; i < 7; i++) {
      canvas.drawCircle(
        Offset(i * size.width / 6, (max - day[i]) / max * size.height),
        5,
        Paint()..color = Colors.white,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
