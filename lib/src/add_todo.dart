import 'package:flutter/material.dart';
import 'package:todolist/src/Todo.dart';

class AddTodoWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AddTodoState();
  }
}

class _AddTodoState extends State<AddTodoWidget> {

  String _title = '';
  String _content = '';

  _addTodoItem() {
    var todo = ToDo(_title, _content, ToDoStatus.NO, DateTime.now().millisecondsSinceEpoch);
    TodoProvider().insert(todo);
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('添加一条Todo'),
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(top: 16.0),
              child: Column(
                children: <Widget>[
                  EditWithTipsWidget('标题', '请输入标题', (value){_title=value;}),
                  EditWithTipsWidget(
                    '详细描述',
                    '请输入详细描述',
                        (value){_content = value;},
                    isTextArea: true,
                  ),
                  GestureDetector(
                    onTap: () {
                      _addTodoItem();
                    },
                    child: Container(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            '添加',
                            textAlign: TextAlign.center,
                            style:
                            TextStyle(color: Colors.white, fontSize: 18.0),
                          ),
                        ),
                        margin: EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 16.0),
                        height: 44.0,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.deepOrange,
                            borderRadius:
                            BorderRadius.all(Radius.circular(4.0)),
                            shape: BoxShape.rectangle,
                            border: Border.all(color: Colors.deepOrange))),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

}


class EditWithTipsWidget extends StatefulWidget {
  String tips;
  String hintText;
  final ValueChanged<String> valueChanged;
  bool isTextArea = false;
  _EditWithTipsState _state;

  EditWithTipsWidget(this.tips, this.hintText, this.valueChanged, {Key key, this.isTextArea})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    _state = new _EditWithTipsState();
    // TODO: implement createState
    return _state;
  }
}

class _EditWithTipsState extends State<EditWithTipsWidget> {
  String _inputContent;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(top: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 8.0, left: 8.0),
            child: Text(
              widget.tips,
              style: TextStyle(fontSize: 14.0, color: Colors.black),
            ),
          ),
          Container(
              margin: EdgeInsets.only(left: 16.0, top: 8.0, right: 8.0),
              child: TextField(
                maxLines: _maxLines(),
                decoration: InputDecoration(
                    hintText: widget.hintText, border: OutlineInputBorder()),
                style: TextStyle(color: Colors.black),
                onChanged: widget.valueChanged,
              )),
        ],
      ),
    );
  }

  int _maxLines() {
    if (widget.isTextArea == null) {
      return 1;
    }
    return widget.isTextArea ? 10 : 1;
  }
}
