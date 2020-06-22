import '../entities/entities.dart';

abstract class ITodosRepository {
  Future<List<TodoEntity>> loadTodos();
  Future<void> saveTodos(List<TodoEntity> todos);
}
