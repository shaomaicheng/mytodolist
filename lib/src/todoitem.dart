
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
        margin: _cardTop(),
        child: Card(
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0))
          ),
          child: Column(
            children: <Widget>[
              Row(children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 8.0,left: 8.0),
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
              ],),
              Container(
                child:Row(
                  children: <Widget>[
                    Text(
                      _todo.title,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                    Container(
                      child:Text(
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
                margin: EdgeInsets.only(left: 16.0,right: 16.0, bottom: 16.0, top: 8.0),
              )
            ],
          ),
        ),
      ),
    );
  }


  _dateFormat(int time) {
    return new DateFormat("yyyy:MM:dd:hh:mm:ss").format(
        DateTime.fromMillisecondsSinceEpoch(time)
    );
  }

  _cardTop() {
    return EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0);
  }

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