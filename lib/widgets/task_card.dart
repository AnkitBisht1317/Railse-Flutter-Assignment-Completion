import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/task_model.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback onStartTask;
  final VoidCallback onMarkComplete;
  final VoidCallback onEditDate;

  const TaskCard({
    super.key,
    required this.task,
    required this.onStartTask,
    required this.onMarkComplete,
    required this.onEditDate,
  });

  @override
  Widget build(BuildContext context) {
    final isOverdue =
        task.dueDate.isBefore(DateTime.now()) && task.status != 'Completed';
    final dateFormat = DateFormat('yyyy-MM-dd');

    Color statusColor;
    String statusText;
    if (task.status == 'Completed') {
      statusColor = Colors.green;
      statusText = 'Completed';
    } else if (isOverdue) {
      statusColor = Colors.red;
      statusText = 'Overdue';
    } else {
      statusColor = Colors.orange;
      statusText = 'Due: ${dateFormat.format(task.dueDate)}';
    }

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  task.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (task.status != 'Completed')
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: onEditDate,
                  ),
              ],
            ),

            const SizedBox(height: 4),
            Text(task.description, style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 8),

            Row(
              children: [
                const Icon(Icons.calendar_today, size: 16),
                const SizedBox(width: 6),
                Text("Due: ${dateFormat.format(task.dueDate)}"),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.person, size: 16),
                const SizedBox(width: 6),
                Text("Assignee: ${task.assignee}"),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.flag, size: 16),
                const SizedBox(width: 6),
                Text("Priority: ${task.priority}"),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.info, size: 16),
                const SizedBox(width: 6),
                Text("Status: ${task.status}"),
              ],
            ),
            const SizedBox(height: 10),

            // Status bar
            Text(
              statusText,
              style: TextStyle(color: statusColor, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 10),

            if (task.status == 'Not Started')
              ElevatedButton(
                onPressed: onStartTask,
                child: const Text("Start Task"),
              )
            else if (task.status == 'Started')
              ElevatedButton(
                onPressed: onMarkComplete,
                child: const Text("Mark as Complete"),
              )
            else
              const Text(
                "Task Completed ✅",
                style: TextStyle(color: Colors.green),
              ),
          ],
        ),
      ),
    );
  }
}
