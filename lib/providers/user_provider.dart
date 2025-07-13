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
      User(id: 1, email: 'imhel@gmail.com', firstName: 'Imhammel', lastName: 'Agsafar', avatar: ''),
      User(id: 2, email: 'amanda.novalina@gmail.com', firstName: 'Amanda', lastName: 'Novalina', avatar: ''),
      User(id: 3, email: 'm.hanafi@gmail.com', firstName: 'Muhammad', lastName: 'Hanafi', avatar: ''),
      User(id: 4, email: 'caramel@gmail.com', firstName: 'Caramel', lastName: 'Keisya', avatar: ''),
      User(id: 5, email: 'laura@gmail.com', firstName: 'Valaurrent', lastName: 'Graviella', avatar: ''),
      User(id: 6, email: 'keano@gmail.com', firstName: 'Keano', lastName: 'Altezza', avatar: ''),
      User(id: 7, email: 'zavant@gmail.com', firstName: 'Zavant', lastName: 'Givanno', avatar: ''),
      User(id: 8, email: 'steven@gmail.com', firstName: 'Steven', lastName: 'Alexander', avatar: ''),
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