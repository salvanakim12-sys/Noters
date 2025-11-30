import '../models/task_model.dart';

abstract class TaskView {}

class TaskIdle extends TaskView {}

class TaskReady extends TaskView {
  final List<TaskItem> items;
  TaskReady(this.items);
}
