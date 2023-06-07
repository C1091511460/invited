import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:invited_project/tabs.dart';
import 'package:invited_project/widgets/api.dart';
import 'package:invited_project/widgets/gps.dart';
import 'package:invited_project/widgets/securestorage.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SecureStorage _secureStorage = SecureStorage();
  bool _isLoggedIn = false;
  final secureStorage = SecureStorage();
  API api = API();

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  void checkLoginStatus() async {
    bool isLoggedIn = await _secureStorage.isLoggedIn();
    setState(() {
      _isLoggedIn = isLoggedIn;
    });

    if (_isLoggedIn) {
      getLocation();
    }
  }

  void getLocation() async {
    try {
      await Future.delayed(Duration(milliseconds: 500));
      final userData = await secureStorage.readUserData();
      Position position = await GPS.getCurrentLocation();
      double latitude = position.latitude;
      double longitude = position.longitude;

      bool updateSuccess = false;
      int maxRetryCount = 3;
      int retryCount = 0;

      while (!updateSuccess && retryCount < maxRetryCount) {
        try {
          api.updateUserLocation(userData!["user_id"], latitude, longitude);
          updateSuccess = true;
        } catch (e) {
          print('更新用户位置信息失败: $e');
          retryCount++;
          await Future.delayed(Duration(seconds: 2));
        }
      }

      if (!updateSuccess) {
        print('無法更新用户位置信息，請稍後再式');
      }
    } catch (e) {
      print('獲取位置失敗: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Tabs(),
    );
  }
}
