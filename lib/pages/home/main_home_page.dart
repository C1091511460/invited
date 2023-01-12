import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../utils/colors.dart';
import '../../widgets/big_txt.dart';
import '../../widgets/slide_right_route.dart';
import '../post/input_post_page.dart';
import '../post/post_body.dart';
import 'home_search.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  get p1 => PostBody(
    tittle: 'tittle',
    position: "position",
    date: 'date',
    people: 'people',
    budget: 'budget',
    remark: "remark",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(

        children: [
          Positioned(
            top: -50,
            left: 0,
            right: 0,
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0),
                  color: Colors.white),
              padding: const EdgeInsets.only(
                  top: 85,
                  right: 30,
                  left: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BigText(
                    text: "Invited",
                    color: AppColors.homegreen,
                    size: 30,
                  ),
                  Center(
                    child: Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: AppColors.homegreen),
                      child: IconButton(
                        icon: Icon(Icons.search),
                        iconSize: 30,
                        color: Colors.white,
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage()));
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: 70,
              width: 430,
              margin: const EdgeInsets.only(bottom: 0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0), color: Colors.white),
              child: Container(
                padding: const EdgeInsets.only(left: 50, right: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.home),
                      iconSize: 40,
                      onPressed: () {
                        Navigator.push(context, SlideRightRoute(page: HomePage()));
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      iconSize: 40,
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => InputPostPage()));
                      },
                    ),

                    IconButton(
                      icon: Icon(Icons.mail_sharp),
                      iconSize: 40,
                      onPressed: () {
                        print("object");
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 100,
            left: 0,
            right: 0,
            child: Container(
              decoration:
              BoxDecoration(
                borderRadius: BorderRadius.circular(0),
              ),

              child: p1,
            ),
          ),
        ],
      ),
    );
  }
}
