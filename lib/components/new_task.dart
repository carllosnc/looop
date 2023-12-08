import 'package:flutter/material.dart';
import 'package:vw/vw.dart';
import '/imports/app.dart';

class NewTask extends StatelessWidget {
  const NewTask({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.black,
      maxRadius: 18,
      child: IconButton(
        iconSize: 20,
        padding: const EdgeInsets.all(0),
        icon: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
          VWPage.open(
            context: context,
            borderRadius: 20,
            appBar: AppBar(
              title: const Text('Nova tarefa'),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
            ),
            body: const FormTask(),
            bottomBar: const VWRow(
              padding: EdgeInsets.all(10),
              children: [
                VWButton(
                  color: Colors.black,
                  fullWidth: true,
                  label: "Registrar tarefa",
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class FormTask extends StatelessWidget {
  const FormTask({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return VWColumn(
      children: [
        Form(
          child: VWColumn(
            children: [
              VWColumn(
                gap: 0,
                padding: const EdgeInsets.symmetric(horizontal: 30),
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Título da tarefa",
                      floatingLabelAlignment: FloatingLabelAlignment.start,
                      suffixIcon: Icon(Icons.edit),
                    ),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Descrição",
                      floatingLabelAlignment: FloatingLabelAlignment.start,
                      suffixIcon: Icon(Icons.edit),
                    ),
                  ),
                  VWTimePicker(
                    builder: (context, child) => MediaQuery(
                      data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                      child: child!,
                    ),
                    decoration: const InputDecoration(
                      labelText: "Horário",
                      floatingLabelAlignment: FloatingLabelAlignment.start,
                      suffixIcon: Icon(Icons.access_time),
                    ),
                    onChanged: (value) {
                      print(value);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 30),
              const EmojiSelect()
            ],
          ),
        )
      ],
    );
  }
}
