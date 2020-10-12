import 'package:flutter/material.dart';
import 'package:notelists/models/list_items.dart';
import 'package:notelists/ui/items_screen.dart';
import 'package:notelists/util/dbhelper.dart';
import './models/shopping_list.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Note lists',
      home: Scaffold(
        appBar: AppBar(title: Text('Shopping List'),),
        body: ShList(),
      ),
    );
  }
}
class ShList extends StatefulWidget {
  @override
  _ShListState createState() => _ShListState();
}

class _ShListState extends State<ShList> {
  DbHelper helper;

  List<ShoppingList> shoppingList;

  Future showData() async {
    await helper.openDb();
    shoppingList = await helper.getLists();
    setState(() {
      shoppingList = shoppingList;
    });
  }


  @override
  Widget build(BuildContext context) {
    helper = DbHelper();


    showData();
    return ListView.builder(
      itemCount: (shoppingList != null)? shoppingList.length : 0,
      itemBuilder: (BuildContext context, int index){
        return ListTile(
          onTap: (){
            Navigator.push(context,
              MaterialPageRoute(builder: (_) => ItemScreen(shoppingList: shoppingList[index],),),);
          },
          leading: CircleAvatar(
            child: Text(
              shoppingList[index].priority.toString(),
            ),
          ),
          title: Text(shoppingList[index].name),
          trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: (){}
              ),
        );
      },
    );

  }

}
