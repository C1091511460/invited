import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:invited_project/pages/drawer/drawer_page.dart';
import 'package:invited_project/pages/home/post_page.dart';
import '../../data/page_data.dart';
import '../../widgets/big_txt.dart';
import '../../widgets/icon_and_text.dart';
import '../../widgets/small_txt.dart';
import '../search/search_delegate.dart';

class HomePage extends StatefulWidget {

  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Map<String, dynamic>> _journals = [];

  bool _isLoading = true;


  void _refreshJournals() async {
    final data = await SQLHelper.getItems();
    setState(() {
      _journals = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshJournals();
  }

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();
  final TextEditingController _dateController =  TextEditingController();
  final TextEditingController _peopleController =  TextEditingController();
  final TextEditingController _budgetController =  TextEditingController();
  final TextEditingController _remarkController =  TextEditingController();
  String dropdownValue = 'trip';


  void _showForm(int? id) async {
    if (id != null) {

      final existingJournal =
      _journals.firstWhere((element) => element['id'] == id);
      _titleController.text = existingJournal['title'];
      _positionController.text = existingJournal['position'];
      _dateController.text = existingJournal['date'];
      _peopleController.text = existingJournal['people'];
      _budgetController.text = existingJournal['budget'];
      _remarkController.text = existingJournal['remark'];
    }



    showModalBottomSheet(
        context: context,
        elevation: 5,
        isScrollControlled: true,
        builder: (_) =>
            Container(
              padding: EdgeInsets.only(
                top: 15,
                left: 15,
                right: 15,

                bottom: MediaQuery
                    .of(context)
                    .viewInsets
                    .bottom + 120,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(hintText: 'Title'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                DropdownButton<String>(
                  value: dropdownValue,
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                  items: <String>['trip', 'sport', 'game', 'others']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                  TextField(
                    controller: _positionController,
                    decoration: const InputDecoration(hintText: 'Position'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: _dateController,
                    decoration: const InputDecoration(hintText: 'Date'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: _peopleController,
                    decoration: const InputDecoration(hintText: 'Num of People'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: _budgetController,
                    decoration: const InputDecoration(hintText: 'Budget'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: _remarkController,
                    decoration: const InputDecoration(hintText: 'Remark'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      // Save new journal
                      if (id == null) {
                        await _addItem();
                      }

                      if (id != null) {
                        await _updateItem(id);
                      }

                      // Clear the text fields
                      _titleController.text = '';
                      _positionController.text = '';
                      _dateController.text = '';
                      _peopleController.text = '';
                      _budgetController.text = '';
                      _remarkController.text = '';


                      Navigator.of(context).pop();
                    },
                    child: Text(id == null ? 'Create New' : 'Update'),
                  )
                ],
              ),
            ));
  }


  Future<void> _addItem() async {
    await SQLHelper.createItem(
        _titleController.text,dropdownValue, _positionController.text, _dateController.text, _peopleController.text, _budgetController.text, _remarkController.text);
    _refreshJournals();
  }


  Future<void> _updateItem(int id) async {
    await SQLHelper.updateItem(
        id, _titleController.text, dropdownValue, _positionController.text, _dateController.text, _peopleController.text, _budgetController.text, _remarkController.text);
    _refreshJournals();
  }


  void _deleteItem(int id) async {
    await SQLHelper.deleteItem(id);
    _refreshJournals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invited'),
        actions: [
          IconButton(
            icon: Icon(Icons.search_rounded,size: 30,),
            onPressed: () { 
              showSearch(
                  context: context,
                  delegate: ItemSearchDelegate(),);
            },
          )],
      ),
      drawer: Drawer(
          child: DrawerPage()
      ),
      body: _isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        itemCount: _journals.length,
        itemBuilder: (context, index) =>
            Stack(
              children: [
                Container(
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
                            child: Stack(
                              children: [
                                Column(
                                  children: [
                                    Center(
                                      child: BigText(
                                        text: _journals[index]['title'],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        const IconAndText(
                                            icon: Icons.location_on,
                                            text: "Position: ",
                                            iconColor: Colors.red),
                                        SmallText(text: _journals[index]['position'],),
                                        SizedBox(height: 30,)
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const IconAndText(
                                            icon: Icons.date_range,
                                            text: "Date: ",
                                            iconColor: Colors.blue),
                                        SmallText(text: _journals[index]['date'],),
                                        SizedBox(height: 30,)
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const IconAndText(
                                            icon: Icons.money_off,
                                            text: "Budget: ",
                                            iconColor: Colors.orange),
                                        SmallText(text: _journals[index]['budget'],),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>
                              PostPage(
                                  tittle: _journals[index]['title'],
                                  position: _journals[index]['position'],
                                  date: _journals[index]['date'],
                                  people:  _journals[index]['people'],
                                  budget:  _journals[index]['budget'],
                                  remark:  _journals[index]['remark'],
                              )
                          )
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: 100,
                    left: 310,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _showForm(_journals[index]['id']),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () =>
                            _deleteItem(_journals[index]['id']),
                      ),
                    ],
                  ),
                ),
              ],
            ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _showForm(null),
      ),
    );
  }
}