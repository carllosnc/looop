import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '/imports/app.dart';

sealed class TaskService {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static final user = FirebaseAuth.instance.currentUser;

  static Future<void> addTask({
    required String title,
    required String hour,
    required String icon,
  }) async {
    final id = UniqueKey().hashCode.toString();

    final task = Task(
      id: id,
      title: title,
      hour: hour,
      icon: icon,
      createdAt: DateTime.now(),
    );

    return _db //
        .collection('users')
        .doc(user!.uid)
        .collection('tasks')
        .doc(id)
        .set(task.toJson());
  }

  static Future<void> updateTask({
    required Task task,
    required String title,
    required String hour,
    required String icon,
    required DateTime? lastCheck,
  }) {
    final updatedTask = Task(
      id: task.id,
      title: title,
      hour: hour,
      icon: icon,
      createdAt: task.createdAt,
      lastCheck: lastCheck,
    );

    return _db //
        .collection('tasks')
        .doc(task.id)
        .update(updatedTask.toJson());
  }

  static Stream<DocumentSnapshot<Map<String, dynamic>>> getTask(Task task) {
    return _db //
        .collection('users')
        .doc(user!.uid)
        .collection('tasks')
        .doc(task.id)
        .snapshots();
  }

  static Future<void> deleteTask(Task task) {
    return _db //
        .collection('users')
        .doc(user!.uid)
        .collection('tasks')
        .doc(task.id)
        .delete();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getFinishedTasks() {
    return _db //
        .collection('users')
        .doc(user!.uid)
        .collection('tasks')
        .where('finished', isEqualTo: true)
        .snapshots();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getUnfinishedTasks() {
    return _db //
        .collection('users')
        .doc(user!.uid)
        .collection('tasks')
        .where('finished', isEqualTo: false)
        .snapshots();
  }

  static Future<void> finishTask(Task task, bool finished) {
    return _db //
        .collection('users')
        .doc(user!.uid)
        .collection('tasks')
        .doc(task.id)
        .update({'finished': finished});
  }
}
