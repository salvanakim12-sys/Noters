import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/task_bloc.dart';
import '../bloc/task_events.dart';
import '../models/task_model.dart';

class TaskEditView extends StatefulWidget {
  final TaskItem item;
  const TaskEditView({super.key, required this.item});

  @override
  State<TaskEditView> createState() => _TaskEditViewState();
}

class _TaskEditViewState extends State<TaskEditView> {
  late TextEditingController ctrl;

  @override
  void initState() {
    super.initState();
    ctrl = TextEditingController(text: widget.item.label);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Task")),
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
                final updated =
                    widget.item.clone(label: ctrl.text);
                context.read<TaskBloc>().add(ModifyTask(updated));
                Navigator.pop(context);
              },
              child: const Text("Update"),
            )
          ],
        ),
      ),
    );
  }
}
