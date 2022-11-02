import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// ignore: unused_import
import 'package:provider_listview/models/task.dart';
import 'package:provider_listview/service/tasklist.dart';

class crudTaskPage extends StatefulWidget {
  final String taskName;
  const crudTaskPage({super.key, required this.taskName});

  @override
  // ignore: override_on_non_overriding_member
  State<crudTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<crudTaskPage> {
  final TextEditingController _textName = TextEditingController();
  final _key = GlobalKey<FormState>();
  bool enable = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Task ${widget.taskName}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Form(
              key: _key,
              child: TextFormField(
                  initialValue: widget.taskName,
                  decoration: const InputDecoration(
                    hintText: "Edit Task",
                  ),
                  keyboardType: TextInputType.text,
                  validator: (String? value) {
                    if (value != '') {
                      if (value!.length < 5) {
                        return 'Task input must be more than 5';
                      } else {
                        return null;
                      }
                    } else {
                      return "Task input cannot be blank!";
                    }
                  },
                  onChanged: (value) {
                    setState(() {
                      // 2
                      if (value.isNotEmpty) {
                        if (value.length < 5) {
                          enable = false;
                        } else {
                          enable = true;
                        }
                      } else {
                        enable = false;
                      }
                    });
                    context.read<Tasklist>().changeTaskName(value);
                  }),
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: (enable)
                        ? () {
                            context
                                .read<Tasklist>()
                                .updateTask(widget.taskName);
                            Navigator.pop(context);
                            // print('OK');
                          }
                        : null,
                    child: const Text("Edit Task"),
                  ),
                ),
                // Expanded(
                //   child: ElevatedButton(
                //     onPressed: () {
                //       context.read<Tasklist>().deleteTask(widget.taskName);
                //       Navigator.pop(context);
                //     },
                //     child: const Text("Delete Task"),
                //   ),
                // ),
              ],
            )
          ],
        ),
      ),
    );
    ;
  }
}
