import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/data/models/expense.dart';

final CollectionReference _expensesCollectionReference =
    FirebaseFirestore.instance.collection('expenses');

class ExpenseRepository {
  String? userId;

  Future<void> create(Expense expense) async {
    DocumentReference expenseDocumentReference = _expensesCollectionReference
        .doc(userId)
        .collection('user expenses')
        .doc();

    await expenseDocumentReference
        .set(expense.toJson())
        .whenComplete(() => print('Expense is added!'))
        .catchError((errorMessage) => throw Exception(errorMessage));
  }

  Future<List<Expense>> readAll() async {
    List<Expense> expenses = [];
    CollectionReference expenseCollectionReference =
        _expensesCollectionReference.doc(userId).collection('user expenses');

    final userExpenses = await expenseCollectionReference
        .orderBy('date', descending: true)
        .get();

    for (var doc in userExpenses.docs) {
      var expense = Expense(
        title: doc['title'],
        amount: doc['amount'],
        date: doc['date'],
      );

      expense.id = doc.id;

      expenses.add(expense);
    }

    return expenses;
  }

  Future<void> update(String docId, Expense expense) async {
    DocumentReference documentReference = _expensesCollectionReference
        .doc(userId)
        .collection('user expenses')
        .doc(docId);

    await documentReference
        .update(expense.toJson())
        .whenComplete(() => print('Expense is updated!'))
        .catchError((errorMessage) => throw Exception(errorMessage));
  }

  Future<void> delete(String docId) async {
    DocumentReference documentReference = _expensesCollectionReference
        .doc(userId)
        .collection('user expenses')
        .doc(docId);

    await documentReference
        .delete()
        .whenComplete(() => print('Expense is deleted!'))
        .catchError((errorMessage) => throw Exception(errorMessage));
  }
}
