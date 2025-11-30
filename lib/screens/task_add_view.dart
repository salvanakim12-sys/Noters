import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/task_bloc.dart';
import '../bloc/task_events.dart';

class TaskAddView extends StatefulWidget {
  const TaskAddView({super.key});

  @override
  State<TaskAddView> createState() => _TaskAddViewState();
}

class _TaskAddViewState extends State<TaskAddView> {
  final ctrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Task")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: ctrl,
              decoration: const InputDecoration(labelText: "Task name"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.read<TaskBloc>().add(CreateTask(ctrl.text));
                Navigator.pop(context);
              },
              child: const Text("Save"),
            )
          ],
        ),
      ),
    );
  }
}
