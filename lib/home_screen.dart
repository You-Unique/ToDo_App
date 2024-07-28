import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todo_app/add_task_screen.dart';
import 'package:todo_app/database.dart';
import 'package:todo_app/task.dart';
import 'package:todo_app/task_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> tasks = [];
  TaskDatabase taskDatabase = TaskDatabase.taskDatabase;

  bool? checkBoxValue = false;

  @override
  void initState() {
    test();
    super.initState();
  }

  void test() async {
    var tempTask = await taskDatabase.getAllTask();

    setState(() {
      tasks = tempTask;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed: () async {
            bool? response = await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const AddTaskScreen(),
            ));

            if (response != null && response == true) {
              test();
            }
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        appBar: AppBar(
          leading: const SizedBox(),
          title: const Text('Home'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "TODOS",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ...tasks.map(
                (e) => TaskCard(task: e),
              )
            ],
          ),
        ),
      ),
    );
  }
}
