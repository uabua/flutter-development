class Expense {
  late String id;
  final String title;
  final int amount;
  final DateTime date;

  Expense({
    required this.title,
    required this.amount,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'amount': amount,
      'date': date,
    };
  }
}
