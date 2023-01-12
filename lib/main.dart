import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:invited/pages/home/main_home_page.dart';

Future<void> main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());

}
class MyApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
