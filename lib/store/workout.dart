import 'package:flutter/material.dart';

import '../models/work_out.dart';

class WorkoutProvider with ChangeNotifier {
  // 存储锻炼列表
  final List<Workout> _workouts = [];

  // 获取当前的锻炼列表
  List<Workout> get workouts => _workouts;

  // 添加锻炼
  void addWorkout(Workout workout) {
    _workouts.add(workout);
    notifyListeners(); // 通知监听器状态发生变化
  }

  // 清空锻炼列表
  void clearWorkouts() {
    _workouts.clear();
    notifyListeners();
  }
}
