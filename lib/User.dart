import 'dart:convert';
import 'dart:io';

class User {
  int gender = 1;
  int year = 2026;
  int weight = 55;
  int height = 170;
  int target = 5500;
  List<Step> stepList = [
    Step(steps: 0, date: "", calories: 0),
    Step(steps: 0, date: "", calories: 0),
    Step(steps: 0, date: "", calories: 0),
    Step(steps: 0, date: "", calories: 0),
    Step(steps: 0, date: "", calories: 0),
    Step(steps: 0, date: "", calories: 0),
    Step(steps: 0, date: "", calories: 0),
  ];

  User._();

  static final User _user = User._();

  factory User() {
    return _user;
  }

  Future<void> init() async {
    var file = File("/data/data/com.example.move_go_v4/files/setting");
    if (!await file.exists()) return;
    Map<String, dynamic> data = jsonDecode(await file.readAsString());
    gender = int.parse(data["gender"]);
    year = int.parse(data["gender"]);
    weight = int.parse(data["weight"]);
    height = int.parse(data["height"]);
    target = int.parse(data["target"]);

    List<dynamic> steps = jsonDecode(
      await File("/data/data/com.example.move_go_v4/files/data").readAsString(),
    );
    stepList = steps.map((m) {
      m as Map<String, dynamic>;
      return Step.fromJson(m);
    }).toList();
    while (stepList[stepList.length - 1].date !=
        DateTime.now().toString().substring(0, 10)) {
      stepList.add(
        Step(
          date: DateTime.parse(
            stepList[stepList.length - 1].date,
          ).add(Duration(days: 1)).toString().substring(0, 10),
          steps: 0,
          calories: 0,
        ),
      );
    }
    File(
      "/data/data/com.example.move_go_v4/files/data",
    ).writeAsString(jsonEncode(stepList.map((m) => m.toJson()).toList()));
  }
}

class Step {
  String date;
  int steps;
  int calories;

  Step({required this.steps, required this.date, required this.calories});

  static Step fromJson(Map<String, dynamic> map) {
    return Step(
      date: map["date"].toString(),
      steps: map["steps"],
      calories: map["calories"],
    );
  }

  Map<String, dynamic> toJson() {
    return {"date": date, "steps": steps, "calories": calories};
  }
}
