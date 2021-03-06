import 'package:final_project/data/models/expense.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:final_project/data/repositories/expense_repository.dart';

part 'expense_data_state.dart';

class ExpenseDataCubit extends Cubit<ExpenseDataState> {
  ExpenseDataCubit() : super(ExpenseDataInitial());

  final expenseRepository = ExpenseRepository();

  Future<void> create(Expense expense) async {
    emit(ExpenseDataInitial());

    try {
      await expenseRepository.create(expense);
    } catch (e) {
      emit(ExpenseDataError(
        message: e.toString(),
      ));
    }
  }

  Future<void> readAll() async {
    emit(ExpenseDataInitial());

    try {
      var expenses = await expenseRepository.readAll();

      emit(ExpenseDataLoaded(
        expenses: expenses,
      ));
    } catch (e) {
      emit(ExpenseDataError(
        message: e.toString(),
      ));
    }
  }

  Future<void> update(String docId, Expense expense) async {
    emit(ExpenseDataInitial());

    try {
      await expenseRepository.update(docId, expense);
    } catch (e) {
      emit(ExpenseDataError(
        message: e.toString(),
      ));
    }
  }

  Future<void> delete(String docId) async {
    emit(ExpenseDataInitial());

    try {
      await expenseRepository.delete(docId);
    } catch (e) {
      emit(ExpenseDataError(
        message: e.toString(),
      ));
    }
  }
}
