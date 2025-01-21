import 'package:uuid/uuid.dart';

class TaskModel {
  final String taskTitle;
  final String uuid;
  final bool isDone;
  final DateTime? createdAt;
  final DateTime? deletedAt;

  const TaskModel(
      {required this.taskTitle,
      required this.uuid,
      required this.isDone,
      required this.createdAt,
      required this.deletedAt});

  TaskModel.newTaskModel(this.isDone, this.taskTitle)
      : uuid = const Uuid().v4(),
        createdAt = DateTime.now(),
        deletedAt = null;

  TaskModel copyWith(
      {String? taskTitle,
      bool? isDone,
      DateTime? createdAt,
      DateTime? deletedAt}) {
    return TaskModel(
        uuid: uuid,
        taskTitle: taskTitle ?? this.taskTitle,
        isDone: isDone ?? this.isDone,
        createdAt: createdAt ?? this.createdAt,
        deletedAt: deletedAt ?? this.deletedAt);
  }

  Map<String, dynamic> toJson() {
    return {
      'taskTitle': taskTitle,
      'uuid': uuid,
      'isDone': isDone,
      'createdAt': createdAt?.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
    };
  }

  // Десериализация из JSON
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      taskTitle: json['taskTitle'] ?? '',
      uuid: json['uuid'] ?? 0,
      isDone: json['isDone'] ?? false,
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      deletedAt:
          json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
    );
  }
}
