import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:midterm_02/data/models/todo.dart';

final CollectionReference _todosCollectionReference =
    FirebaseFirestore.instance.collection('todos');

class TodoRepository {
  String? userId;

  Future<void> create(Todo todo) async {
    DocumentReference todoDocumentReference =
        _todosCollectionReference.doc(userId).collection('user todos').doc();

    await todoDocumentReference
        .set(todo.toJson())
        .whenComplete(() => print('Todo is added!'))
        .catchError((errorMessage) => throw Exception(errorMessage));
  }

  Future<List<Todo>> readAll() async {
    List<Todo> todos = [];
    CollectionReference todoCollectionReference =
        _todosCollectionReference.doc(userId).collection('user todos');

    final userTodos = await todoCollectionReference.orderBy('topic').get();

    for (var doc in userTodos.docs) {
      var todo = Todo(
        topic: doc['topic'],
        task: doc['task'],
        description: doc['description'],
        isCompleted: doc['is_completed'],
      );

      todo.id = doc.id;

      todos.add(todo);
    }

    return todos;
  }

  Future<void> update(String docId, Todo todo) async {
    DocumentReference documentReference = _todosCollectionReference
        .doc(userId)
        .collection('user todos')
        .doc(docId);

    await documentReference
        .update(todo.toJson())
        .whenComplete(() => print('Todo is updated!'))
        .catchError((errorMessage) => throw Exception(errorMessage));
  }

  Future<void> toggleCompletion(String docId, bool isCompleted) async {
    DocumentReference documentReference = _todosCollectionReference
        .doc(userId)
        .collection('user todos')
        .doc(docId);

    await documentReference
        .update({'is_completed': !isCompleted})
        .whenComplete(() => print('Todo is completed!'))
        .catchError((errorMessage) => throw Exception(errorMessage));
  }

  Future<void> delete(String docId) async {
    DocumentReference documentReference = _todosCollectionReference
        .doc(userId)
        .collection('user todos')
        .doc(docId);

    await documentReference
        .delete()
        .whenComplete(() => print('Todo is deleted!'))
        .catchError((errorMessage) => throw Exception(errorMessage));
  }
}
