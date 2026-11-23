import 'package:flutter/material.dart';
import 'package:todo_app/screens/todo_screen.dart';

class TodoFilterTabs extends StatelessWidget {
  final TodoFilter selectedFilter;

  final ValueChanged<TodoFilter> onFilterChanged;

  const TodoFilterTabs({
    super.key,
    required this.selectedFilter,
    required this.onFilterChanged,
  });

  Widget _buildTab(String label, TodoFilter filter) {
    final isSelected = selectedFilter == filter;

    return Expanded(
      child: GestureDetector(
        onTap: () => onFilterChanged(filter),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.all(8.0),
      child: Row(
        children: [
          _buildTab("All", TodoFilter.all),
          SizedBox(width: 8),
          _buildTab("Pending", TodoFilter.pending),
          SizedBox(width: 8),
          _buildTab("Completed", TodoFilter.completed),
          SizedBox(width: 8),
        ],
      ),
    );
  }
}
