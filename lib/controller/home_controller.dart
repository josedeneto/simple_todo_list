import 'package:flutter/cupertino.dart';

class HomeController extends ChangeNotifier {
  final List<String> _myTodo = [];
  List<String> get  todo => _myTodo;
  addTodo({required String todo}) {
    _myTodo.add(todo);
    notifyListeners();
  }
}
