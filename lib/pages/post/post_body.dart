

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:invited/pages/post/post_page.dart';

import '../../widgets/big_txt.dart';
import '../../widgets/icon_and_text.dart';
import '../../widgets/small_txt.dart';

class PostBody extends StatefulWidget {
  final int? counter;
  final String tittle;
  final String position;
  final String date;
  final String people;
  final String budget;
  final String remark;

  const PostBody({
    Key? key,
    required this.tittle,
    required this.position,
    required this.date,
    required this.people,
    required this.budget,
    required this.remark,
    this.counter = 10,
  }) : super(key: key);

  @override
  State<PostBody> createState() => _PostPageState();
}

class _PostPageState extends State<PostBody> {
  get p1 => PostPage(
    tittle: 'tittle',
    position: "position",
    date: 'date',
    people: 'people',
    budget: 'budget',
    remark: "remark",
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 770,
          child: ListView.builder(
              itemCount: widget.counter,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                    bottom: 10,
                  ),
                  child: Column(
                    children: [
                      InkWell(
                        child: Container(
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 10,
                            ),
                            child: Column(
                              children: [
                                Center(
                                  child: BigText(
                                    text: "${widget.tittle}$index",
                                  ),
                                ),
                                Row(
                                  children: [
                                    const IconAndText(
                                        icon: Icons.location_on,
                                        text: "Position: ",
                                        iconColor: Colors.red),
                                    SmallText(text: "${widget.position}$index"),
                                    const SizedBox(
                                      height: 35,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const IconAndText(
                                        icon: Icons.date_range,
                                        text: "Date: ",
                                        iconColor: Colors.blue),
                                    SmallText(text: "${widget.date}$index"),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const IconAndText(
                                        icon: Icons.person,
                                        text: "Num of people: ",
                                        iconColor: Colors.green),
                                    SmallText(text: "${widget.people}$index"),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => p1,));
                        },
                      ),
                    ],
                  ),
                );
              }),
        ),
      ],
    );
  }
}
