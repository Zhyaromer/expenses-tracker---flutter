import 'package:app/expenses%20tracker/model/expenses.dart';
import 'package:app/expenses%20tracker/widgets/overlay.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: MyWidget(), debugShowCheckedModeBanner: false));
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  void openOverlayModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        return overlay(onAddExpense: addExpense);
      },
    );
  }

  final List<Expenses> _dummyExpenses = [
    Expenses(
      title: "iuygbdasiu",
      description: 'Lunch at Cafe',
      amount: 15.50,
      date: DateTime.now().subtract(Duration(days: 1)),
      category: ExpenseCategory.food,
    ),
    Expenses(
      title: "iuygbdasiu",
      description: 'Movie tickets',
      amount: 28.00,
      date: DateTime.now().subtract(Duration(days: 3)),
      category: ExpenseCategory.entertainment,
    ),
    Expenses(
      title: "iuygbdasiu",
      description: 'Bus pass',
      amount: 9.75,
      date: DateTime.now().subtract(Duration(days: 2)),
      category: ExpenseCategory.transport,
    ),
  ];

  void addExpense(Expenses expense) {
    setState(() {
      _dummyExpenses.add(expense);
    });
  }

  void removeExpenses(int index) {
    final removedExpense = _dummyExpenses[index];

    setState(() {
      _dummyExpenses.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Expense deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _dummyExpenses.insert(index, removedExpense);
            });
          },
        ),
      ),
    );
  }

  double get totalAmount {
    double sum = 0;
    for (var expense in _dummyExpenses) {
      sum += expense.amount;
    }
    return sum;
  }

  Object get mostExpensiveExpenses {
    if (_dummyExpenses.isEmpty) return 'No expenses';
    final mostExpensive = _dummyExpenses.reduce(
      (a, b) => a.amount > b.amount ? a : b,
    );
    return mostExpensive.category;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'expenses tracker app',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black87,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.white),
            onPressed: () {
              openOverlayModal();
            },
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        color: Colors.grey[800],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: Text(
                'view and analyze your expenses easily',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),

            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 130,
                  height: 130,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 106, 155, 131),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Text(
                        textAlign: TextAlign.center,
                        'your total spent is',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),

                      SizedBox(height: 10),

                      Text(
                        textAlign: TextAlign.center,
                        '\$$totalAmount',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 50),
                Container(
                  width: 130,
                  height: 130,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 106, 155, 131),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Text(
                        textAlign: TextAlign.center,
                        'your most expensive category is',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),

                      SizedBox(height: 10),

                      Text(
                        textAlign: TextAlign.center,
                        (mostExpensiveExpenses as ExpenseCategory).name,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: _dummyExpenses.length,
                itemBuilder: (context, i) {
                  final expense = _dummyExpenses[i];
                  return SizedBox(
                    width: double.infinity,
                    height: 170,
                    child: Card(
                      margin: EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 10,
                      ),
                      color: Colors.grey[700],
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: Colors.blue[500],
                              ),
                              child: Icon(
                                Icons.fastfood,
                                size: 60,
                                color: Colors.white,
                              ),
                            ),

                            SizedBox(width: 16),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    expense.title,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    expense.description,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white70,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    expense.formattedDate,
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white70,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '\$${expense.amount.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),

                                SizedBox(height: 10),

                                IconButton(
                                  color: const Color.fromARGB(255, 226, 79, 68),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text('Delete Expense'),
                                          content: Text(
                                            'Are you sure you want to delete this expense?',
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: Text('Cancel'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                removeExpenses(i);
                                                Navigator.pop(context);
                                              },
                                              child: Text('Delete'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  icon: Icon(Icons.delete),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
