import 'package:flutter/material.dart';

import '../keys.dart';
import '../models/models.dart';

typedef OnSaveCallback = void Function(String task, String note);

class AddEditScreen extends StatefulWidget {
  const AddEditScreen({
    Key key,
    @required this.onSave,
    @required this.isEditing,
    this.todo,
  }) : super(key: key ?? AppKeys.addTodoScreen);

  final bool isEditing;
  final OnSaveCallback onSave;
  final Todo todo;

  static const String route = '/addTodo';

  @override
  _AddEditScreenState createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _task;
  String _note;

  bool get isEditing => widget.isEditing;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing ? 'Edit Todo' : 'Add Todo',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                initialValue: isEditing ? widget.todo.task : '',
                key: AppKeys.taskField,
                autofocus: !isEditing,
                style: textTheme.headline5,
                decoration: const InputDecoration(
                  hintText: 'What needs to be done?',
                ),
                validator: (String val) {
                  return val.trim().isEmpty ? 'Please enter some text' : null;
                },
                onSaved: (String value) => _task = value,
              ),
              TextFormField(
                initialValue: isEditing ? widget.todo.note : '',
                key: AppKeys.noteField,
                maxLines: 10,
                style: textTheme.subtitle1,
                decoration: const InputDecoration(
                  hintText: 'Additional Notes...',
                ),
                onSaved: (String value) => _note = value,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: isEditing ? AppKeys.saveTodoFab : AppKeys.saveNewTodo,
        tooltip: isEditing ? 'Save changes' : 'Add Todo',
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            widget.onSave(_task, _note);
            Navigator.pop(context);
          }
        },
        child: Icon(isEditing ? Icons.check : Icons.add),
      ),
    );
  }
}
