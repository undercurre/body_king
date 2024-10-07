import 'package:flutter/material.dart';

import '../../apis/models/user_data_res.dart';
import '../../apis/user_data.dart';
import '../../services/api_response.dart';

class TaskCompletionPage extends StatefulWidget {
  final String task;

  const TaskCompletionPage({super.key, required this.task});

  @override
  _TaskCompletionPageState createState() => _TaskCompletionPageState();
}

class _TaskCompletionPageState extends State<TaskCompletionPage> {
  final TextEditingController _controller = TextEditingController();
  late String taskName;
  DateTime? sleepStartTime;
  DateTime? sleepEndTime;

  @override
  void initState() {
    super.initState();
    taskName = widget.task;
  }

  Future<void> _handleSubmit() async {
    final String input = _controller.text;
    if (input.isNotEmpty ||
        (taskName == 'Sleep' &&
            sleepStartTime != null &&
            sleepEndTime != null)) {
      final int? number = int.tryParse(input);
      if (taskName == 'Walk') {
        if (number != null) {
          await UserDataApi().fetchCreateUserData(step_count: number);
        }
      }
      if (taskName == 'Weight') {
        if (number != null) {
          await UserDataApi().fetchCreateUserData(weight: number);
        }
      }
      if (taskName == 'Sleep') {
        await UserDataApi().fetchCreateUserData(
            sleep_start_time: sleepStartTime, sleep_end_time: sleepEndTime);
      }
      if (taskName == 'Water') {
        if (number != null) {
          await UserDataApi().fetchCreateUserData(water_cups: number);
        }
      }
      if (taskName == 'Drinks') {
        if (number != null) {
          await UserDataApi().fetchCreateUserData(drink_ml: number);
        }
      }
      if (taskName == 'Code') {
        if (number != null) {
          await UserDataApi().fetchCreateUserData(code_lines: number);
        }
      }
      if (taskName == 'Snack') {
        if (number != null) {
          await UserDataApi().fetchCreateUserData(snack_calories: number);
        }
      }
      if (taskName == 'Game') {
        if (number != null) {
          await UserDataApi().fetchCreateUserData(video_game_time: number);
        }
      }
      if (taskName == 'Sport') {
        if (number != null) {
          await UserDataApi().fetchCreateUserData(exercise_calories: number);
        }
      }
      if (taskName == 'Music') {
        if (number != null) {
          await UserDataApi().fetchCreateUserData(music_time: number);
        }
      }
      Navigator.of(context).pop(true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please enter a valid number or select valid times')),
      );
    }
  }

  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        final now = DateTime.now();
        if (isStartTime) {
          sleepStartTime = DateTime(
              now.year, now.month, now.day, picked.hour, picked.minute);
        } else {
          sleepEndTime = DateTime(
              now.year, now.month, now.day, picked.hour, picked.minute);
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              taskName,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            SizedBox(height: 20),
            if (taskName == 'Sleep') ...[
              ElevatedButton(
                onPressed: () => _selectTime(context, true),
                child: Text(sleepStartTime != null
                    ? 'Sleep Start Time: ${sleepStartTime!.hour}:${sleepStartTime!.minute}'
                    : 'Select Sleep Start Time'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _selectTime(context, false),
                child: Text(sleepEndTime != null
                    ? 'Sleep End Time: ${sleepEndTime!.hour}:${sleepEndTime!.minute}'
                    : 'Select Sleep End Time'),
              ),
            ] else ...[
              TextField(
                controller: _controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Enter a number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(color: Colors.teal),
                  ),
                  labelStyle: TextStyle(color: Colors.teal),
                ),
                cursorColor: Colors.teal,
              ),
            ],
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _handleSubmit,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 16.0),
              ),
              child: Text(
                'Submit',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
