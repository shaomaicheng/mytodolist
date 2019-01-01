import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:todolist/src/todo.dart';
import 'package:todolist/src/add_todo.dart';
import 'package:todolist/src/events.dart';
import 'package:todolist/src/logger.dart';
import 'package:todolist/src/todo_item.dart';

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
      home: new MyHomePage(title: 'ToDoList'),
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

  _registerEvents() {
    EventBus eventBus = EventBusManager.instance.eventBus();
    eventBus.on<AddItemSuccessEvent>().listen((event) {
      setState(() {
        this._todos.insert(0, event.todo);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    this._todos = List();
    _registerEvents();
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

  // 删除提示
  _tipShowDelete(BuildContext buildContext, ToDo todo) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            content: Container(
              child: Text('是否删除这条记录?'),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('确定'),
                onPressed: () {
                  _delete(buildContext, todo);
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('取消'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  // 删除
  _delete(BuildContext context, ToDo todo) {
    TodoProvider().delete(todo).then((v) {
      setState(() {
        this._todos.remove(todo);
      });
      Scaffold.of(context).showSnackBar(SnackBar(content: Text('删除成功')));
    }).catchError(() {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text('删除失败')));
    });
  }

  Widget _listView() {
    if (this._todos != null && this._todos.length > 0) {
      return ListView.builder(
        itemCount: _todos.length,
        itemBuilder: (context, index) {
          return Dismissible(
            direction: DismissDirection.endToStart,
            background: Container(
                color: Colors.red,
                child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      margin: EdgeInsets.only(right: 24.0),
                      child: Text(
                        '删除',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                    ))),
            key: Key(_todos[index].hashCode.toString()),
            child: ToDoItem(
              toDo: _todos[index],
              gestureLongPressCallback: () {
                _tipShowDelete(context, _todos[index]);
              },
            ),
            onDismissed: (direction) {
              Scaffold.of(context)
                  .showSnackBar(SnackBar(content: Text('删除成功')));
              setState(() {
                this._todos.remove(_todos[index]);
              });
            },
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
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddTodoWidget()));
  }
}
