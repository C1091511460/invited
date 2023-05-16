import 'package:flutter/material.dart';

import '../../widgets/api.dart';
import '../../widgets/securestorage.dart';

class PreferenceFormPage extends StatefulWidget {
  @override
  _PreferenceFormPageState createState() => _PreferenceFormPageState();
}

class _PreferenceFormPageState extends State<PreferenceFormPage> {
  API api = API();
  final secureStorage = SecureStorage();
  final _formKey = GlobalKey<FormState>();
  List<String> _selectedPreferences = [];

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final secureStorage = SecureStorage();
      final userData = await secureStorage.readUserData(); // 读取用户数据
      final userId = userData?['user_id']?.toString() ?? ''; //
      final useremail = userData?['email']?.toString() ?? '';// 提取用户ID字段

      await api.savePreferences(userId, _selectedPreferences);
      await api.setFirstLoginStatus(userId, false); // 将 first_login 设置为 true

      Map<String, dynamic>? userData1 = await api.fetchUserData(useremail);

      if (userData != null) {
        // 调用 saveUserData 函数保存用户数据
        await secureStorage.saveUserData(userData1!);
      } else {
        // 处理获取用户数据失败的情况
        print('无法获取用户数据');
      }

      // Navigate back to the previous screen
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preference Form'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CheckboxListTile(
                title: Text('Trip'),
                value: _selectedPreferences.contains('trip'),
                onChanged: (value) {
                  setState(() {
                    if (value!) {
                      _selectedPreferences.add('trip');
                    } else {
                      _selectedPreferences.remove('trip');
                    }
                  });
                },
              ),
              CheckboxListTile(
                title: Text('Sport'),
                value: _selectedPreferences.contains('sport'),
                onChanged: (value) {
                  setState(() {
                    if (value!) {
                      _selectedPreferences.add('sport');
                    } else {
                      _selectedPreferences.remove('sport');
                    }
                  });
                },
              ),
              CheckboxListTile(
                title: Text('Game'),
                value: _selectedPreferences.contains('game'),
                onChanged: (value) {
                  setState(() {
                    if (value!) {
                      _selectedPreferences.add('game');
                    } else {
                      _selectedPreferences.remove('game');
                    }
                  });
                },
              ),
              CheckboxListTile(
                title: Text('Others'),
                value: _selectedPreferences.contains('others'),
                onChanged: (value) {
                  setState(() {
                    if (value!) {
                      _selectedPreferences.add('others');
                    } else {
                      _selectedPreferences.remove('others');
                    }
                  });
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}