import 'package:flutter/material.dart';
import 'package:notelists/models/list_items.dart';
import 'package:notelists/ui/items_screen.dart';
import 'package:notelists/util/dbhelper.dart';
import './models/shopping_list.dart';
import './ui/shopping_list_dialog.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  final ShoppingListDialog dialog = ShoppingListDialog();
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Note lists',
      home: ShList(),
    );
  }
}
class ShList extends StatefulWidget {
  @override
  _ShListState createState() => _ShListState();
}

class _ShListState extends State<ShList> {
  DbHelper helper = DbHelper();
  List<ShoppingList> shoppingList;
  ShoppingListDialog dialog;

  @override
  void initState(){
    dialog = ShoppingListDialog();
    super.initState();
  }

  Future showData() async {
    await helper.openDb();
    shoppingList = await helper.getLists();
    setState(() {
      shoppingList = shoppingList;
    });
  }


  @override
  Widget build(BuildContext context) {

    showData();
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping List'),),
      body: ListView.builder(
        itemCount: (shoppingList != null)? shoppingList.length : 0,
        itemBuilder: (BuildContext context, int index){
          return Dismissible(
            key: Key(shoppingList[index].name),
            onDismissed: (direction){
              String stringName = shoppingList[index].name;
              helper.deleteList(shoppingList[index]);
              setState(() {
                shoppingList.removeAt(index);
              });
              Scaffold
                  .of(context)
                  .showSnackBar(SnackBar(content: Text("$stringName deleted"),),);
            },
            child: ListTile(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        ItemScreen(shoppingList: shoppingList[index],),),);
              },
              leading: CircleAvatar(
                child: Text(
                  shoppingList[index].priority.toString(),
                ),
              ),
              title: Text(shoppingList[index].name),
              trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: (){
                    showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          dialog.buildDialog(
                              context, shoppingList[index], false),

                    );
                  }
                  ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showDialog(
            context: context,
            builder: (BuildContext context) =>
                dialog.buildDialog(context, ShoppingList(id: 0,name: '',priority: 0), true),

          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.pink,
      ),
    );

  }

}
