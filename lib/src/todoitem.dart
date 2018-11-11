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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      print('this time: ${widget.toDo.time}');
      _todo = widget.toDo;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Container(
//        decoration: BoxDecoration(
//          gradient: LinearGradient(colors: [Colors.blue, Colors.lightBlueAccent])
//        ),
        margin: _cardTop(),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              gradient:
                  LinearGradient(colors: [_cardColor(_todo.toDoStatus).startColor, _cardColor(_todo.toDoStatus).endColor]),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey,
                    blurRadius: 3.0,
                    offset: Offset(0.0, 3.0))
              ]),
//          elevation: 5.0,
//          color: Colors.blue,
//          shape: RoundedRectangleBorder(
//            borderRadius: BorderRadius.all(Radius.circular(5.0))
//          ),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 8.0, left: 8.0),
                    child: Text(
                      _dateFormat(_todo.time),
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black54,
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
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600),
                    ),
                    Container(
                      child: Text(
                        _todo.text,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.black,
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
      ),
    );
  }

  _dateFormat(int time) {
    return new DateFormat("yyyy:MM:dd:hh:mm:ss")
        .format(DateTime.fromMillisecondsSinceEpoch(time));
  }

  _cardTop() {
    return EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0);
  }

  CardBgColors _cardColor(ToDoStatus state) {
    CardBgColors colors;
    switch (state) {
      case ToDoStatus.NO:
        colors = CardBgColors(Colors.blue, Colors.lightBlue);
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


class CardBgColors {
  Color startColor;
  Color endColor;

  CardBgColors(this.startColor, this.endColor);


}

//TextField(
//style: TextStyle(
//color: Colors.black26,
//),
//decoration: InputDecoration(
//border: InputBorder.none,
//hintText: "输入您的事项"
//),
//)
