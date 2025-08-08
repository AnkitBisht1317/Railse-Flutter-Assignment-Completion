import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/task_model.dart';
import '../viewmodel/task_view_model.dart';
import '../widgets/task_card.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<TaskViewModel>(context, listen: false);
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Task List',
          style: TextStyle(fontSize: screenWidth * 0.045), // responsive font
        ),
      ),
      body: StreamBuilder<List<Task>>(
        stream: viewModel.getTasks(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final tasks = snapshot.data!;

          return LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth > 600; // Tablet/Desktop check

              return ListView.builder(
                padding: EdgeInsets.symmetric(
                  horizontal: isWide ? screenWidth * 0.1 : 10,
                  vertical: 8,
                ),
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return TaskCard(
                    task: task,
                    onStartTask:
                        () => viewModel.updateStatus(task.id, 'Started'),
                    onMarkComplete:
                        () => viewModel.updateStatus(task.id, 'Completed'),
                    onEditDate: () async {
                      DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: task.startDate,
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2030),
                      );
                      if (picked != null) {
                        viewModel.updateStartDate(task.id, picked);
                      }
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
