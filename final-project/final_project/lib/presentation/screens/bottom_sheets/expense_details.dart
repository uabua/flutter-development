import 'dart:ui';

import 'package:final_project/data/models/expense.dart';
import 'package:final_project/logic/cubit/expense_data/expense_data_cubit.dart';
import 'package:final_project/presentation/screens/bottom_sheets/edit_expense.dart';
import 'package:final_project/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseDetails extends StatelessWidget {
  final Expense expense;

  const ExpenseDetails({
    Key? key,
    required this.expense,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 10,
        sigmaY: 10,
      ),
      child: Container(
        color: bottomSheetBackground,
        child: Padding(
          padding: const EdgeInsets.all(35.0),
          child: Column(
            children: [
              Text(
                expense.title,
                style: Theme.of(context).textTheme.headline4,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Expense Amount'),
                  Text('${expense.amount} \$'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Date:'),
                  Text(expense.date),
                ],
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    MaterialButton(
                      padding: EdgeInsets.zero,
                      color: customDarkGreen,
                      shape: const CircleBorder(),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return EditExpense(expense: expense);
                          },
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ),
                    MaterialButton(
                      padding: EdgeInsets.zero,
                      color: customDarkGreen,
                      shape: const CircleBorder(),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Delete Confirmation'),
                              content: const Text(
                                'Are you sure you want to permanently delete this expense record?',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    'Cancel',
                                    style: TextStyle(
                                      color: textDark,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.red),
                                    foregroundColor:
                                        MaterialStateProperty.all(Colors.white),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);

                                    BlocProvider.of<ExpenseDataCubit>(context)
                                        .delete(expense.id);

                                    Navigator.pop(context);

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          '${expense.title} successfully deleted.',
                                        ),
                                        backgroundColor: customDarkGreen,
                                      ),
                                    );
                                  },
                                  child: const Text('Delete'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
