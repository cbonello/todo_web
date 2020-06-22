import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'src/application.dart';
import 'src/repositories/repositories.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  EquatableConfig.stringify = true;

  runTodoApp(TodosRepository(
      // localStorage: KeyValueStorage(
      //   'bloc_library',
      //   WebKeyValueStore(window.localStorage),
      // ),
      ));
}
