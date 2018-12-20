import 'package:sqflite/sqflite.dart';


 final String tableTodo = 'table_todo';
  final String columnId = '_id';
  final String columnTitle = 'title';
  final String columnText = 'text';
  final String columnToDoStatus = 'todoStatus';
  final String columnTime = 'time';


class ToDo {
  int id;
  String title;
  String text;
  ToDoStatus toDoStatus;
  int time;

  // 本地 ui 相关 数据

  ToDo(this.title, this.text, this.toDoStatus, this.time, {this.id});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic> {
      columnId: title,
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
    id = map[columnId];
    title = map[title];
    text= map[text];
    toDoStatus = map[toDoStatus];
    time = map[time];
  }
}

enum ToDoStatus { NO, DOING, FINISH }

class TodoProvider {
  Database db;

  Future open(String path) async {
    db = await openDatabase(path, version:1, 
      onCreate: (Database db, int version) async {
        await db.execute(
          '''
            create table $tableTodo ( 
              $columnId integer primary key autoincrement, 
              $columnTitle text not null,
              $columnText text not null,
              $columnToDoStatus integer not null,
              $columnTime bigint not null,
              )
          '''
        );
      }
    );
  }

  Future<ToDo> insert(ToDo todo) async {
    todo.id = await db.insert(tableTodo, todo.toMap());
    return todo;
  }

  Future<ToDo> getTodo(int id) async {
    List<Map> maps = await db.query(tableTodo,
      columns: [columnId, columnTitle, columnText, columnToDoStatus, columnTime],
      where: '$columnId = ?',
      whereArgs: [id]
    );
    if (maps.length > 0) {
      return ToDo.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<List<ToDo>> getTodos() async {
    List<Map> maps = await db.query(tableTodo,
      columns: [columnId, columnTitle, columnText, columnToDoStatus, columnTime],
      orderBy: '$columnTime desc'
    );
    return maps.expand((item) {
      ToDo.fromMap(item);
    }).toList();
  }
}