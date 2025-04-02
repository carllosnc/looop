import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';
import 'package:vw/vw.dart';
import '/imports.dart';
import 'emoji_select.dart';

openNewTask(BuildContext context) {
  context.openSheet(
    appBar: AppBar(
      title: 'New task'.pageTitle,
    ),
    body: const FormNewTask(),
  );
}

class FormNewTask extends StatefulWidget {
  const FormNewTask({
    super.key,
  });

  @override
  State<FormNewTask> createState() => _FormNewTaskState();
}

class _FormNewTaskState extends State<FormNewTask> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  String timer = "";
  String emoji = "";
  bool isLoading = false;

  createTaskAction(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      await TaskService.addTask(
        title: titleController.text,
        hour: timer,
        icon: emoji,
      );

      setState(() {
        isLoading = false;
      });

      if (context.mounted) {
        Navigator.pop(context);
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

                            timer = "$hour:$minute";
                          });
                        },
                      ),
                      EmojiSelect(
                        validator: Validatorless.required("Required field"),
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                        onChanged: (value) {
                          emoji = value!;
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      VWButton(
                        color: Colors.black,
                        isLoading: isLoading,
                        onTap: isLoading ? null : () => createTaskAction(context),
                        label: "Add task",
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
