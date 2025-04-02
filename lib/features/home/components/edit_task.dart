import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';
import 'package:vw/vw.dart';
import '/imports.dart';
import 'emoji_select.dart';

editTask({
  required BuildContext context,
  required Task task,
}) {
  context.openSheet(
    level: 2,
    appBar: AppBar(
      title: "Edit Task".pageTitle,
    ),
    body: FormUpdateTask(
      task: task,
    ),
  );
}

class FormUpdateTask extends StatefulWidget {
  final Task task;

  const FormUpdateTask({
    super.key,
    required this.task,
  });

  @override
  State<FormUpdateTask> createState() => _FormUpdateTaskState();
}

class _FormUpdateTaskState extends State<FormUpdateTask> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  String rememberHour = "";
  String icon = "";
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    titleController.text = widget.task.title;
    rememberHour = widget.task.hour;
    icon = widget.task.icon;
  }

  updateTaskAction(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      await TaskService.updateTask(
        task: widget.task,
        title: titleController.text,
        hour: rememberHour,
        icon: icon,
        lastCheck: widget.task.lastCheck,
      );

      setState(() {
        isLoading = false;
      });

      if (context.mounted) {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        child: VWColumn(
          children: [
            Form(
              key: formKey,
              child: VWColumn(
                children: [
                  VWColumn(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    children: [
                      TextFormField(
                        validator: Validatorless.required("Required field"),
                        controller: titleController,
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                        decoration: const InputDecoration(
                          labelText: "Title",
                          floatingLabelAlignment: FloatingLabelAlignment.start,
                          suffixIcon: Icon(Icons.edit_outlined),
                        ),
                      ),
                      VWTimePicker(
                        builder: (context, child) => MediaQuery(
                          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                          child: child!,
                        ),
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                        initialValue: TimeOfDay(
                          hour: int.parse(widget.task.hour.split(":")[0]),
                          minute: int.parse(widget.task.hour.split(":")[1]),
                        ),
                        validator: Validatorless.required("Required field"),
                        decoration: const InputDecoration(
                          labelText: "Hour",
                          floatingLabelAlignment: FloatingLabelAlignment.start,
                          suffixIcon: Icon(Icons.access_time),
                        ),
                        onChanged: (value) {
                          setState(() {
                            String minute = value.minute.toString().length == 1 //
                                ? "0${value.minute}"
                                : value.minute.toString();

                            String hour = value.hour.toString().length == 1 //
                                ? "0${value.hour}"
                                : value.hour.toString();

                            rememberHour = "$hour:$minute";
                          });
                        },
                      ),
                      EmojiSelect(
                        validator: Validatorless.required("Required field"),
                        initialValue: widget.task.icon,
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                        onChanged: (value) {
                          icon = value!;
                        },
                      ),
                      const SizedBox(height: 30),
                      VWButton(
                        isLoading: isLoading,
                        color: Colors.black,
                        onTap: isLoading ? null : () => updateTaskAction(context),
                        label: "Update Task",
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
