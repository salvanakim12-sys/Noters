import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/task_bloc.dart';
import '../bloc/task_events.dart';
import '../bloc/task_states.dart';
import 'task_add_view.dart';
import 'task_edit_view.dart';
import '../models/task_model.dart';

class TaskListView extends StatelessWidget {
  const TaskListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Tasks")),
      body: BlocBuilder<TaskBloc, TaskView>(
        builder: (context, state) {
          if (state is TaskIdle) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is TaskReady) {
            final items = state.items;

            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, i) {
                final task = items[i];

                return ListTile(
                  title: Text(task.label),
                  leading: Checkbox(
                    value: task.done,
                    onChanged: (_) {
                      context.read<TaskBloc>().add(
                        ModifyTask(
                          task.clone(done: !task.done),
                        ),
                      );
                    },
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      context.read<TaskBloc>().add(RemoveTask(task));
                    },
                  ),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => TaskEditView(item: task),
                    ),
                  ),
                );
              },
            );
          }

          return const SizedBox();
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const TaskAddView()),
        ),
      ),
    );
  }
}
