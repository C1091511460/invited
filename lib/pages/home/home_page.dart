import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:invited_project/pages/drawer/drawer_page.dart';
import 'package:invited_project/pages/home/post_detial_page.dart';
import 'package:invited_project/pages/search/item_search_page.dart';
import 'package:invited_project/widgets/api.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  API api = API();
  int currentPage = 1;
  int perPage = 10;
  List<dynamic> posts = [];
  bool isLoading = false;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    fetchPosts();
    scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      currentPage += 1;
      fetchPosts();
    }
  }

  Future<void> fetchPosts() async {
    setState(() {
      isLoading = true;
    });

    final fetchedPosts = await api.fetchPosts(currentPage, perPage);

    setState(() {
      posts.addAll(fetchedPosts);
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Invited'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchPage()),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: DrawerPage(),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: posts.length + 1,
          itemBuilder: (BuildContext context, int index) {
            if (index < posts.length) {
              final post = posts[index];
              final dateFormat = DateFormat('yyyy-MM-dd');

              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PostDetailPage(post: post),
                    ),
                  );
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width - 20,
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(post['title'], style: TextStyle(fontSize: 18.0)),
                        SizedBox(height: 8.0),
                        Row(
                          children: [
                            Icon(Icons.category, size: 14.0),
                            SizedBox(width: 4.0),
                            Text('類型: ${post['type']}',
                                style: TextStyle(fontSize: 14.0)),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.date_range, size: 14.0),
                            SizedBox(width: 4.0),
                            Text(
                                '日期: ${dateFormat.format(DateTime.parse(post['date']))}',
                                style: TextStyle(fontSize: 14.0)),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.access_time, size: 14.0),
                            SizedBox(width: 4.0),
                            Text('時間: ${post['time']}',
                                style: TextStyle(fontSize: 14.0)),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.location_on, size: 14.0),
                            SizedBox(width: 4.0),
                            Text('地點: ${post['location']}',
                                style: TextStyle(fontSize: 14.0)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else if (isLoading) {
              return Center(child: CircularProgressIndicator());
            } else {
              return SizedBox();
            }
          },
          controller: scrollController,
        ),
      ),
    );
  }
}
