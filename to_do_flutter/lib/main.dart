import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TODO APP',
      theme: new ThemeData(primaryColor: Color.fromRGBO(58, 66, 86, 1.0)),
      home: new ToDoList(),
    );
  }
}

class ToDoList extends StatefulWidget{
  @override
  State createState() => new ToDoListState();
}

class ToDoListState extends State<ToDoList>{
  List<String> _todoItems = [];
  
  void _addToDoItem(String task){
    if(task.length > 0){
      setState(() {
        _todoItems.add(task);
      });
    }
  }

  Widget _buildToDoList(){
    return new ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (context, index){
        if(index.isOdd){
          return new Divider();
        }
        if(index < _todoItems.length){
          return _buildTodoItem(_todoItems[index]);
        }
      },
    );
  }

  Widget _buildTodoItem(String todoText) {
    return new Card(
        elevation: 8.0,
        margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
        child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            leading: Container(
              padding: EdgeInsets.only(right: 12.0),
              decoration: new BoxDecoration(
                  border: new Border(
                      right: new BorderSide(width: 1.0, color: Colors.white24))),
              child: Icon(Icons.autorenew, color: Colors.white),
            ),
            title: Text(
              todoText,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),
            subtitle: Row(
              children: <Widget>[
                Icon(Icons.linear_scale, color: Colors.yellowAccent),
                Text(" Intermediate", style: TextStyle(color: Colors.white))
              ],
            ),
            trailing: Icon(
                Icons.keyboard_arrow_right, color: Colors.white, size: 30.0
            )
        )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: topAppBar,
      body: _buildToDoList(),
      floatingActionButton: new FloatingActionButton(
        onPressed: _pushAddToDoScreen,
        tooltip: 'Add task',
        child: new Icon(Icons.add)
      ),
    );
  }
  
  void _pushAddToDoScreen(){
    Navigator.of(context).push(
      new MaterialPageRoute(builder: (context){
          return new Scaffold(
            appBar: topAppBar,
            body: new TextField(
              autofocus: true,
              onSubmitted: (val){
                _addToDoItem(val);
                Navigator.pop(context);
              },
              decoration: new InputDecoration(
                hintText: "Enter something to do...",
                contentPadding: const EdgeInsets.all(16.0)
              ),
            ),
          );
        }
      )
    );
  }
}

final topAppBar = AppBar(
  elevation: 0.1,
  backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
  title: Text("TODO"),
  actions: <Widget>[
    IconButton(
      icon: Icon(Icons.list),
      onPressed: () {},
    )
  ],
);