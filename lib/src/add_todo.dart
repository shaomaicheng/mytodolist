import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:todolist/src/Todo.dart';
import 'package:todolist/src/events.dart';

class AddTodoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('添加一条Todo'),
      ),
      body: Container(
        child: _AddTodoWidget(),
      ),
    );
  }
}

class _AddTodoWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddTodoState();
  }
}

class _AddTodoState extends State<_AddTodoWidget> {
  String _title = '';
  String _content = '';
  GlobalKey _formKey = new GlobalKey<FormState>();

  _addTodoItem(BuildContext context) {
    if ((_formKey.currentState as FormState).validate()) {
      var todo = ToDo(_title, _content, ToDoStatus.NO,
          DateTime.now().millisecondsSinceEpoch);
      TodoProvider().insert(todo).then((todo) {
        Scaffold.of(context).showSnackBar(SnackBar(content: Text('添加成功')));
        EventBus eventBus = EventBusManager.instance.eventBus();
        eventBus.fire(AddItemSuccessEvent(todo));
      }, onError: () {
        Scaffold.of(context).showSnackBar(SnackBar(content: Text('添加失败')));
      }).whenComplete(() {
        Future.delayed(Duration(seconds: 1), () {
          Navigator.of(context).pop();
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SingleChildScrollView(
      child: Container(
          margin: EdgeInsets.only(top: 16.0),
          child: Form(
            autovalidate: true,
            key: _formKey,
            child: Column(
              children: <Widget>[
                EditWithTipsWidget('标题', '请输入标题', (value) {
                  _title = value;
                  return value.trim().length > 0 ? null : '请输入标题';
                }),
                EditWithTipsWidget(
                  '详细描述',
                  '请输入详细描述',
                  (value) {
                    _content = value;
                    return value.trim().length > 0 ? null : '请输入详细描述';
                  },
                  isTextArea: true,
                ),
                GestureDetector(
                  onTap: () {
                    _addTodoItem(context);
                  },
                  child: Container(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          '添加',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 18.0),
                        ),
                      ),
                      margin:
                          EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
                      height: 44.0,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.deepOrange,
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          shape: BoxShape.rectangle,
                          border: Border.all(color: Colors.deepOrange))),
                ),
              ],
            ),
          )),
    ));
  }
}

class EditWithTipsWidget extends StatefulWidget {
  String tips;
  String hintText;
  bool isTextArea = false;
  final FormFieldValidator formFieldValidator;
  _EditWithTipsState _state;

  EditWithTipsWidget(this.tips, this.hintText, this.formFieldValidator,
      {Key key, this.isTextArea})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    _state = new _EditWithTipsState();
    return _state;
  }
}

class _EditWithTipsState extends State<EditWithTipsWidget> {
  String _inputContent;

  @override
  Widget build(BuildContext context) {
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
              child: TextFormField(
                maxLines: _maxLines(),
                decoration: InputDecoration(
                    hintText: widget.hintText, border: OutlineInputBorder()),
                style: TextStyle(color: Colors.black),
                validator: widget.formFieldValidator,
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
