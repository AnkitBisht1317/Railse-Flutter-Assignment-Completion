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
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    final now = DateTime.now();
    final dateFormat = DateFormat('MMM d');
    final timeFormat = DateFormat('HH:mm');

    final isOverdue = task.dueDate.isBefore(now) && task.status != 'Completed';
    final isDueTomorrow = task.dueDate.difference(now).inDays == 1;
    final isDueSoon =
        task.dueDate.difference(now).inDays > 1 &&
        task.dueDate.difference(now).inDays <= 3;

    String statusText;
    Color statusColor;

    if (task.status == 'Completed') {
      statusText = 'Completed: ${dateFormat.format(task.dueDate)}';
      statusColor = Colors.green;
    } else if (isOverdue) {
      final diff = now.difference(task.dueDate);
      statusText = 'Overdue – ${diff.inHours}h ${diff.inMinutes % 60}m';
      statusColor = Colors.red;
    } else if (isDueTomorrow) {
      statusText = 'Due Tomorrow';
      statusColor = Colors.orange;
    } else if (isDueSoon) {
      statusText = 'Due in ${task.dueDate.difference(now).inDays} days';
      statusColor = Colors.deepOrangeAccent;
    } else {
      statusText = '';
      statusColor = Colors.black;
    }

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title and Description Section
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                // Left Section
                SizedBox(
                  width: screenWidth * 0.55,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title,
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w600,
                          fontSize: isSmallScreen ? 14 : 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        task.description,
                        style: TextStyle(fontSize: isSmallScreen ? 12 : 14),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        task.assignee,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      if (task.priority == 'High') ...[
                        const SizedBox(height: 4),
                        const Text(
                          'High Priority',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                // Right Section
                SizedBox(
                  width: screenWidth * 0.3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (task.status != 'Completed')
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Flexible(
                              child: Text(
                                statusText,
                                style: TextStyle(
                                  color: statusColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: isSmallScreen ? 12 : 14,
                                ),
                              ),
                            ),
                            const SizedBox(width: 4),
                            InkWell(
                              onTap: onEditDate,
                              child: const Icon(Icons.edit, size: 18),
                            ),
                          ],
                        )
                      else
                        Text(
                          statusText,
                          style: TextStyle(
                            color: statusColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      const SizedBox(height: 4),
                      Text(
                        'Started: ${dateFormat.format(task.startDate)}',
                        style: const TextStyle(fontSize: 13),
                      ),
                      const SizedBox(height: 8),
                      if (task.status == 'Not Started')
                        ElevatedButton(
                          onPressed: onStartTask,
                          child: const Text('Start Task'),
                        )
                      else if (task.status == 'Started')
                        TextButton(
                          onPressed: onMarkComplete,
                          child: const Text('Mark as complete'),
                        )
                      else
                        const Text("Task Completed ✅"),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
