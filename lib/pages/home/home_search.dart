import 'package:flutter/material.dart';
import '../../widgets/slide_right_route.dart';
import 'main_home_page.dart';
class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top: 50
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                right: 365
              ),
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.push(context, SlideRightRoute(page: HomePage()));
                },
              ),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Search',
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

