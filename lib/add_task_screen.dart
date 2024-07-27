import 'dart:developer';

import 'package:flutter/material.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _titleController = TextEditingController();

  DateTimeRange? dateTime;

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task'),
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
            // GestureDetector(
            //          onTap: () async {
            //     final tempDateTime = await showDateRangePicker(
            //         context: context,
            //         firstDate: DateTime.now(),
            //         lastDate: DateTime(3000));

            //     setState(() {
            //       dateTime = tempDateTime;
            //     });
            //   },
            //   child: Text("Start Time: ${dateTime?.start.toString() ?? ''} End Time: ${dateTime?.end.toString() ?? ''} ")),
            GestureDetector(
              onTap: () async {
                final tempDateTime = await showDateRangePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(3000));

                setState(() {
                  dateTime = tempDateTime;
                });
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Start Time: ${dateTime?.start.toString() ?? ''}'),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('End Time: ${dateTime?.end.toString() ?? ''}'),
                ],
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
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
}
