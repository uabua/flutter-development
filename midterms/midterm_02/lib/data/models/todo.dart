class Todo {
  late String id;
  final String topic;
  final String task;
  final String description;

  Todo({
    required this.topic,
    required this.task,
    required this.description,
  });

  Todo.fromJson(Map<String, dynamic> json)
      : topic = json['topic'],
        task = json['task'],
        description = json['description'];

  Map<String, dynamic> toJson() {
    return {
      'topic': topic,
      'task': task,
      'description': description,
    };
  }
}
