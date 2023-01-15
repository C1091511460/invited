import 'package:flutter/material.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_txt.dart';
import '../../widgets/expandable_text.dart';
import '../../widgets/icon_and_text.dart';
import '../../widgets/small_txt.dart';


class PostPage extends StatelessWidget {
  final String tittle;
  final String position;
  final String date;
  final String people;
  final String budget;
  final String remark;

  const PostPage(
      {Key? key,
      required this.tittle,
      required this.position,
      required this.date,
      required this.people,
      required this.budget,
      required this.remark})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: 100,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: Colors.white),
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
                top: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const IconAndText(
                          icon: Icons.location_on,
                          text: "Position: ",
                          iconColor: Colors.red),
                      SmallText(text: position),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const IconAndText(
                          icon: Icons.date_range,
                          text: "Date: ",
                          iconColor: Colors.blue),
                      SmallText(text: date),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const IconAndText(
                          icon: Icons.person,
                          text: "Num of people: ",
                          iconColor: Colors.green),
                      SmallText(text: people),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const IconAndText(
                          icon: Icons.money_off,
                          text: "Budget: ",
                          iconColor: Colors.orange),
                      SmallText(text: budget),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  BigText(
                    text: "Remark: ",
                    size: 30,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Expanded(child: SingleChildScrollView(child: ExpandableText(text: remark)))
                ],
              ),
            ),
          ),
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 670,
              child: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                    color: Colors.green),
                padding: const EdgeInsets.only(
                  left: 15,
                  right: 15,
                  top: 40,
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    Expanded(
                        child: Center(
                      child: BigText(text: tittle),
                    )),
                    const AppIcon(icon: Icons.ios_share),
                  ],
                ),
              )),
        ],
      ),
      bottomNavigationBar: Container(
        height: 150,
        padding: const EdgeInsets.only(
          top: 30,
          bottom: 30,
          left: 20,
          right: 20,
        ),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40)
            )
        ),
        child: Center(
          child: Container(
            padding: const EdgeInsets.only(
              top: 5,
              bottom: 5,
              left: 5,
              right: 5,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),),
            child: IconButton(
              icon: const Icon(Icons.mail_sharp),
              iconSize: 40,
              onPressed: () {  },
            ),
          ),
        ),
      ),
    );
  }
}