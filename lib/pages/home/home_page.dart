import 'package:body_king/pages/home/components/avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../isolate/prediction.dart';
import '../../models/user_info.dart';
import '../../models/work_out.dart';
import '../../store/global.dart';
import '../../store/workout.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Workout> workouts = [];
  UserInfo? userInfo;
  double weeklyWeightLoss = 0;
  double monthlyWeightLoss = 0;
  double quarterlyWeightLoss = 0;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    final workoutProvider = Provider.of<WorkoutProvider>(context, listen: false);
    final globalProvider = Provider.of<GlobalState>(context, listen: false);
    workouts = workoutProvider.workouts;
    final userInfoFromProvider = globalProvider.userInfo;
    if (userInfoFromProvider != null) {
      userInfo = userInfoFromProvider;
    } else {
      userInfo = UserInfo(username: 'lirh', weight: 125, height: 170, age: 26, gender: 'male');
    }
    _predictWeightLoss();
  }

  void _predictWeightLoss() async {
    if (userInfo == null) return;
    final predictions = await FitnessPrediction.predictWeightLoss(userInfo!, workouts);
    setState(() {
      weeklyWeightLoss = predictions['weeklyWeightLoss']!;
      monthlyWeightLoss = predictions['monthlyWeightLoss']!;
      quarterlyWeightLoss = predictions['quarterlyWeightLoss']!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Column(children: [Text('Hi, ${userInfo?.username}', style: ])]),
                  Avatar(src: 'https://cdn.pixabay.com/photo/2023/06/23/11/23/ai-generated-8083323_640.jpg')
                ],
              ),
              Text('Weekly Weight Loss: ${weeklyWeightLoss.toStringAsFixed(2)} kg'),
              Text('Monthly Weight Loss: ${monthlyWeightLoss.toStringAsFixed(2)} kg'),
              Text('Quarterly Weight Loss: ${quarterlyWeightLoss.toStringAsFixed(2)} kg'),
              // Add more widgets to display and record workouts
            ],
          ),
        ),
      ),
    );
  }
}
