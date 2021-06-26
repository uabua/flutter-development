import 'dart:ui';

import 'package:final_project/data/models/expense.dart';
import 'package:final_project/logic/cubit/expense_data/expense_data_cubit.dart';
import 'package:final_project/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditExpense extends StatefulWidget {
  final Expense expense;

  const EditExpense({
    Key? key,
    required this.expense,
  }) : super(key: key);

  @override
  _EditExpenseState createState() => _EditExpenseState();
}

class _EditExpenseState extends State<EditExpense> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController amount;
  late final TextEditingController title;
  late final TextEditingController date;

  @override
  void initState() {
    super.initState();
    amount = TextEditingController(
      text: widget.expense.amount.toString(),
    );
    title = TextEditingController(
      text: widget.expense.title,
    );
    date = TextEditingController(
      text: widget.expense.date,
    );
  }

  @override
  void dispose() {
    amount.dispose();
    title.dispose();
    date.dispose();
    super.dispose();
  }

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
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Card(
                  color: Colors.transparent,
                  shadowColor: Colors.transparent,
                  child: SizedBox(
                    child: TextFormField(
                      cursorColor: textDark,
                      cursorWidth: 1.0,
                      controller: amount,
                      decoration: const InputDecoration(
                        hintText: 'Please enter expense amount',
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: textDark,
                          ),
                        ),
                      ),
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            double.tryParse(value) == null ||
                            double.parse(value) < 0) {
                          return 'Please enter valid expense amount!';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Card(
                  color: Colors.transparent,
                  shadowColor: Colors.transparent,
                  child: SizedBox(
                    child: TextFormField(
                      cursorColor: textDark,
                      cursorWidth: 1.0,
                      controller: title,
                      decoration: const InputDecoration(
                        hintText: 'Please enter expense title',
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: textDark,
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter valid expense title!';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(date.text),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                        child: ElevatedButton(
                          onPressed: () {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(0),
                              lastDate: DateTime.now(),
                            ).then((value) {
                              if (value != null) {
                                date.text = value
                                    .toString()
                                    .substring(0, 10)
                                    .split('-')
                                    .reversed
                                    .join('/');

                                setState(() {});
                              }
                            });
                          },
                          child: const Text('Pick Date'),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              customDarkGreen,
                            ),
                            shape: MaterialStateProperty.all<OutlinedBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 3,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shadowColor: MaterialStateProperty.all<Color>(
                            Colors.transparent,
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            customDarkGreen,
                          ),
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            BlocProvider.of<ExpenseDataCubit>(context).update(
                              widget.expense.id,
                              Expense(
                                title: title.text,
                                amount: double.parse(amount.text),
                                date: date.text != 'Pick Date'
                                    ? date.text
                                    : DateTime.now()
                                        .toString()
                                        .substring(0, 10)
                                        .split('-')
                                        .reversed
                                        .join('/'),
                              ),
                            );

                            Navigator.pop(context);
                            Navigator.pop(context);
                          }
                        },
                        child: const Text('EDIT'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
