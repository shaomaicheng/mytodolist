import 'package:flutter/material.dart';
import 'Todo.dart';
import 'todoitem.dart';

void main() => runApp(new MyApp());

createTodos() {
  List<ToDo> todos = List<ToDo>();
  todos.add(ToDo("写博客发文章", "关于架构的文章", ToDoStatus.NO, DateTime.now().millisecondsSinceEpoch));
  todos.add(ToDo("去健身", "做够半小时的有氧", ToDoStatus.NO, DateTime.now().millisecondsSinceEpoch));
  todos.add(ToDo("吃午饭", "点二十五块半的闷面", ToDoStatus.FINISH, DateTime.now().millisecondsSinceEpoch));
  todos.add(ToDo("去盒马鲜生", "买水果", ToDoStatus.NO, DateTime.now().millisecondsSinceEpoch));
  todos.add(ToDo("写flutter代码", "todolist的app啊", ToDoStatus.DOING, DateTime.now().millisecondsSinceEpoch));
  return todos;
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'ToDoList',
      theme: new ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: new MyHomePage(title: 'ToDoList', todos: createTodos(),),
//      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.todos}) : super(key: key);


  final String title;
  final List<ToDo> todos;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<ToDo> _todos;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _todos = widget.todos;
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(

        title: new Text(widget.title),
      ),
      body: new Center(
        child: ListView.builder(
          itemCount: _todos.length,
          itemBuilder: (context, index) {
            return ToDoItem(toDo: _todos[index],);
          },
        ),
      ),
    );
  }
}
