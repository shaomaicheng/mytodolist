import 'package:flutter/material.dart';
import 'package:todolist/src/Todo.dart';
import 'package:todolist/src/add_todo.dart';
import 'package:todolist/src/logger.dart';
import 'package:todolist/src/todoitem.dart';


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  MyApp() {
    Logger().init(true);
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'ToDoList',
      theme: new ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: new MyHomePage(
        title: 'ToDoList'
      ),
//      debugShowCheckedModeBanner: false,
//    showPerformanceOverlay: true,
    );
  }
}

class MyHomePage extends StatefulWidget {

  final String title;
  
  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<ToDo> _todos;

  _loadTodos() async {
    List<ToDo> todos = List<ToDo>();
    await TodoProvider().open('path_todo');
    todos.addAll(await TodoProvider().getTodos());
    this.setState(() {
      this._todos = todos;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._todos = List();
    _loadTodos();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _gotoAddTodo();
        },
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        mini: false,
      ),
      body: new Container(
        child: _listView(),
      ),
    );
  }

  Widget _listView() {
    if (this._todos != null && this._todos.length > 0) {
        return ListView.builder(
          itemCount: _todos.length,
          itemBuilder: (context, index) {
            return ToDoItem(
              toDo: _todos[index],
            );
          },
        );
      } else {
        return Center(
          child: Text("暂时没有数据哦"),
        );
      }
  }

  _gotoAddTodo() {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => AddTodoWidget()
    ));
  }
}
