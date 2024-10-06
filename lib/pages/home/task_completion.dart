import 'package:flutter/material.dart';

class TaskCompletionPage extends StatefulWidget {
  final String task;

  const TaskCompletionPage({super.key, required this.task});

  @override
  _TaskCompletionPageState createState() => _TaskCompletionPageState();
}

class _TaskCompletionPageState extends State<TaskCompletionPage> {
  final TextEditingController _controller = TextEditingController();
  late String taskName;

  @override
  void initState() {
    super.initState();
    taskName = widget.task;
  }

  void _handleSubmit() {
    final String input = _controller.text;
    if (input.isNotEmpty) {
      final int? number = int.tryParse(input);
      if (number != null) {
        // 在这里处理数字输入，例如保存或上传
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Number submitted: $number')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter a valid number')),
        );
      }
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
