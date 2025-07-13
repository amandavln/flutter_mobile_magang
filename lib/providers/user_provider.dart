import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/api_service.dart';

class UserProvider with ChangeNotifier {
  List<User> _users = [];
  int _page = 1;
  final int _perPage = 6;
  bool _isLoading = false;
  bool _hasMore = true;

  String? _selectedUser;

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

    if (!_hasMore) {
      _isLoading = false;
      notifyListeners();
      return;
    }

    // Dummy data custom
    List<User> dummyUsers = [
      User(id: 1, email: 'rala@email.com', firstName: 'Rafika', lastName: 'Widalala', avatar: ''),
      User(id: 2, email: 'lisa@email.com', firstName: 'Lalisa', lastName: 'Manoban', avatar: ''),
      User(id: 3, email: 'juhar@email.com', firstName: 'Juhar', lastName: 'Ananda', avatar: ''),
      User(id: 4, email: 'jennie@email.com', firstName: 'Kim', lastName: 'Jennie', avatar: ''),
      User(id: 5, email: 'yura@email.com', firstName: 'Yura', lastName: 'Yunani', avatar: ''),
      User(id: 6, email: 'ronald@email.com', firstName: 'Ronald', lastName: 'Patrick', avatar: ''),
      User(id: 7, email: 'keisha@email.com', firstName: 'Keisha', lastName: 'Valery', avatar: ''),
      User(id: 8, email: 'jason@email.com', firstName: 'Jason', lastName: 'Yohannes', avatar: ''),
    ];

    await Future.delayed(const Duration(milliseconds: 500));

    _users.addAll(dummyUsers); // hanya dijalankan satu kali
    _hasMore = false; // penting agar CircularProgressIndicator hilang
    _isLoading = false;
    notifyListeners();
  }
  void selectUser(String name) {
    print('[UserProvider] selectUser dipanggil: $name');
    _selectedUser = name;
    notifyListeners();
  }
}