import 'dart:async';

import 'package:sembast/sembast.dart';
import 'package:sembast_web/sembast_web.dart';

import '../entities/entities.dart';
import './todos_repository.dart';

class TodosRepository implements ITodosRepository {
  Future<void> init() async {
    db = await idbFactory.openDatabase('todos.db');
  }

  final StoreRef<String, Map<String, dynamic>> store = stringMapStoreFactory.store();
  final DatabaseFactory idbFactory = databaseFactoryWeb;
  Database db;

  static const String todosStore = 'todos';

  @override
  Future<List<TodoEntity>> loadTodos() async {
    final List<RecordSnapshot<String, Map<String, dynamic>>> snapshots =
        await store.find(db);
    return snapshots
        .map((RecordSnapshot<String, Map<String, dynamic>> snapshot) =>
            TodoEntity.fromJson(snapshot.value))
        .toList(growable: false);
  }

  @override
  Future<void> saveTodos(List<TodoEntity> todos) async {
    await store.delete(db);
    await db.transaction((Transaction txn) async {
      for (final TodoEntity todo in todos) {
        final Map<String, dynamic> json = todo.toJson();
        final String id = json['id'] as String;
        await store.record(id).put(txn, json);
      }
    });
  }
}
