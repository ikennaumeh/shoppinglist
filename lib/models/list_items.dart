class ListItem{
  int id, idList;
  String name, quantity, note;

  ListItem({this.id, this.idList, this.name, this.note, this.quantity});

  Map<String, dynamic> toMap(){
    return {
      'id':(id == 0) ? null : id,
      'idList': idList,
      'name': name,
      'quantity': quantity,
      'note': note,
    };
  }
}