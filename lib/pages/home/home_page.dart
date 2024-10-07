import 'package:body_king/apis/avatar.dart';
import 'package:body_king/apis/models/avatar_res.dart';
import 'package:body_king/apis/models/motto_res.dart';
import 'package:body_king/apis/motto.dart';
import 'package:body_king/pages/home/components/avatar.dart';
import 'package:body_king/pages/home/components/progress_card.dart';
import 'package:body_king/pages/home/task_completion.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../apis/models/user_data_res.dart';
import '../../apis/models/user_res.dart';
import '../../apis/user.dart';
import '../../apis/user_data.dart';
import '../../isolate/prediction.dart';
import '../../models/user_info.dart';
import '../../models/work_out.dart';
import '../../services/api_response.dart';
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

  List<Map<String, String>> quotes = [];

  @override
  void initState() {
    super.initState();
    _loadData();
    _loadUserDatas();
    _loadUserDetail();
    _loadAvatar();
  }

  void _loadData() async {
    final workoutProvider =
        Provider.of<WorkoutProvider>(context, listen: false);
    final globalProvider = Provider.of<GlobalState>(context, listen: false);
    workouts = workoutProvider.workouts;
    final userInfoFromProvider = globalProvider.userInfo;
    if (userInfoFromProvider != null) {
      userInfo = userInfoFromProvider;
    } else {
      userInfo = UserInfo(
          username: '', weight: 125, height: 170, age: 26, gender: 'male');
    }
    _loadMottos();
  }

  Future<void> _loadMottos() async {
    ApiResponse<GetMottoByUserResponse> res = await MottoApi().fetchGetMottos();
    setState(() {
      quotes = res.data.mottos.map((element) {
        return {
          'quote': element.motto_text,
          'desc': element.created_at.substring(0, 10)
        };
      }).toList();
    });
  }

  Future<void> _loadUserDatas() async {
    ApiResponse<GetUserDataByUserResponse> res =
        await UserDataApi().fetchGetUserData();
    setState(() {
      Map<String, dynamic> walk =
      progressData.firstWhere((element) => element["name"] == 'Walk');
      walk['current'] = res.data.userData.step_count;
      Map<String, dynamic> weight =
      progressData.firstWhere((element) => element["name"] == 'Weight');
      weight['current'] = res.data.userData.weight;
      Map<String, dynamic> sleep =
      progressData.firstWhere((element) => element["name"] == 'Sleep');
      DateTime start = DateTime.parse(res.data.userData.sleep_start_time);
      DateTime end = DateTime.parse(res.data.userData.sleep_end_time);
      Duration sleepDuration = end.difference(start);
      double hours = sleepDuration.inMinutes / 60.0;
      sleep['current'] = hours;
      Map<String, dynamic> water =
      progressData.firstWhere((element) => element["name"] == 'Water');
      water['current'] = res.data.userData.water_cups;
      Map<String, dynamic> drinks =
      progressData.firstWhere((element) => element["name"] == 'Drinks');
      drinks['current'] = res.data.userData.drink_ml;
      Map<String, dynamic> code =
      progressData.firstWhere((element) => element["name"] == 'Code');
      code['current'] = res.data.userData.code_lines;
      Map<String, dynamic> snack =
      progressData.firstWhere((element) => element["name"] == 'Snack');
      snack['current'] = res.data.userData.snack_calories;
      Map<String, dynamic> game =
      progressData.firstWhere((element) => element["name"] == 'Game');
      game['current'] = res.data.userData.video_game_time;
      Map<String, dynamic> sport =
      progressData.firstWhere((element) => element["name"] == 'Sport');
      sport['current'] = res.data.userData.exercise_calories;
      Map<String, dynamic> music =
      progressData.firstWhere((element) => element["name"] == 'Music');
      music['current'] = res.data.userData.music_time;
    });
  }

  Future<void> _loadUserDetail() async {
    ApiResponse<GetUserDetailResponse> res = await UserApi().fetchUserInfo();
    UserInfo? userInfo = GlobalState().userInfo;
    if (userInfo != null) {
      GlobalState().setUserInfo(userInfo);
    } else {
      GlobalState().setUserInfo(new UserInfo(
          username: res.data.userDetail.username,
          weight: 125,
          height: 170,
          age: 26,
          gender: 'male'));
    }
  }

  Future<void> _loadAvatar() async {
    ApiResponse<GetAvatarResponse> res = await AvatarApi().fetchGetAvatar();
    GlobalState().setAvatar(res.data.avatar.avatar_url);
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
                          style: const TextStyle(
                              fontSize: 40, fontWeight: FontWeight.w700),
                        ),
                        Text(
                          "Great start of the day, a little more to reach today's goals",
                          style: TextStyle(
                              fontSize: 16,
                              color: context.watch<GlobalState>().isDarkMode
                                  ? Colors.white54
                                  : Colors.black54),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Avatar(src: context.watch<GlobalState>().avatar_url)
                ],
              ),
              const SizedBox(height: 12),
              QuoteCard(
                quotes: quotes,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "today' situation",
                    style: TextStyle(
                        fontSize: 16,
                        color: context.watch<GlobalState>().isDarkMode
                            ? Colors.white54
                            : Colors.black54),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    color: Colors.transparent,
                    height: 650,
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
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
                          onTap: () => {
                            Navigator.pushNamed(
                              context,
                              '/taskCompletion',
                              arguments: data['name'],
                            ).then((result) {
                              _loadUserDatas();
                            })
                          },
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
