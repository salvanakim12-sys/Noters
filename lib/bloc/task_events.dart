import '../models/task_model.dart';

abstract class TaskAction {}

class InitTasks extends TaskAction {}

class CreateTask extends TaskAction {
  final String label;
  CreateTask(this.label);
}

class ModifyTask extends TaskAction {
  final TaskItem updated;
  ModifyTask(this.updated);
}

class RemoveTask extends TaskAction {
  final TaskItem target;
  RemoveTask(this.target);
}
