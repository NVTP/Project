import 'dart:collection';

import 'package:finalproject/model/event.dart';
import 'package:finalproject/model/user_join.dart';
import 'package:flutter/material.dart';

class EventNotifier with ChangeNotifier{
  List<Events> _eventList = [];
  Events _currentEvent;
  List<UserJoin> _userJoinList = [];

  UnmodifiableListView<UserJoin> get userJoinList => UnmodifiableListView(_userJoinList);

  set userJoinList(List<UserJoin> userJoinList){
    _userJoinList = userJoinList;
    notifyListeners();
  }

  UnmodifiableListView<Events> get eventList => UnmodifiableListView(_eventList);

  Events get currentEvent => _currentEvent;

  set eventList(List<Events> eventList){
    _eventList = eventList;
    notifyListeners();
  }

  set currentEvent(Events event){
    _currentEvent = event;
    notifyListeners();
  }

  addEvent(Events event){
    _eventList.insert(0, event);
    notifyListeners();
  }

  deleteEvent(Events event){
    _eventList.removeWhere((_event)=>_event.eventId == event.eventId);
    notifyListeners();
  }

}