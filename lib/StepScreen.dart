import 'package:flutter/material.dart';

class StepScreen extends StatefulWidget {
  const StepScreen({super.key});

  @override
  State<StepScreen> createState() => _StepScreenState();
}

class _StepScreenState extends State<StepScreen> {
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
                SizedBox(height: 100, width: 10),
                SizedBox(
                  height: 30,
                  width: 100,
                  child: Pill(children: [Text("df"), Text("fds")]),
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
  var count = 0;
  final List<Widget> children;

  Pill({super.key, required this.children}) {
    count = children.length;
  }

  @override
  State<Pill> createState() => _PillState();
}

class _PillState extends State<Pill> {
  var index = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
      ),
      child: LayoutBuilder(
        builder: (context, c) => Stack(
          children: [
            AnimatedAlign(
              alignment: Alignment(
                (index - widget.count) / widget.count * 2 - 1,
                0,
              ),
              duration: Duration(milliseconds: 300),
              child: Container(
                width: c.maxWidth / widget.count,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
