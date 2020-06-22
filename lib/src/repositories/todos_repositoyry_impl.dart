import '../entities/entities.dart';
import './todos_repository.dart';

class TodosRepository implements ITodosRepository {
  @override
  Future<List<TodoEntity>> loadTodos() async {
    return Future<List<TodoEntity>>.value(<TodoEntity>[]);
  }

  @override
  Future<void> saveTodos(List<TodoEntity> todos) {
    return Future<void>.value();
  }
}
