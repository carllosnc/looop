import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StreamFirestoreQueryBuilder extends StatelessWidget {
  final Stream<QuerySnapshot<Map<String, dynamic>>> stream;
  final Widget Function(BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot)? success;
  final Widget noData;
  final Widget loading;

  const StreamFirestoreQueryBuilder({
    super.key,
    required this.stream,
    required this.success,
    required this.noData,
    required this.loading,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (
        context,
        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
      ) {
        bool hasData = snapshot.data != null && snapshot.hasData && snapshot.data!.docs.isNotEmpty;
        bool hasNoData = snapshot.data != null && snapshot.hasData && snapshot.data!.docs.isEmpty;

        if (hasData) {
          return success!(context, snapshot);
        } else if (hasNoData) {
          return noData;
        } else {
          return loading;
        }
      },
    );
  }
}

class StreamFirestoreDocBuilder extends StatelessWidget {
  final Stream<DocumentSnapshot<Map<String, dynamic>>> stream;
  final Widget Function(BuildContext context, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot)? success;
  final Widget noData;
  final Widget loading;

  const StreamFirestoreDocBuilder({
    super.key,
    required this.stream,
    required this.success,
    required this.noData,
    required this.loading,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (
        context,
        AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot,
      ) {
        bool hasData = snapshot.data != null && snapshot.hasData && snapshot.data!.exists;
        bool hasNoData = snapshot.data != null && snapshot.hasData && !snapshot.data!.exists;

        if (hasData) {
          return success!(context, snapshot);
        } else if (hasNoData) {
          return noData;
        } else {
          return loading;
        }
      },
    );
  }
}
