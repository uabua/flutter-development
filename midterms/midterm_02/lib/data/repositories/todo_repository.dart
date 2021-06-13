import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:midterm_02/data/models/todo.dart';

final CollectionReference _todosCollectionReference =
    FirebaseFirestore.instance.collection('todos');

class TodoRepository {
  static String? userId;

  Future<void> create(Todo todo) async {
    DocumentReference documentReference =
        _todosCollectionReference.doc(userId).collection('user todos').doc();

    await documentReference
        .set(todo.toJson())
        .whenComplete(() => print('Todo is added!'))
        .catchError((errorMessage) => print(errorMessage));
  }

  Future<List<Todo>> readAll() async {
    List<Todo> todos = [];
    CollectionReference todoReference =
        _todosCollectionReference.doc(userId).collection('user todos');

    final reference = await todoReference.get();

    for (var doc in reference.docs) {
      var todo = Todo(
        topic: doc['topic'],
        task: doc['task'],
        description: doc['description'],
      );

      todo.id = doc.id;

      todos.add(todo);
    }

    return todos;
  }

  //აფდეითი აქ

  Future<void> delete(String docId) async {
    DocumentReference documentReference = _todosCollectionReference
        .doc(userId)
        .collection('user todos')
        .doc(docId);

    await documentReference
        .delete()
        .whenComplete(() => print('Todo is deleted!'))
        .catchError((errorMessage) => print(errorMessage));
  }
}
