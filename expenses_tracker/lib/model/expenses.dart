import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

enum ExpenseCategory { food, transport, entertainment, utilities, others }

// ignore: constant_identifier_names
const CategoryIcons = {
  ExpenseCategory.food: '🍔',
  ExpenseCategory.transport: '🚌',
  ExpenseCategory.entertainment: '🎬',
  ExpenseCategory.utilities: '💡',
  ExpenseCategory.others: '🛒',
};

const uuid = Uuid();
final formatter = DateFormat.yMd();

class Expenses {
  final String id;
  final String title;
  final String description;
  final double amount;
  final DateTime date;
  final ExpenseCategory category;

  Expenses({
    required this.description,
    required this.amount,
    required this.date,
    required this.title,
    required this.category,
  }) : id = uuid.v4();

  String get formattedDate {
    return formatter.format(date);
  }
}
