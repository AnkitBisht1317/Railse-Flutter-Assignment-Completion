import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/task_model.dart';

class TaskViewModel {
  final _firestore = FirebaseFirestore.instance;

  Stream<List<Task>> getTasks() {
    return _firestore
        .collection('tasks')
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => Task.fromFirestore(doc)).toList(),
        );
  }

  Future<void> updateStatus(String taskId, String newStatus) async {
    await _firestore.collection('tasks').doc(taskId).update({
      'status': newStatus,
    });
  }

  Future<void> updateStartDate(String taskId, DateTime newDate) async {
    await _firestore.collection('tasks').doc(taskId).update({
      'startDate': newDate,
    });
  }
}
