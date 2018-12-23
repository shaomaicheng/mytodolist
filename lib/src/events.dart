
import 'package:event_bus/event_bus.dart';
import 'package:todolist/src/Todo.dart';

class EventBusManager {
  EventBus _eventBus;

  eventBus() {
    if (_eventBus == null) {
      _eventBus = EventBus();
    }
    return _eventBus;
  }

  EventBusManager._internal();

  factory EventBusManager() => _getInstance();
  static EventBusManager get instance => _getInstance();

  static EventBusManager _instance;
  static EventBusManager _getInstance() {
    if (_instance == null) {
      _instance = EventBusManager._internal();
    }
    return _instance;
  }
}

class AddItemSuccessEvent {
  ToDo todo;
  AddItemSuccessEvent(this.todo);
}