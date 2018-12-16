import 'package:flutter/material.dart';
import 'package:todolist/src/Todo.dart';
import 'package:todolist/src/add_todo.dart';
import 'package:todolist/src/logger.dart';
import 'package:todolist/src/todoitem.dart';


void main() => runApp(new MyApp());

createTodos() {
  List<ToDo> todos = List<ToDo>();
  todos.add(ToDo("写博客发文章", "关于架构的文章", ToDoStatus.NO,
      DateTime.now().millisecondsSinceEpoch));
  todos.add(ToDo(
      "去健身", "做够半小时的有氧", ToDoStatus.NO, DateTime.now().millisecondsSinceEpoch));
  todos.add(ToDo("吃午饭", "点二十五块半的闷面", ToDoStatus.FINISH,
      DateTime.now().millisecondsSinceEpoch));
  todos.add(ToDo(
      "去盒马鲜生", "买水果", ToDoStatus.NO, DateTime.now().millisecondsSinceEpoch));
  todos.add(ToDo("写flutter代码", "todolist的app啊", ToDoStatus.DOING,
      DateTime.now().millisecondsSinceEpoch));
  todos.add(ToDo("写Android代码", "ewt360的app啊", ToDoStatus.DOING,
      DateTime.now().millisecondsSinceEpoch));
  todos.add(ToDo("写golang代码", "ci啊", ToDoStatus.DOING,
      DateTime.now().millisecondsSinceEpoch));
  todos.add(ToDo("写音视频代码", "学习大鹏p7啊", ToDoStatus.DOING,
      DateTime.now().millisecondsSinceEpoch));
  todos.add(ToDo("写音视频代码", "学习大鹏p7啊", ToDoStatus.DOING,
      DateTime.now().millisecondsSinceEpoch));
  todos.add(ToDo("写音视频代码", "学习大鹏p7啊", ToDoStatus.DOING,
      DateTime.now().millisecondsSinceEpoch));
  todos.add(ToDo("写音视频代码", "学习大鹏p7啊", ToDoStatus.DOING,
      DateTime.now().millisecondsSinceEpoch));
  return todos;
}

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
        title: 'ToDoList',
        todos: createTodos(),
      ),
//      debugShowCheckedModeBanner: false,
//    showPerformanceOverlay: true,
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
        child: ListView.builder(
          itemCount: _todos.length,
          itemBuilder: (context, index) {
            return ToDoItem(
              toDo: _todos[index],
            );
          },
        ),
      ),
    );
  }

  _gotoAddTodo() {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => AddTodoWidget()
    ));
  }
}