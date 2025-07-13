import 'package:flutter/material.dart';
import '../models/user_model.dart';

class UserProvider with ChangeNotifier {
  List<User> _users = [];
  bool _isLoading = false;
  bool _hasMore = true;
  String? _selectedUser;

  int _page = 1;
  final int _perPage = 6;

  List<User> get users => _users;
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;
  String? get selectedUser => _selectedUser;

  Future<void> fetchUsers({bool refresh = false}) async {
    if (_isLoading) return;
    _isLoading = true;
    notifyListeners();

    if (refresh) {
      _users.clear();
      _page = 1;
      _hasMore = true;
    }

    final result = await ApiService.getUsers(_page, _perPage);
    if (result.isNotEmpty) {
      _users.addAll(result);
      _page++;
    } else {
      _hasMore = false;
    }

    _isLoading = false;
    notifyListeners();
  }
  void selectUser(String name) {
    print('[UserProvider] selectUser dipanggil: $name');
    _selectedUser = name;
    notifyListeners();
  }
}