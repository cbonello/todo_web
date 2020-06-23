import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'src/application.dart';
import 'src/repositories/repositories.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  EquatableConfig.stringify = true;

  final TodosRepository todosRepository = TodosRepository();
  await todosRepository.init();

  runTodoApp(todosRepository);
}
