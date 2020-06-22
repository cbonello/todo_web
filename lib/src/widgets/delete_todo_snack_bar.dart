import 'package:flutter/material.dart';

import '../models/models.dart';

class DeleteTodoSnackBar extends SnackBar {
  DeleteTodoSnackBar({
    Key key,
    @required Todo todo,
    @required VoidCallback onUndo,
  }) : super(
          key: key,
          content: Text(
            'Deleted "${todo.task}"',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          duration: const Duration(seconds: 2),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: onUndo,
          ),
        );
}
