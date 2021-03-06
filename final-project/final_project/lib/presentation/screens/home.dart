import 'package:final_project/logic/cubit/expense_data/expense_data_cubit.dart';
import 'package:final_project/presentation/screens/bottom_sheets/add_expense.dart';
import 'package:final_project/presentation/screens/bottom_sheets/expense_details.dart';
import 'package:final_project/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  static const routeName = '/home';
  final String userId;

  const Home({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: const Duration(
        seconds: 1,
      ),
      vsync: this,
    );

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ExpenseDataCubit, ExpenseDataState>(
        builder: (context, state) {
          if (state is ExpenseDataInitial) {
            BlocProvider.of<ExpenseDataCubit>(context)
                .expenseRepository
                .userId = widget.userId;

            BlocProvider.of<ExpenseDataCubit>(context).readAll();

            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ExpenseDataLoaded) {
            _animationController.forward();

            return Stack(
              children: [
                const Image(
                  image: AssetImage('assets/images/background.png'),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 25.0,
                    right: 25.0,
                    top: 50.0,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 40.0,
                          top: 40.0,
                          left: 5.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 5,
                              child: TweenAnimationBuilder(
                                curve: Curves.easeInOut,
                                tween: Tween<double>(
                                  begin: 0,
                                  end: 25,
                                ),
                                duration: const Duration(
                                  seconds: 1,
                                ),
                                builder: (context, double value, child) {
                                  return Text(
                                    'Personal Expenses',
                                    style: TextStyle(
                                      fontSize: value,
                                      color: textDark,
                                    ),
                                  );
                                },
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: MaterialButton(
                                padding: EdgeInsets.zero,
                                height: 45,
                                color: customDarkGreen,
                                shape: const CircleBorder(),
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return const AddExpense();
                                    },
                                  );
                                },
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 25,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 170,
                        width: double.infinity,
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 48,
                            ),
                            child: Text(
                              '${state.expenses.fold<double>(0, (previousAmount, element) => previousAmount + element.amount).toStringAsFixed(2)} \$',
                              style: const TextStyle(
                                color: textDark,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0.0, 1.5),
                            end: Offset.zero,
                          ).animate(
                            CurvedAnimation(
                              parent: _animationController,
                              curve: Curves.easeInOutCubic,
                            ),
                          ),
                          child: ListView.builder(
                            itemCount: state.expenses.length,
                            itemBuilder: (context, index) {
                              var expense = state.expenses[index];

                              return Card(
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                child: ListTile(
                                  title: Text(expense.title),
                                  subtitle: Text(expense.date.toString()),
                                  trailing: Text('${expense.amount} \$'),
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return ExpenseDetails(
                                          expense: expense,
                                        );
                                      },
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: Text('Ops! Something went wrong!'),
            );
          }
        },
        listener: (context, state) {
          if (state is ExpenseDataError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
      ),
    );
  }
}
