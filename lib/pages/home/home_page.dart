import 'package:body_king/pages/home/components/avatar.dart';
import 'package:body_king/pages/home/components/progress_card.dart';
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


  final List<Map<String, dynamic>> progressData = [
    {
      'icon': Icons.directions_walk,
      'name': 'Walk',
      'target': 6000,
      'current': 3000,
      'trend': Trend.up,
      'backgroundColor': Colors.redAccent.shade100,
    },
    {
      'icon': Icons.monitor_weight,
      'name': 'Weight',
      'target': 70,
      'current': 75,
      'trend': Trend.down,
      'backgroundColor': Colors.lightGreenAccent.shade100,
    },
    {
      'icon': Icons.bed,
      'name': 'Sleep',
      'target': 8,
      'current': 6,
      'trend': Trend.equal,
      'backgroundColor': Colors.purple.shade100,
    },
    {
      'icon': Icons.water_drop,
      'name': 'Water',
      'target': 8,
      'current': 4,
      'trend': Trend.up,
      'backgroundColor': Colors.lightBlueAccent.shade100,
    },
    {
      'icon': Icons.local_drink,
      'name': 'Drinks',
      'target': 2,
      'current': 1,
      'trend': Trend.up,
      'backgroundColor': Colors.blueGrey.shade100,
    },
    {
      'icon': Icons.code,
      'name': 'Code',
      'target': 8,
      'current': 4,
      'trend': Trend.down,
      'backgroundColor': Colors.deepOrange.shade100,
    },
    {
      'icon': Icons.fastfood,
      'name': 'Snack',
      'target': 3,
      'current': 2,
      'trend': Trend.equal,
      'backgroundColor': Colors.red.shade200,
    },
    {
      'icon': Icons.games,
      'name': 'Game',
      'target': 2,
      'current': 1,
      'trend': Trend.up,
      'backgroundColor': Colors.brown.shade100,
    },
    {
      'icon': Icons.sports,
      'name': 'Sport',
      'target': 2,
      'current': 1,
      'trend': Trend.up,
      'backgroundColor': Colors.green.shade100,
    },
    {
      'icon': Icons.music_video,
      'name': 'Music',
      'target': 2,
      'current': 1,
      'trend': Trend.up,
      'backgroundColor': Colors.blue.shade100,
    },
  ];

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
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
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
              const SizedBox(height: 12),
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
                    color: Colors.transparent,
                    height: 650,
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 3 / 2,
                      ),
                      itemCount: progressData.length,
                      itemBuilder: (context, index) {
                        final data = progressData[index];
                        return ProgressCard(
                          icon: data['icon'],
                          name: data['name'],
                          target: data['target'],
                          current: data['current'],
                          trend: data['trend'],
                          backgroundColor: data['backgroundColor'],
                        );
                      },
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
