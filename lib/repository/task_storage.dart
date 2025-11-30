import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task_model.dart';

class TaskStorage {
  final String storageKey = "task_data";

  Future<List<TaskItem>> fetchTasks() async {
    final pref = await SharedPreferences.getInstance();
    final raw = pref.getString(storageKey);

    if (raw == null) return [];

    final List decoded = jsonDecode(raw);
    return decoded.map((e) => TaskItem.fromJson(e)).toList();
  }

  Future<void> persist(List<TaskItem> items) async {
    final pref = await SharedPreferences.getInstance();
    final jsonStr = jsonEncode(items.map((e) => e.toJson()).toList());
    await pref.setString(storageKey, jsonStr);
  }
}
