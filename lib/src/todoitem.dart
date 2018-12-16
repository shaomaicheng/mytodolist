import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'Todo.dart';

class ToDoItem extends StatefulWidget {
  ToDoItem({Key key, this.toDo}) : super(key: key);

  ToDo toDo;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ToDoItemState();
  }
}

class ToDoItemState extends State<ToDoItem> {
  ToDo _todo;
  TodoItemDetails _details;
  bool showDetails = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _todo = widget.toDo;
    });
    _details = TodoItemDetails(todo: _todo);
    showDetails = widget.toDo.showDetails;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Container(
        margin: _cardTop(),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              gradient: LinearGradient(colors: [
                _cardColor(_todo.toDoStatus).startColor,
                _cardColor(_todo.toDoStatus).endColor
              ]),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey,
                    blurRadius: 3.0,
                    offset: Offset(0.0, 3.0))
              ]),
          child: Column(
            children: <Widget>[
              // 点击把下面的详情部分收缩
              GestureDetector(
                onTap: () {
                },
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 8.0, left: 8.0),
                          child: Text(
//                            _dateFormat(_todo.time),
                            _todoStatus(_todo.toDoStatus),
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.white,
                              decoration: TextDecoration.none,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        )
                      ],
                    ),
                    Container(
                      child: Row(
                        children: <Widget>[
                          Text(
                            _todo.title,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600),
                          ),
                          Container(
                            child: Text(
                              _todo.text,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                              ),
                            ),
                            margin: EdgeInsets.only(left: 8.0),
                          )
                        ],
                      ),
                      margin: EdgeInsets.only(
                          left: 16.0, right: 16.0, bottom: 16.0, top: 8.0),
                    )
                  ],
                ),
              ),
              // 可以展开的部分
              Container(child: _details)
            ],
          ),
        ),
      ),
    );
  }

  _cardTop() {
    return EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0, bottom: 8.0);
  }

  CardBgColors _cardColor(ToDoStatus state) {
    CardBgColors colors;
    switch (state) {
      case ToDoStatus.NO:
        colors = CardBgColors(Colors.blueAccent, Colors.lightBlue);
        break;
      case ToDoStatus.DOING:
        colors = CardBgColors(Colors.deepOrange, Colors.amber);
        break;
      case ToDoStatus.FINISH:
        colors = CardBgColors(Colors.teal, Colors.lightGreenAccent);
        break;
      default:
        colors = CardBgColors(Colors.grey, Colors.white);
        break;
    }
    return colors;
  }
}

_dateFormat(int time) {
  return new DateFormat("yyyy:MM:dd:hh:mm:ss")
      .format(DateTime.fromMillisecondsSinceEpoch(time));
}

_todoStatus(ToDoStatus status) {
  switch (status) {
    case ToDoStatus.NO:
      return "还没开始";
    case ToDoStatus.DOING:
      return "正在进行";
    case ToDoStatus.FINISH:
      return "已完成";
  }
}

class TodoItemDetails extends StatefulWidget {
  _TodoItemDetailsState _state;

  ToDo todo;

  TodoItemDetails({Key key, this.todo}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    _state = _TodoItemDetailsState();
    return _state;
  }
}

class _TodoItemDetailsState extends State<TodoItemDetails> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Container(
        child: ConstrainedBox(
          constraints: BoxConstraints(minWidth: 0.0, minHeight: 0.0),
          child: Container(
            alignment: AlignmentDirectional.topStart,
            margin: EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 16.0, top: 8.0),
                  child: Text(
                    "创建时间：" + _dateFormat(widget.todo.time),
                    softWrap: false,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
    );
  }
}

class CardBgColors {
  Color startColor;
  Color endColor;

  CardBgColors(this.startColor, this.endColor);
}
