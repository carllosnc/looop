import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '/imports/app.dart';

sealed class DataService {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<void> addTask({
    required String title,
    required String hour,
    required String icon,
  }) {
    final id = UniqueKey().hashCode.toString();

    final task = Task(
      id: id,
      title: title,
      hour: hour,
      icon: icon,
      createdAt: DateTime.now(),
    );

    return _db.collection('tasks').doc(id).set(task.toJson());
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

    return _db.collection('tasks').doc(task.id).update(updatedTask.toJson());
  }

  static Stream<DocumentSnapshot<Map<String, dynamic>>> getTask(Task task) {
    return _db.collection('tasks').doc(task.id).snapshots();
  }

  static Future<void> deleteTask(Task task) {
    return _db.collection('tasks').doc(task.id).delete();
  }

  static Future<void> addCheck(Task task) {
    final id = UniqueKey().hashCode.toString();

    final check = Check(
      id: id,
      checkedAt: DateTime.now(),
    );

    Map<String, dynamic> checkAsJson = check.toJson();

    return _db.collection('tasks').doc(task.id).update({
      'lastCheck': checkAsJson['checkedAt'],
    }).then((value) {
      return _db.collection('tasks').doc(task.id).collection('checks').doc(id).set(checkAsJson);
    });
  }

  static Future<void> deleteCheck(Task task, Check check) {
    return _db.collection('tasks').doc(task.id).collection('checks').doc(check.id).delete();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getChecks(Task task) {
    return _db.collection('tasks').doc(task.id).collection('checks').snapshots();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getTasks() {
    return _db.collection('tasks').snapshots();
  }

  //test

  static Future<void> addCheckTest(Task task, int days) {
    final id = UniqueKey().hashCode.toString();

    final check = Check(
      id: id,
      checkedAt: DateTime.now().add(Duration(days: days)),
    );

    Map<String, dynamic> checkAsJson = check.toJson();

    return _db.collection('tasks').doc(task.id).update({
      'lastCheck': checkAsJson['checkedAt'],
    }).then((value) {
      return _db.collection('tasks').doc(task.id).collection('checks').doc(id).set(checkAsJson);
    });
  }
}
