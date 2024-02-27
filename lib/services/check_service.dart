import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '/imports/app.dart';

sealed class CheckService {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

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
