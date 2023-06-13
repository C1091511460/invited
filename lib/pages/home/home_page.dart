import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:invited_project/pages/drawer/drawer_page.dart';
import 'package:invited_project/pages/home/post_detial_page.dart';
import 'package:invited_project/pages/search/item_search_page.dart';
import 'package:invited_project/widgets/api.dart';
import '../../widgets/securestorage.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  API api = API();
  final secureStorage = SecureStorage();
  String currentUser = "";
  String currentUserId = "";
  int currentPage = 1;
  int perPage = 10;
  List<dynamic> posts = [];
  bool isLoading = false;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    refreshPosts();
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


  void deletePost(int postId) {
    setState(() {
      posts.removeWhere((post) => post['id'] == postId);
      api.deletePost(postId);
    });
  }

  Future<void> fetchPosts() async {
    final userData = await SecureStorage().readUserData();
    currentUserId = userData!['user_id'] as String? ?? "";
    setState(() {
      isLoading = true;
    });

    if (currentPage == 1) {
      setState(() {
        posts.clear();
      });
    }

    final fetchedPosts = await api.fetchPosts(currentUserId, currentPage, perPage);

    setState(() {
      posts = fetchedPosts;
      isLoading = false;
    });
  }

  Future<void> getCurrentUser() async {
    final userData = await SecureStorage().readUserData();
    if (userData != null) {
      setState(() {
        currentUser = userData['name'] as String? ?? "";
      });
    }
  }

  Future<void> refreshPosts() async {
    setState(() {
      posts.clear();
    });
    currentPage = 1;
    await fetchPosts();
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
      body: RefreshIndicator(
        onRefresh: refreshPosts,
        child: Center(
          child: ListView.builder(
            itemCount: posts.length + 1,
            itemBuilder: (BuildContext context, int index) {
              if (index < posts.length) {
                final post = posts[index];
                final dateFormat = DateFormat('yyyy-MM-dd');
                final bool isCurrentUserAuthor = post['author'] == currentUser;

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
                          Row(
                            children: [
                              Expanded(
                                child: Text(post['title'], style: TextStyle(fontSize: 18.0)),
                              ),
                              if (isCurrentUserAuthor)
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {

                                      },
                                      icon: Icon(Icons.edit),
                                    ),
                                    SizedBox(width: 8.0),
                                    IconButton(
                                      onPressed: () {
                                        deletePost(post["id"]);
                                      },
                                      icon: Icon(Icons.delete),
                                    ),
                                  ],
                                ),
                            ],
                          ),
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
      ),
    );
  }
}