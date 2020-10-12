import 'package:flutter/material.dart';
import 'package:notelists/models/shopping_list.dart';
import '../models/list_items.dart';
import '../models/list_items.dart';
import '../util/dbhelper.dart';

class ItemScreen extends StatefulWidget {
 final ShoppingList shoppingList;
 ItemScreen({this.shoppingList});

  @override
  _ItemScreenState createState() => _ItemScreenState(shoppingList: this.shoppingList);
}

class _ItemScreenState extends State<ItemScreen> {
 final ShoppingList shoppingList;
 _ItemScreenState({this.shoppingList});

 DbHelper helper;
 List<ListItem> items;



 Future showData(int idList) async{
   await helper.openDb();
   items = await helper.getItems(idList);
   setState(() {
     items = items;
   });

 }

  @override
  Widget build(BuildContext context) {
    helper = DbHelper();
    showData(this.shoppingList.id);
    return Scaffold(
      appBar: AppBar(
        title: Text(shoppingList.name),
      ),
      body: ListView.builder(
        itemCount:(items != null) ? items.length : 0,
        itemBuilder: (BuildContext context, int index){
          return ListTile(
            title: Text(items[index].name),
            subtitle: Text("Quantity: ${items[index].quantity} - Note: ${items[index].note}"),
            onTap: (){},
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: (){},
            ),
          );
        },
      ),
    );
  }
}
