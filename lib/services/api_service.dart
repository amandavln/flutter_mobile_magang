import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class ApiService {
  static Future<List<User>> getUsers(int page, int perPage) async {
    final url = Uri.parse('https://reqres.in/api/users?page=$page&per_page=$perPage');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['data'];
      return data.map((json) => User.fromJson(json)).toList();
    } else {
      return [];
    }
  }
}
