import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_info.dart';
import '../store/global.dart';
import '../utils/timeFilter.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  final _usernameController = TextEditingController();
  DateTime? _selectedBirthday;
  String? _selectedGender;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<GlobalState>(context);

    return Scaffold(
      appBar: null,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _heightController,
              decoration: const InputDecoration(labelText: 'Height (cm)'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _weightController, // 使用体重控制器
              decoration: const InputDecoration(labelText: 'Weight (kg)'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () async {
                DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: _selectedBirthday ?? DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (picked != null) {
                  setState(() {
                    _selectedBirthday = picked;
                  });
                }
              },
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: 'Birthday',
                  border: OutlineInputBorder(),
                ),
                child: Text(
                  _selectedBirthday == null
                      ? 'Select your birthday'
                      : '${_selectedBirthday!.toLocal()}'.split(' ')[0],
                ),
              ),
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'Gender'),
              value: _selectedGender,
              items: ['male', 'female']
                  .map((gender) => DropdownMenuItem(
                value: gender,
                child: Text(gender),
              ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedGender = value;
                });
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_heightController.text.isNotEmpty &&
                    _selectedBirthday != null &&
                    _selectedGender != null) {
                  // 创建用户信息对象并存储在 Provider 中
                  userProvider.setUserInfo(UserInfo(
                    username: _usernameController.text,
                    weight: double.parse(_weightController.text),
                    height: double.parse(_heightController.text),
                    age: calculateAge(_selectedBirthday!),
                    gender: _selectedGender!,
                  ));
                  // 清空输入框
                  _heightController.clear();
                  setState(() {
                    _selectedBirthday = null;
                    _selectedGender = null;
                  });
                  // 可选：显示成功消息或导航到其他页面
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Profile updated!')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please fill in all fields.')),
                  );
                }
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
