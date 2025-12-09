import 'package:flutter/material.dart';
import 'package:app/expenses tracker/model/expenses.dart';

class overlay extends StatefulWidget {
  const overlay({super.key, required this.onAddExpense});
  final Function(Expenses expense) onAddExpense;

  @override
  State<overlay> createState() => _overlayState();
}

class _overlayState extends State<overlay> {
  DateTime? _selectedDate;
  ExpenseCategory _selectedCategory = ExpenseCategory.entertainment;

  late final TextEditingController _expensecontroller;
  late final TextEditingController _amountcontroller;
  late final TextEditingController _desccontroller;

  @override
  void initState() {
    super.initState();
    _expensecontroller = TextEditingController();
    _amountcontroller = TextEditingController();
    _desccontroller = TextEditingController();
  }

  @override
  void dispose() {
    _expensecontroller.dispose();
    _amountcontroller.dispose();
    _desccontroller.dispose();
    super.dispose();
  }

  Future<void> _presentDatePicker() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (pickedDate == null) return;

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void onSubmit() {
    if (_selectedDate == null) return;

    final newExpense = Expenses(
      title: _expensecontroller.text.trim(),
      description: _desccontroller.text.trim(),
      amount: double.parse(_amountcontroller.text.trim()),
      date: _selectedDate!,
      category: _selectedCategory,
    );

    widget.onAddExpense(newExpense);
    Navigator.pop(context);
  }

  void onCancle() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            SizedBox(height: 25),

            Text(
              'enter new expnese'.toUpperCase(),
              style: TextStyle(
                color: Colors.blueAccent,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 50),

            TextField(
              controller: _expensecontroller,
              style: TextStyle(color: Colors.white),
              maxLength: 25,
              cursorColor: Colors.white,
              decoration: InputDecoration(
                label: Text('enter the expense'),
                labelStyle: const TextStyle(color: Colors.white),

                prefixIcon: const Icon(Icons.list_alt, color: Colors.green),

                filled: true,
                fillColor: Colors.black26,

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(9)),
                ),

                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey),
                ),

                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey, width: 2),
                ),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: _desccontroller,
              style: const TextStyle(color: Colors.white),
              cursorColor: Colors.white,
              maxLength: 60,
              decoration: InputDecoration(
                labelText: "Enter the description",
                labelStyle: const TextStyle(color: Colors.white),

                prefixIcon: const Icon(Icons.attach_money, color: Colors.green),

                filled: true,
                fillColor: Colors.black26,

                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey),
                ),

                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.grey, width: 2),
                ),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(9)),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _amountcontroller,
                    style: const TextStyle(color: Colors.white),
                    keyboardType: TextInputType.numberWithOptions(),
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      labelText: "Enter the amount",
                      labelStyle: const TextStyle(color: Colors.white),

                      prefixIcon: const Icon(
                        Icons.attach_money,
                        color: Colors.green,
                      ),

                      filled: true,
                      fillColor: Colors.black26,

                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey),
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 2,
                        ),
                      ),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(9)),
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 40),

                Expanded(
                  child: Text(
                    _selectedDate == null
                        ? 'No date chosen!'
                        : 'Picked date: ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                TextButton.icon(
                  style: TextButton.styleFrom(foregroundColor: Colors.white),
                  onPressed: _presentDatePicker,
                  icon: const Icon(Icons.calendar_today, color: Colors.white),
                  label: const Text('Choose Date'),
                ),
              ],
            ),

            SizedBox(height: 50),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    color: Colors.black,
                  ),
                  child: DropdownButton(
                    value: _selectedCategory,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    dropdownColor: Colors.black,
                    padding: EdgeInsets.all(8),
                    underline: Container(),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    items: ExpenseCategory.values
                        .map(
                          (expense) => DropdownMenuItem(
                            value: expense,
                            child: Text(expense.name),
                          ),
                        )
                        .toList(),
                    onChanged: (ExpenseCategory? newValue) {
                      if (newValue != null) {
                        setState(() {
                          _selectedCategory = newValue;
                        });
                      }
                    },
                  ),
                ),
                Row(
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        onCancle();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'cancle',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(width: 10),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                      onPressed: () {
                        onSubmit();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'submit',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
