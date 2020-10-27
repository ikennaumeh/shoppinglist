import 'package:flutter/material.dart';
import '../util/dbhelper.dart';
import '../models/shopping_list.dart';

class ShoppingListDialog{
  final textName = TextEditingController();
  final textPriority = TextEditingController();

  Widget buildDialog(BuildContext context, ShoppingList list, bool isNew){
    DbHelper helper = DbHelper();
    if(!isNew){
      textName.text = list.name;
      textPriority.text = list.priority.toString();
    }
    return AlertDialog(
      title: Text((isNew) ? 'New shopping list' : 'Edit shopping list'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: textName,
              decoration: InputDecoration(
                hintText: 'Shopping List Name',
              ),
            ),
            TextField(
              controller: textPriority,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Shopping List Priority (1-3)',
              ),
            ),
            RaisedButton(
              child: Text('Save Shopping List'),
              onPressed: (){
                list.name = textName.text;
                list.priority = int.parse(textPriority.text);
                helper.insertList(list);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),

    );
  }
}