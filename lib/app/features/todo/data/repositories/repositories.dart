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

final CollectionReference _todoCollection = _firestore.collection('todos');

class Repositories {
  Future<List<TodoModel>> getTodos() async {
    final sw = Stopwatch()..start();

    final QuerySnapshot snapshot = await _todoCollection.get();

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

  Future<TodoModel> getTodoDetails(String id) async {
    final sw = Stopwatch()..start();

    final DocumentSnapshot doc = await _todoCollection.doc(id).get();

    sw.stop();
    log.i("GET todo/$id (Firestore) took: ${sw.elapsedMilliseconds} ms");

    if (doc.exists && doc.data() != null) {
      final decodeWatch = Stopwatch()..start();

      final data = doc.data() as Map<String, dynamic>;
      data['id'] = doc.id;
      final todo = TodoModel.fromJson(data);

      decodeWatch.stop();

      log.i("Mapping todo details took: ${decodeWatch.elapsedMilliseconds} ms");
      log.i("Fetched todo '$id' successfully");

      return todo;
    } else {
      log.e(" Todo with ID '$id' not found");
      throw Exception('Todo with ID $id not found');
    }
  }

  Future<void> addTodo(TodoModel todo) async {
    final sw = Stopwatch()..start();

    await _todoCollection.add(todo.toJson());

    sw.stop();
    log.i("POST todo (Firestore) took: ${sw.elapsedMilliseconds} ms");
    log.i(" Added new todo successfully");
  }

  Future<void> deleteTodo(String id) async {
    final sw = Stopwatch()..start();

    await _todoCollection.doc(id).delete();

    sw.stop();
    log.i("DELETE todo/$id (Firestore) took: ${sw.elapsedMilliseconds} ms");
    log.i(" Deleted todo $id successfully");
  }

  Future<void> updateTodoStatus(String id, bool isCompleted) async {
    final sw = Stopwatch()..start();

    await _todoCollection.doc(id).update({'isCompleted': isCompleted});

    sw.stop();
    log.i("PUT todo/$id (Firestore) took: ${sw.elapsedMilliseconds} ms");
    log.i(" Updated status for todo $id to $isCompleted");
  }
}
