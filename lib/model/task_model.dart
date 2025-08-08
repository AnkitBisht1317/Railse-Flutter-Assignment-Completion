import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  final String id;
  String title;
  String description;
  String assignee;
  String priority; // High / Normal
  DateTime startDate;
  String status; // Not Started, Started, Completed
  DateTime dueDate;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.assignee,
    required this.priority,
    required this.startDate,
    required this.status,
    required this.dueDate,
  });
  factory Task.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return Task(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      dueDate: (data['dueDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
      startDate: (data['startDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
      status: data['status'] ?? 'Not Started',
      priority: data['priority'] ?? '',
      assignee: data['assignee'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'assignee': assignee,
      'priority': priority,
      'startDate': startDate,
      'status': status,
      'dueDate': dueDate,
    };
  }
}
