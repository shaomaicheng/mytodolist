import 'package:sqflite/sqflite.dart';

final String tableTodo = 'table_todo';
final String columnId = '_id';
final String columnTitle = '_title';
final String columnText = '_text';
final String columnToDoStatus = '_todoStatus';
final String columnTime = '_time';

class ToDo {
  int id;
  String title;
  String text;
  ToDoStatus toDoStatus;
  int time;

  // 本地 ui 相关 数据

  ToDo(this.title, this.text, this.toDoStatus, this.time, {this.id});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnId: id,
      columnTitle: title,
      columnText: text,
      columnToDoStatus: toDoStatus.index,
      columnTime: time
    };

    if (id != null) {
      map[columnId] = id;
    }

    return map;
  }


  ToDo.fromMap(Map<String, dynamic> map) {
    id = map['$columnId'];
    title = map['$columnTitle'];
    text = map['$columnText'];
    toDoStatus = _todoStatus(map['$columnToDoStatus']);
    time = map['$columnTime'];
  }

  _todoStatus(int status) {
   ToDoStatus todoStatus = ToDoStatus.NO;
    switch (status) {
      case 0:
        todoStatus = ToDoStatus.NO;
        break;
      case 1:
        todoStatus = ToDoStatus.DOING;
        break;
      case 2:
        todoStatus = ToDoStatus.FINISH;
        break;
      default:
        break;
    }
    return todoStatus;
  }
}

enum ToDoStatus { NO, DOING, FINISH }

class TodoProvider {
  Database db;

  factory TodoProvider() => _getInstance();
  static TodoProvider get instance => _getInstance();

  static TodoProvider _instance;
  TodoProvider._internal();

  static TodoProvider _getInstance() {
    if (_instance == null) {
      _instance = TodoProvider._internal();
    }
    return _instance;
  }

  Future open(String path) async {
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
            create table $tableTodo ( 
              $columnId integer primary key autoincrement, 
              $columnTitle text not null,
              $columnText text not null,
              $columnToDoStatus integer not null,
              $columnTime bigint not null
              )
          ''');
    });
  }

  Future<ToDo> insert(ToDo todo) async {
    todo.id = await db.insert(tableTodo, todo.toMap());
    return todo;
  }

  Future<ToDo> getTodo(int id) async {
    List<Map> maps = await db.query(tableTodo,
        columns: [
          columnId,
          columnTitle,
          columnText,
          columnToDoStatus,
          columnTime
        ],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return ToDo.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<List<ToDo>> getTodos() async {
    List<Map> maps = await db.query(tableTodo,
        columns: [
          columnId,
          columnTitle,
          columnText,
          columnToDoStatus,
          columnTime
        ],
        orderBy: '$columnTime desc');
    if (maps.length == 0) {
      return List<ToDo>();
    } else {
      return maps.map((item) {
        return ToDo.fromMap(item);
      }).toList();
    }
  }
}
