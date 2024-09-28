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
import 'components/remind.dart';

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
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
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
                  const SizedBox(width: 10),
                  const Avatar(src: 'https://cdn.pixabay.com/photo/2023/06/23/11/23/ai-generated-8083323_640.jpg')
                ],
              ),
              const SizedBox(height: 32),
              QuoteCard(
                quotes: const [
                  {
                    'quote': 'The only limit to our realization of tomorrow is our doubts of today.',
                    'author': 'Franklin D. Roosevelt',
                  },
                  {
                    'quote': 'The future belongs to those who believe in the beauty of their dreams.',
                    'author': 'Eleanor Roosevelt',
                  },
                  {
                    'quote': 'Do not wait to strike till the iron is hot; but make it hot by striking.',
                    'author': 'William Butler Yeats',
                  },
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "today' situation",
                    style: TextStyle(fontSize: 16, color: Colors.black45),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    color: Colors.grey,
                    height: 800,
                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: 3 / 2,
                      children: [
                        ProgressCard(
                          icon: Icons.directions_walk,
                          name: 'Walk',
                          target: 6000,
                          current: 3000,
                          trend: Trend.up,
                          backgroundColor: Colors.redAccent.shade100,
                        ),
                        ProgressCard(
                          icon: Icons.monitor_weight,
                          name: 'Weight',
                          target: 6000,
                          current: 3000,
                          trend: Trend.down,
                          backgroundColor: Colors.lightGreenAccent.shade100,
                        ),
                        ProgressCard(
                          icon: Icons.bed,
                          name: 'Sleep',
                          target: 6000,
                          current: 3000,
                          trend: Trend.equal,
                          backgroundColor: Colors.purple.shade100,
                        ),
                        ProgressCard(
                          icon: Icons.water_drop,
                          name: 'Hydration',
                          target: 6000,
                          current: 3000,
                          trend: Trend.up,
                          backgroundColor: Colors.lightBlueAccent.shade100,
                        ),
                        ProgressCard(
                          icon: Icons.local_drink,
                          name: 'tennis',
                          target: 6000,
                          current: 3000,
                          trend: Trend.up,
                          backgroundColor: Colors.blueGrey.shade100,
                        ),
                        ProgressCard(
                          icon: Icons.monitor_weight,
                          name: 'Weight',
                          target: 6000,
                          current: 3000,
                          trend: Trend.down,
                          backgroundColor: Colors.lightGreenAccent.shade100,
                        ),
                        ProgressCard(
                          icon: Icons.directions_run,
                          name: 'Running',
                          target: 6000,
                          current: 3000,
                          trend: Trend.equal,
                          backgroundColor: Colors.lightBlueAccent.shade100,
                        ),
                        ProgressCard(
                          icon: Icons.local_drink,
                          name: 'Hydration',
                          target: 6000,
                          current: 3000,
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
