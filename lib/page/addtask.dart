import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_listview/service/tasklist.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TextEditingController _textName = TextEditingController();
  final _key = GlobalKey<FormState>();
  bool enable = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Task Baru"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Form(
              key: _key,
              child: TextFormField(
                controller: _textName,
                decoration: const InputDecoration(
                  hintText: "Masukkan Task Baru",
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
                    if (_textName.text.isNotEmpty) {
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
                },
              ),
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
                            if (_textName.text.isNotEmpty) {
                              if (_key.currentState!.validate()) {
                                _key.currentState!.save();
                                context.read<Tasklist>().addTask();
                                Navigator.pop(context);
                              }
                            } else {
                              return;
                            }
                          }
                        : null,
                    child: const Text("Tambah Task Baru"),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
