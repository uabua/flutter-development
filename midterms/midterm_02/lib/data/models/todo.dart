class Todo {
  late String id;
  final String topic;
  final String task;
  final String description;
  final bool isCompleted;

  Todo({
    required this.topic,
    required this.task,
    required this.description,
    required this.isCompleted,
  });

  Map<String, dynamic> toJson() {
    return {
      'topic': topic,
      'task': task,
      'description': description,
      'is_completed': isCompleted,
    };
  }
}
