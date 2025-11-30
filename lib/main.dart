import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/task_bloc.dart';
import 'repository/task_storage.dart';
import 'screens/task_list_view.dart';
import 'bloc/task_events.dart';

void main() {
  runApp(const TaskApp());
}

class TaskApp extends StatelessWidget {
  const TaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => TaskStorage(),
      child: BlocProvider(
        create: (context) =>
            TaskBloc(context.read<TaskStorage>())..add(InitTasks()),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const TaskListView(),
        ),
      ),
    );
  }
}
