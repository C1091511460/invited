import 'package:flutter/material.dart';

class ItemSearchDelegate extends SearchDelegate{
  List<String> searchTerms = [
    'Apple',
    'Banana',
    'Pear',
    'Watermelons',
    'Orange',
    'Blueberries',
    'Raspberries',
  ];

  @override
  List<Widget> buildActions(BuildContext context){
    return[
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: (){
            query = '';
          },)
    ];
  }

  @override
  Widget buildLeading(BuildContext context){
    return IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: (){
          close(context, null);
        },);
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for(var fruit in searchTerms){
      if (fruit.toLowerCase().contains(query.toLowerCase())){
        matchQuery.add(fruit);
      }
    }
    return  ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          return ListTile(
            title: Text(result),
          );
        },
      );
    }


  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for(var fruit in searchTerms){
      if (fruit.toLowerCase().contains(query.toLowerCase())){
        matchQuery.add(fruit);
      }
    }
    return  ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }
}