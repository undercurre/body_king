import 'dart:isolate';

import '../models/user_info.dart';
import '../models/work_out.dart';

class FitnessPrediction {
  static Future<Map<String, double>> predictWeightLoss(UserInfo userInfo, List<Workout> workouts) async {
    final response = ReceivePort();
    await Isolate.spawn(_predict, response.sendPort);

    final sendPort = await response.first as SendPort;
    final answer = ReceivePort();

    sendPort.send([answer.sendPort, userInfo, workouts]);

    final result = await answer.first as Map<String, double>;
    return result;
  }

  static void _predict(SendPort sendPort) {
    final port = ReceivePort();
    sendPort.send(port.sendPort);

    port.listen((message) {
      final answerPort = message[0] as SendPort;
      final userInfo = message[1] as UserInfo;
      final workouts = message[2] as List<Workout>;

      // Calculate BMR
      double bmr;
      if (userInfo.gender == 'male') {
        bmr = 88.362 + (13.397 * userInfo.weight) + (4.799 * userInfo.height) - (5.677 * userInfo.age);
      } else {
        bmr = 447.593 + (9.247 * userInfo.weight) + (3.098 * userInfo.height) - (4.330 * userInfo.age);
      }

      // Calculate total daily energy expenditure (TDEE) assuming moderate exercise level
      double tdee = bmr * 1.55;

      // Calculate calories burned from workouts
      int totalWorkoutCalories = 0;
      for (var workout in workouts) {
        // Example: assume each workout burns 10 calories per minute
        totalWorkoutCalories += workout.duration * 10;
      }

      // Predict weight loss
      double dailyCaloriesBurned = tdee + totalWorkoutCalories;
      double dailyCalorieDeficit = dailyCaloriesBurned - tdee;
      double weeklyWeightLoss = (dailyCalorieDeficit * 7) / 7700; // 7700 calories = 1 kg
      double monthlyWeightLoss = weeklyWeightLoss * 4;
      double quarterlyWeightLoss = weeklyWeightLoss * 13;

      answerPort.send({
        'weeklyWeightLoss': weeklyWeightLoss,
        'monthlyWeightLoss': monthlyWeightLoss,
        'quarterlyWeightLoss': quarterlyWeightLoss,
      });
    });
  }
}
