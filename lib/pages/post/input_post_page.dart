



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/slide_right_route.dart';
import '../../widgets/small_txt.dart';
import '../home/main_home_page.dart';

class InputPostPage extends StatefulWidget {
  const InputPostPage({Key? key}) : super(key: key);

  @override
  State<InputPostPage> createState() => _InputPostPageState();
}

class _InputPostPageState extends State<InputPostPage> {
  TextEditingController tittleController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController peopleController = TextEditingController();
  TextEditingController budgetController = TextEditingController();
  TextEditingController remarkController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
              top: 50,
            ),
            width: 430,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(0),
            ),
            child: Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Navigator.push(context, SlideRightRoute(page: HomePage()));
                    },
                  ),
                  InkWell(
                    child: SmallText(
                      text: "Post",
                      size: 25,
                      color: Colors.blue,
                    ),
                  )
                ],
              ),
            ),
          ),
          TextField(
            controller: tittleController,
            decoration: InputDecoration(
              labelText: 'Tittle',
              hintText: 'Tittle',
              prefixIcon: Icon(Icons.add_box),
            ),
          ),
          TextField(
            controller: positionController,
            decoration: InputDecoration(
              labelText: 'Position',
              hintText: 'Position',
              prefixIcon: Icon(Icons.location_on),
            ),
          ),
          TextField(
            controller: dateController,
            decoration: InputDecoration(
              labelText: 'date',
              hintText: 'date',
              prefixIcon: Icon(Icons.date_range),
            ),
          ),
          TextField(
            controller: peopleController,
            decoration: InputDecoration(
              labelText: 'Num of People',
              hintText: 'Num of People',
              prefixIcon: Icon(Icons.people),
            ),
          ),
          TextField(
            controller: budgetController,
            decoration: InputDecoration(
              labelText: 'Budget',
              hintText: 'Budget',
              prefixIcon: Icon(Icons.attach_money),
            ),
          ),
          TextField(
            controller: remarkController,
            decoration: InputDecoration(
              labelText: 'Remark',
              hintText: 'Remark',
              prefixIcon: Icon(Icons.r_mobiledata),
            ),
          ),
        ],
      ),
    );
  }
}
