import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/task_model.dart';
import '../repository/task_storage.dart';
import 'task_events.dart';
import 'task_states.dart';

class TaskBloc extends Bloc<TaskAction, TaskView> {
  final TaskStorage storage;

  TaskBloc(this.storage) : super(TaskIdle()) {
    on<InitTasks>(_onInit);
    on<CreateTask>(_onCreate);
    on<ModifyTask>(_onModify);
    on<RemoveTask>(_onRemove);
  }

  Future<void> _onInit(InitTasks e, Emitter emit) async {
    final tasks = await storage.fetchTasks();
    emit(TaskReady(tasks));
  }

  Future<void> _onCreate(CreateTask e, Emitter emit) async {
    if (state is! TaskReady) return;
    final current = (state as TaskReady).items;

    final item = TaskItem(
      uid: DateTime.now().millisecondsSinceEpoch.toString(),
      label: e.label,
    );

    final updated = [...current, item];
    await storage.persist(updated);
    emit(TaskReady(updated));
  }

  Future<void> _onModify(ModifyTask e, Emitter emit) async {
    if (state is! TaskReady) return;
    final current = (state as TaskReady).items;

    final updated =
        current.map((t) => t.uid == e.updated.uid ? e.updated : t).toList();

    await storage.persist(updated);
    emit(TaskReady(updated));
  }

  Future<void> _onRemove(RemoveTask e, Emitter emit) async {
    if (state is! TaskReady) return;
    final current = (state as TaskReady).items;

    final updated = current.where((t) => t.uid != e.target.uid).toList();

    await storage.persist(updated);
    emit(TaskReady(updated));
  }
}
