import 'package:body_king/pages/home/components/avatar.dart';
import 'package:body_king/pages/home/components/progress_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../isolate/prediction.dart';
import '../../models/user_info.dart';
import '../../models/work_out.dart';
import '../../store/global.dart';
import '../../store/workout.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

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
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hi, ${userInfo?.username}',
                          style: const TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
                        ),
                        const Text(
                          "Great start of the day, a little more to reach today's goals",
                          style: TextStyle(fontSize: 16, color: Colors.black45),
                        )
                      ],
                    ),
                  ),
                  const Avatar(src: 'https://cdn.pixabay.com/photo/2023/06/23/11/23/ai-generated-8083323_640.jpg')
                ],
              ),
              const SizedBox(height: 32),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "today' situation",
                    style: TextStyle(fontSize: 16, color: Colors.black45),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 300,
                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: 3 / 2,
                      children: [
                        ProgressCard(
                          icon: Icons.sports_tennis,
                          name: 'tennis',
                          progress: 0.6,
                          trend: Trend.up,
                          backgroundColor: Colors.redAccent.shade100,
                        ),
                        ProgressCard(
                          icon: Icons.monitor_weight,
                          name: 'Weight',
                          progress: 0.5,
                          trend: Trend.down,
                          backgroundColor: Colors.lightGreenAccent.shade100,
                        ),
                        ProgressCard(
                          icon: Icons.directions_run,
                          name: 'Running',
                          progress: 0.9,
                          trend: Trend.equal,
                          backgroundColor: Colors.lightBlueAccent.shade100,
                        ),
                        ProgressCard(
                          icon: Icons.local_drink,
                          name: 'Hydration',
                          progress: 0.8,
                          trend: Trend.up,
                          backgroundColor: Colors.purple.shade100,
                        ),
                        ProgressCard(
                          icon: Icons.sports_tennis,
                          name: 'tennis',
                          progress: 0.6,
                          trend: Trend.up,
                          backgroundColor: Colors.redAccent.shade100,
                        ),
                        ProgressCard(
                          icon: Icons.monitor_weight,
                          name: 'Weight',
                          progress: 0.5,
                          trend: Trend.down,
                          backgroundColor: Colors.lightGreenAccent.shade100,
                        ),
                        ProgressCard(
                          icon: Icons.directions_run,
                          name: 'Running',
                          progress: 0.9,
                          trend: Trend.equal,
                          backgroundColor: Colors.lightBlueAccent.shade100,
                        ),
                        ProgressCard(
                          icon: Icons.local_drink,
                          name: 'Hydration',
                          progress: 0.8,
                          trend: Trend.up,
                          backgroundColor: Colors.purple.shade100,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
