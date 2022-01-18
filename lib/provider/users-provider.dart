import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_crud/data/dummy-users.dart';
import 'package:flutter_crud/models/user.dart';

class UsersProvider with ChangeNotifier {
  final Map<String, User> _items = {...DUMMY_USERS};

  List<User> get all {
    return [..._items.values];
  }

  int get count {
    return _items.length;
  }

  User byIndex(int i) {
    return _items.values.elementAt(i);
  }

  void put(User user) {
    if (user.id.trim().isNotEmpty && _items.containsKey(user.id)) {
      _items.update(user.id, (_) => user);
    } else {
      final id = Random().nextDouble().toString();
      _items.putIfAbsent(
        id,
        () => User(
          id: id,
          name: user.name,
          email: user.email,
          avatarUrl: user.avatarUrl,
        ),
      );
    }
    notifyListeners();
  }

  void delete(User user) {
    _items.remove(user.id);
    notifyListeners();
  }
}
