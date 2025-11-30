class TaskItem {
  final String uid;
  final String label;
  final bool done;

  TaskItem({
    required this.uid,
    required this.label,
    this.done = false,
  });

  TaskItem clone({
    String? uid,
    String? label,
    bool? done,
  }) {
    return TaskItem(
      uid: uid ?? this.uid,
      label: label ?? this.label,
      done: done ?? this.done,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "label": label,
      "done": done,
    };
  }

  factory TaskItem.fromJson(Map<String, dynamic> json) {
    return TaskItem(
      uid: json["uid"],
      label: json["label"],
      done: json["done"],
    );
  }
}
