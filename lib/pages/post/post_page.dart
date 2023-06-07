import 'package:flutter/material.dart';
import 'package:invited_project/widgets/api.dart';
import 'package:intl/intl.dart';
import '../../widgets/securestorage.dart';

class PostPage extends StatefulWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final secureStorage = SecureStorage();
  API api = API();
  final titleController = TextEditingController();
  String dropdownValue = 'Trip';
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final budgetController = TextEditingController();
  final locationController = TextEditingController();
  final contentController = TextEditingController();

  Future<void> createPost() async {
    final userData = await secureStorage.readUserData();
    String title = titleController.text;
    String type = dropdownValue;
    String date = dateController.text;;
    String time = timeController.text;
    String budget = budgetController.text;
    String location = locationController.text;
    String content = contentController.text;
    String author = userData!['name'] ?? '';

    var response = await api.createPost(
        title, type, date, time, budget, location, content, author);
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('文章新增成功'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('文章新增失敗'),
        ),
      );
    }

    titleController.clear();
    dateController.clear();
    timeController.clear();
    budgetController.clear();
    locationController.clear();
    contentController.clear();
  }

  Future<void> selectDate() async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
      setState(() {
        dateController.text = formattedDate;
      });
    }
  }

  Future<void> selectTime() async {
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime != null) {
      setState(() {
        timeController.text = selectedTime.format(context);
      });
    }
  }

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
              items: <String>['Trip', 'Sport', 'Game']
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
                    controller: dateController,
                    onTap: selectDate,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: GestureDetector(
                    onTap: selectTime,
                    child: AbsorbPointer(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Time',
                        ),
                        controller: timeController,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                hintText: 'Budget',
              ),
              controller: budgetController,
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                hintText: 'Location',
              ),
              controller: locationController,
            ),
            SizedBox(height: 16),
            TextField(
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                hintText: 'Post Content',
              ),
              controller: contentController,
            ),
            SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: createPost,
                child: Text('Create Post'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
