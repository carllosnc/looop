import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:share_plus/share_plus.dart';
import 'package:vw/vw.dart';
import '/imports/app.dart';

openDetails(BuildContext context, Task task, List<Check> checks) {
  final GlobalKey globalKey = GlobalKey();

  Future<Uint8List> captureWidget() async {
    final RenderRepaintBoundary boundary = globalKey //
        .currentContext
        ?.findRenderObject() as RenderRepaintBoundary;

    final ui.Image image = await boundary.toImage(pixelRatio: 2.0);

    final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);

    final Uint8List pngBytes = byteData!.buffer.asUint8List();

    return pngBytes;
  }

  Future<dynamic> deleteTask(BuildContext context, Task task) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          title: const Text(
            'Delete Task',
            style: TextStyle(
              fontSize: 25,
              color: Colors.red,
            ),
          ),
          content: const Text('Are you sure you want to delete this task?'),
          actions: [
            VWRow(
              horizontalAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                VWButton(
                  color: Colors.black,
                  onTap: () {
                    TaskService.deleteTask(task);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  label: 'Delete',
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Future<dynamic> storeTask({
    required BuildContext context,
    required Task task,
    required String title,
    required String description,
    required bool finished,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 25,
            ),
          ),
          content: Text(description),
          actions: [
            VWRow(
              horizontalAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                VWButton(
                  color: Colors.black,
                  onTap: () {
                    TaskService.finishTask(task, finished);
                    Navigator.pop(context);
                    Navigator.pop(context);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Task finished'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  label: finished ? 'Store' : 'Restore',
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  VWPage.open(
    context: context,
    level: 1,
    appBar: AppBar(
      actions: [
        if (task.finished == true)
          IconButton(
            icon: Icon(
              Icons.refresh,
              color: Colors.black.withOpacity(0.7),
            ),
            onPressed: () async {
              storeTask(
                context: context,
                task: task,
                title: 'Restore Task',
                description: 'Are you sure you want to restore this task?',
                finished: false,
              );
            },
          ),
        if (task.finished == false)
          IconButton(
            icon: Icon(
              Icons.save_outlined,
              color: Colors.black.withOpacity(0.7),
            ),
            onPressed: () async {
              storeTask(
                context: context,
                task: task,
                title: 'Store Task',
                description: 'Are you sure you want to store this task?',
                finished: true,
              );
            },
          ),
        IconButton(
            icon: Icon(
              Icons.share_outlined,
              color: Colors.black.withOpacity(0.7),
            ),
            onPressed: () async {
              var result = await captureWidget();

              Share.shareXFiles([
                XFile.fromData(
                  result,
                  name: 'progress',
                  mimeType: 'image/png',
                )
              ]);
            }),
        if (task.finished == false)
          IconButton(
            icon: Icon(
              Icons.edit_outlined,
              color: Colors.black.withOpacity(0.7),
            ),
            onPressed: () {
              updateTask(context: context, task: task);
            },
          ),
        IconButton(
          icon: const Icon(
            Icons.delete_outline,
            color: Colors.red,
          ),
          onPressed: () {
            deleteTask(context, task);
          },
        ),
      ],
    ),
    body: SingleChildScrollView(
      child: DelayRender(
        delay: 300,
        child: RepaintBoundary(
          key: globalKey,
          child: ProgressBoard(
            task: task,
          ),
        ),
      ),
    ),
  );
}
