import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:todo_riverpod/app/features/todo/data/model/todo_model.dart';

final log = Logger(
  printer: PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 5,
    lineLength: 90,
    colors: true,
    printEmojis: true,
  ),
);

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class Repositories {
  CollectionReference _userTodoCollection(String userId) {
    return _firestore.collection('users').doc(userId).collection('todos');
  }

  Future<List<TodoModel>> getTodos(String userId) async {
    final sw = Stopwatch()..start();

    final QuerySnapshot snapshot = await _userTodoCollection(userId).get();

    sw.stop();
    log.i("GET todos (Firestore) took: ${sw.elapsedMilliseconds} ms");

    final decodeWatch = Stopwatch()..start();

    final todos = snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      data['id'] = doc.id;
      return TodoModel.fromJson(data);
    }).toList();

    decodeWatch.stop();

    log.i("Mapping todos took: ${decodeWatch.elapsedMilliseconds} ms");
    log.i("Fetched ${todos.length} todos successfully");

    return todos;
  }

  Stream<List<TodoModel>> getTodoStream(String userId) {
    return _userTodoCollection(userId).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return TodoModel.fromJson(data);
      }).toList();
    });
  }

  Future<TodoModel> getTodoDetails(String userId, String todoId) async {
    final sw = Stopwatch()..start();

    final DocumentSnapshot doc = await _userTodoCollection(
      userId,
    ).doc(todoId).get();

    sw.stop();
    log.i("GET todo/$todoId (Firestore) took: ${sw.elapsedMilliseconds} ms");

    if (doc.exists && doc.data() != null) {
      final decodeWatch = Stopwatch()..start();

      final data = doc.data() as Map<String, dynamic>;
      data['id'] = doc.id;
      final todo = TodoModel.fromJson(data);

      decodeWatch.stop();

      log.i("Mapping todo details took: ${decodeWatch.elapsedMilliseconds} ms");
      log.i("Fetched todo '$todoId' successfully");

      return todo;
    } else {
      log.e(" Todo with ID '$todoId' not found");
      throw Exception('Todo with ID $todoId not found');
    }
  }

  Future<void> addTodo(String userId, TodoModel todo) async {
    final sw = Stopwatch()..start();

    await _userTodoCollection(userId).add(todo.toJson());

    sw.stop();
    log.i("POST todo (Firestore) took: ${sw.elapsedMilliseconds} ms");
    log.i(" Added new todo successfully");
  }

  Future<void> deleteTodo(String userId, String todoId) async {
    final sw = Stopwatch()..start();

    await _userTodoCollection(userId).doc(todoId).delete();

    sw.stop();
    log.i("DELETE todo/$todoId (Firestore) took: ${sw.elapsedMilliseconds} ms");
    log.i(" Deleted todo $todoId successfully");
  }

  Future<void> updateTodoStatus(
    String userId,
    String id,
    bool isCompleted,
  ) async {
    final sw = Stopwatch()..start();

    await _userTodoCollection(
      userId,
    ).doc(id).update({'isCompleted': isCompleted});

    sw.stop();
    log.i("PUT todo/$id (Firestore) took: ${sw.elapsedMilliseconds} ms");
    log.i(" Updated status for todo $id to $isCompleted");
  }
}
