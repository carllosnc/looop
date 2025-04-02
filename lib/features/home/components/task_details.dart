import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:share_plus/share_plus.dart';
import 'package:vw/vw.dart';
import 'edit_task.dart';
import 'delay_render.dart';
import 'progress_board.dart';
import '/imports.dart';

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

  context.openSheet(
    level: 1,
    appBar: AppBar(
      actions: [
        if (task.finished == true)
          IconButton(
            icon: Icon(
              Icons.refresh,
              color: Colors.black.withValues(alpha: 0.7),
            ),
            onPressed: () async {
              openCustomDialog(
                context: context,
                title: 'Restore Task',
                cancelLabel: 'Cancel',
                confirmLabel: 'Restore',
                description: 'Are you sure you want to restore this task?',
                onConfirm: () {
                  TaskService.finishTask(task, false);
                  Navigator.pop(context);
                  Navigator.pop(context);

                  context.showSnackBar(message: "Task restored");
                },
              );
            },
          ),
        if (task.finished == false)
          IconButton(
            icon: Icon(
              Icons.save_outlined,
              color: Colors.black.withValues(alpha: 0.7),
            ),
            onPressed: () async {
              openCustomDialog(
                context: context,
                title: 'Store Task',
                cancelLabel: 'Cancel',
                confirmLabel: 'Store',
                description: 'Are you sure you want to store this task?',
                onConfirm: () {
                  TaskService.finishTask(task, true);
                  Navigator.pop(context);
                  Navigator.pop(context);

                  context.showSnackBar(message: "Task stored");
                },
              );
            },
          ),
        IconButton(
            icon: Icon(
              Icons.share_outlined,
              color: Colors.black.withValues(alpha: 0.7),
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
              color: Colors.black.withValues(alpha: 0.7),
            ),
            onPressed: () {
              editTask(context: context, task: task);
            },
          ),
        IconButton(
          icon: const Icon(
            Icons.delete_outline,
            color: Colors.red,
          ),
          onPressed: () {
            openCustomDialog(
              context: context,
              title: 'Delete Task',
              cancelLabel: 'Cancel',
              confirmLabel: 'Delete',
              description: 'Are you sure you want to delete this task?',
              onConfirm: () {
                TaskService.deleteTask(task);

                Navigator.pop(context);
                Navigator.pop(context);
              },
            );
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
