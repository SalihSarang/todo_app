import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/web.dart';
import 'package:todo_riverpod/data/model/todo_model.dart';

final url = Uri.parse('https://6824452165ba058033998bef.mockapi.io/todos');
final log = Logger();

class Repositories {
  Future<List<TodoModel>> getTodos() async {
    final sw = Stopwatch()..start();

    final response = await http.get(url);

    sw.stop();
    log.i("GET /todos took: ${sw.elapsedMilliseconds} ms");

    if (response.statusCode == 200) {
      final decodeWatch = Stopwatch()..start();
      final List<dynamic> data = jsonDecode(response.body);
      final todos = data.map((e) => TodoModel.fromJson(e)).toList();
      decodeWatch.stop();

      log.i("Decoding todos took: ${decodeWatch.elapsedMilliseconds} ms");
      log.i("Fetched ${todos.length} todos");

      return todos;
    } else {
      throw Exception('Failed to Load');
    }
  }

  Future<TodoModel> getTodoDetails(String id) async {
    final sw = Stopwatch()..start();

    final response = await http.get(Uri.parse('$url/$id'));

    sw.stop();
    log.i("GET /todos/$id took: ${sw.elapsedMilliseconds} ms");

    if (response.statusCode == 200) {
      final decodeWatch = Stopwatch()..start();
      final data = jsonDecode(response.body);
      final todo = TodoModel.fromJson(data);
      decodeWatch.stop();

      log.i(
        "Decoding todo details took: ${decodeWatch.elapsedMilliseconds} ms",
      );
      return todo;
    } else {
      throw Exception('Failed to Load todo Details');
    }
  }

  Future<void> addTodo(TodoModel todo) async {
    final sw = Stopwatch()..start();

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(todo.toJson()),
    );

    sw.stop();
    log.i("POST /todos took: ${sw.elapsedMilliseconds} ms");

    if (response.statusCode == 201) {
      final decodeWatch = Stopwatch()..start();
      decodeWatch.stop();
      log.i("Decoding new todo took: ${decodeWatch.elapsedMilliseconds} ms");
    } else {
      throw Exception('Failed to add todo');
    }
  }

  Future<void> deleteTodo(String id) async {
    final sw = Stopwatch()..start();

    final response = await http.delete(Uri.parse('$url/$id'));

    sw.stop();
    log.i("DELETE /todos/$id took: ${sw.elapsedMilliseconds} ms");

    if (response.statusCode != 200) {
      throw Exception('Failed To Delete');
    }
  }

  Future<void> updateTodoStatus(String id, bool isCompleted) async {
    final sw = Stopwatch()..start();

    final response = await http.put(
      Uri.parse('$url/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'isCompleted': isCompleted}),
    );

    sw.stop();
    log.i("PUT /todos/$id took: ${sw.elapsedMilliseconds} ms");

    if (response.statusCode != 200) {
      throw Exception('Failed to update todo');
    }
  }
}
