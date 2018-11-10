

class ToDo {
  String title;
  String text;
  ToDoStatus toDoStatus;
  int time;

  ToDo(this.title, this.text, this.toDoStatus, this.time);
}


enum ToDoStatus {
  NO,
  WAITING,
  DOING,
  FINISH
}