import 'package:flutter/material.dart';
import 'package:vw/vw.dart';
import '/imports.dart';

openCustomDialog({
  required BuildContext context,
  required String title,
  required String description,
  required String cancelLabel,
  required String confirmLabel,
  required void Function() onConfirm,
}) async {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        surfaceTintColor: Colors.white,
        title: title.pageTitle,
        content: description.text,
        actions: [
          VWRow(
            horizontalAlignment: MainAxisAlignment.spaceBetween,
            verticalAlignment: CrossAxisAlignment.center,
            children: [
              cancelLabel.outlinedButton(onPressed: () {
                Navigator.of(context).pop();
              }),
              VWButton(
                color: Colors.black,
                label: confirmLabel,
                onTap: () {
                  onConfirm();
                },
              )
            ],
          ),
        ],
      );
    },
  );
}
