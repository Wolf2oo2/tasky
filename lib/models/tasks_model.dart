class TasksModel {
  final int id;
  final String taskName;
  final String taskDescription;
  final bool isHighPriority;
  bool isDone;

  TasksModel({
    required this.id,
    required this.taskName,
    required this.taskDescription,
    required this.isHighPriority,
    this.isDone = false,
  });

  factory TasksModel.fromJson(Map<String, dynamic> json) {
    return TasksModel(
      id: json["id"],
      taskName: json["taskName"],
      taskDescription: json["taskDescription"],
      isHighPriority: json['isHighPriority'],
      isDone: json['isDone'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      "taskName": taskName,
      "taskDescription": taskDescription,
      "isHighPriority": isHighPriority,
      "isDone": isDone,
    };
  }
}
