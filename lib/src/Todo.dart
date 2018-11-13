class ToDo {
  String title;
  String text;
  ToDoStatus toDoStatus;
  int time;

  // 本地 ui 相关 数据

  bool showDetails = false;

  ToDo(this.title, this.text, this.toDoStatus, this.time);
}

enum ToDoStatus { NO, DOING, FINISH }
