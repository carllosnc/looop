import 'package:flutter/material.dart';
import 'package:vw/vw.dart';

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
        title: Text(title),
        content: Text(description),
        actions: [
          VWRow(
            horizontalAlignment: MainAxisAlignment.spaceBetween,
            verticalAlignment: CrossAxisAlignment.center,
            children: [
              FilledButton.tonal(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  cancelLabel,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
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
