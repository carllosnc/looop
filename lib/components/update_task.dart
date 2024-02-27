import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';
import 'package:vw/vw.dart';
import '/imports/app.dart';

updateTask({
  required BuildContext context,
  required Task task,
}) {
  VWPage.open(
    level: 2,
    appBar: AppBar(
      title: const Text('Edit Task'),
    ),
    context: context,
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

  @override
  void initState() {
    super.initState();
    titleController.text = widget.task.title;
    rememberHour = widget.task.hour;
    icon = widget.task.icon;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                        labelText: "Título da tarefa",
                        floatingLabelAlignment: FloatingLabelAlignment.start,
                        suffixIcon: Icon(Icons.edit),
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
                        labelText: "Horário",
                        floatingLabelAlignment: FloatingLabelAlignment.start,
                        suffixIcon: Icon(Icons.access_time),
                      ),
                      onChanged: (value) {
                        setState(() {
                          String minute = value.minute.toString().length == 1 ? "0${value.minute}" : value.minute.toString();
                          String hour = value.hour.toString().length == 1 ? "0${value.hour}" : value.hour.toString();

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
                      color: Colors.black,
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          await TaskService.updateTask(
                            task: widget.task,
                            title: titleController.text,
                            hour: rememberHour,
                            icon: icon,
                            lastCheck: widget.task.lastCheck,
                          );

                          if (context.mounted) {
                            Navigator.of(context).pop();
                          }
                        }
                      },
                      label: "Update Task",
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
