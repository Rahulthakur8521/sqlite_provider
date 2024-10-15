import 'package:flutter/material.dart';

import 'database_helper.dart';
import 'model_page.dart';


class UserProvider extends ChangeNotifier {
  List<User> _users = [];

  List<User> get users => _users;

  Future<void> fetchUsers() async {
    _users = await DatabaseHelper.instance.getUsers();
    notifyListeners();

  }

  Future<List<User>> getAllUsers() async {
    var data = await DatabaseHelper.instance.getUsers();
    notifyListeners();
    return data;

  }

  Future<void> addUser(User user) async {
    await DatabaseHelper.instance.insertUser(user);
    await getAllUsers();

  }

  Future<void> updateUser(User user) async {
    await DatabaseHelper.instance.updateUser(user);
    await getAllUsers();

  }

  Future<void> deleteUser(int id) async {
    await DatabaseHelper.instance.deleteUser(id);
    await getAllUsers();

  }

}
