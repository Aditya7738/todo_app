
import 'package:flutter/material.dart';

class TodoAddDialog extends StatefulWidget {
  final ValueChanged<String> onAdd;

  const TodoAddDialog({
    super.key,
    required this.onAdd,
  });

  @override
  State<TodoAddDialog> createState() => _TodoAddDialogState();
}

class _TodoAddDialogState extends State<TodoAddDialog> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  void _addTodo() {
    final title = _controller.text.trim();

    if (title.isEmpty) {
      return;
    }

    widget.onAdd(title);

    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Todo'),

      content: TextField(
        controller: _controller,
        autofocus: true,
        textCapitalization: TextCapitalization.sentences,
        decoration: const InputDecoration(
          hintText: 'Enter task title',
          border: OutlineInputBorder(),
        ),
        onSubmitted: (_) => _addTodo(),
      ),

      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),

        ElevatedButton(
          onPressed: _addTodo,
          child: const Text('Add'),
        ),
      ],
    );
  }
}
