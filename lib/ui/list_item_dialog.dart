import 'package:flutter/material.dart';
import 'package:notelists/util/dbhelper.dart';
import '../models/list_items.dart';

class ListItemDialog {
  final textName = TextEditingController();
  final textQuantity = TextEditingController();
  final textNote = TextEditingController();

  Widget buildDialog( BuildContext context, ListItem item, bool isNew){
    DbHelper helper = DbHelper();
    if(isNew){
      textName.text = item.name;
      textQuantity.text = item.quantity;
      textNote.text = item.note;
    }

    return AlertDialog(
      title: Text((isNew) ? 'New shopping item' : 'Edit shopping item'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: textName,
              decoration: InputDecoration(
                hintText: 'Enter Item',
              ),
            ),
            TextField(
              controller: textQuantity,
              decoration: InputDecoration(
                hintText: 'Quantity',
              ),
            ),
            TextField(
              controller: textNote,
              decoration: InputDecoration(
                hintText: 'Note',
              ),
            ),
            RaisedButton(
              child: Text('Save Shopping Item'),
              onPressed: (){
                item.name = textName.text;
                item.note = textNote.text;
                item.quantity = textQuantity. text;
                helper.insertItem(item);
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