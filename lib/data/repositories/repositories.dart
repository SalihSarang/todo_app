import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:todo_riverpod/data/model/todo_model.dart';

final url = Uri.parse('https://6824452165ba058033998bef.mockapi.io/todos');

class Repositories {
  Future<List<TodoModel>> getTodos() async {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => TodoModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to Load');
    }
  }

  Future<void> deleteTodo(String id) async {
    final response = await http.delete(Uri.parse('$url/$id'));
    if (response.statusCode != 200) throw Exception('Failed To Delete');
  }

  Future<void> updateTodoStatus(String id, bool isCompleted) async {
    final response = await http.put(
      Uri.parse('$url/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'isCompleted': isCompleted}),
    );

    if (response.statusCode != 200) throw Exception('Failed to update todo');
  }

  Future<void> addTodo() async {}

  Future<void> getTodoDetails() async {}
}
