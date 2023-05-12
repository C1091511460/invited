import 'package:flutter/material.dart';

class PostPage extends StatefulWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final titleController = TextEditingController();
  String dropdownValue = 'Trip';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Post'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Title',
              ),
              controller: titleController,
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: dropdownValue,
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
              decoration: InputDecoration(
                labelText: 'Type',
              ),
              items: <String>['Trip', 'Sport', 'Game', 'Others']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Date',
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Time',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                hintText: 'Author',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                hintText: 'Budget',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                hintText: 'Location',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                hintText: 'Post Content',
              ),
            ),
            SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                child: Text('Create Post'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}