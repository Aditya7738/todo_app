
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/providers/todo_provider.dart';
import 'package:todo_app/widgets/empty_todo_view.dart';
import 'package:todo_app/widgets/todo_filter_tabs.dart';
import 'package:todo_app/widgets/todo_list_item.dart';
import 'package:todo_app/widgets/todo_add_dialog.dart';

enum TodoFilter { all, pending, completed }

class ToDoScreen extends ConsumerStatefulWidget {
  const ToDoScreen({super.key});

  @override
  ConsumerState<ToDoScreen> createState() => _ToDoState();
}

class _ToDoState extends ConsumerState<ToDoScreen> {
  TodoFilter _selectedFilter = TodoFilter.all;

  List<ToDo> _filterToDo(List<ToDo> list) {
    switch (_selectedFilter) {
      case TodoFilter.all:
        return list;

      case TodoFilter.completed:
        return list.where((todo) => todo.isCompleted).toList();

      case TodoFilter.pending:
        return list.where((todo) => !todo.isCompleted).toList();
    }
  }

  void _showAddToDoDialog() {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return TodoAddDialog(
          onAdd: (title) {
            ref.read(todoProvider.notifier).addToDo(title);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final todos = ref.watch(todoProvider);
    final filteredTodos = _filterToDo(todos);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My ToDo List'),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _showAddToDoDialog,
        child: const Icon(Icons.add),
      ),

      body: Column(
        children: [
          TodoFilterTabs(
            selectedFilter: _selectedFilter,
            onFilterChanged: (filter) {
              setState(() {
                _selectedFilter = filter;
              });
            },
          ),

          Expanded(
            child: filteredTodos.isEmpty
                ? const EmptyTodoView()
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    itemCount: filteredTodos.length,
                    itemBuilder: (context, index) {
                      final todo = filteredTodos[index];

                      return TodoListItem(
                        todo: todo,
                        onToggle: () {
                          ref
                              .read(todoProvider.notifier)
                              .toggleToDo(todo.id);
                        },
                        onDelete: () {
                          ref
                              .read(todoProvider.notifier)
                              .deleteToDo(todo.id);
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
