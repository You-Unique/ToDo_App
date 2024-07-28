// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:todo_app/database.dart';
import 'package:todo_app/task.dart';

class AddTaskScreen extends StatefulWidget {
  final Task? task;
  const AddTaskScreen({super.key, this.task});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  late final TextEditingController _titleController = TextEditingController(
    text: widget.task?.title,
  );

  TaskDatabase taskDatabase = TaskDatabase.taskDatabase;

  DateTime? startDateTime;
  DateTime? endDateTime;

  @override
  void initState() {
    setValue();
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void setValue() {
    if (widget.task != null) {
      setState(() {
        startDateTime = widget.task?.startDateTime;
        endDateTime = widget.task?.endDateTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task == null ? 'Add Task' : 'Edit Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                  hintText: 'Type in task name',
                  hintStyle: TextStyle(
                    fontSize: 12,
                  ),
                  labelText: 'Title',
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  )),
            ),
            const SizedBox(
              height: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                    onTap: () async {
                      final tempDateTime = await getDateTime(context);

                      setState(() {
                        startDateTime = tempDateTime;
                      });
                    },
                    child:
                        Text('Start Time: ${startDateTime?.toString() ?? ''}')),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                    onTap: () async {
                      final tempDateTime = await getDateTime(context);

                      setState(() {
                        endDateTime = tempDateTime;
                      });
                    },
                    child: Text('End Time: ${endDateTime?.toString() ?? ''}')),
              ],
            ),
            const Spacer(),
            GestureDetector(
              onTap: () async {
                if (_titleController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please input a title'),
                    ),
                  );
                  return;
                }
                if (startDateTime == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please input a start time'),
                    ),
                  );
                  return;
                }
                if (endDateTime == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please input a end time'),
                    ),
                  );
                  return;
                }

                Task task = Task(
                  endDateTime: endDateTime,
                  startDateTime: startDateTime,
                  title: _titleController.text,
                );
                var reponse = await taskDatabase.addTask(task);

                if (reponse == true) {
                  Navigator.pop(context, true);
                }
              },
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black,
                ),
                child: const Center(
                  child: Text(
                    'Save',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }

  Future<DateTime?> getDateTime(BuildContext context) async {
    final tempDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(3000),
    );

    if (tempDate == null) {
      return null;
    }

    final tempTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());

    if (tempTime == null) {
      return null;
    }

    return DateTime(
      tempDate.year,
      tempDate.month,
      tempDate.day,
      tempTime.hour,
      tempTime.minute,
    );
  }
}
