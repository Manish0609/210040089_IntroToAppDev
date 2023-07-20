import 'package:flutter/material.dart';

void main() {
  runApp(BudgetTrackerApp());
}

class BudgetTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Budget Tracker App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: BudgetTrackerPage(),
    );
  }
}

class BudgetTrackerPage extends StatefulWidget {
  @override
  _BudgetTrackerPageState createState() => _BudgetTrackerPageState();
}

class _BudgetTrackerPageState extends State<BudgetTrackerPage> {
  double balance = 0.0;
  List<double> expenses = [];

  void addIncome(double amount) {
    setState(() {
      balance += amount;
    });
  }

  void addExpense(double amount) {
    if (balance - amount >= 0) {
      setState(() {
        balance -= amount;
        expenses.add(amount);
      });
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Insufficient Funds'),
            content: Text('You do not have enough balance to add this expense.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  void viewExpenses() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Expenses'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: expenses
                .map((expense) => Text('\$${expense.toStringAsFixed(2)}'))
                .toList(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Budget Tracker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Balance: \$${balance.toStringAsFixed(2)}'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _showAddIncomeDialog(),
              child: Text('Add Income'),
            ),
            ElevatedButton(
              onPressed: () => _showAddExpenseDialog(),
              child: Text('Add Expense'),
            ),
            ElevatedButton(
              onPressed: () => viewExpenses(),
              child: Text('View Expenses'),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddIncomeDialog() {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController incomeController = TextEditingController();
        return AlertDialog(
          title: Text('Add Income'),
          content: TextField(
            controller: incomeController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(labelText: 'Amount'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                double income = double.parse(incomeController.text);
                addIncome(income);
                Navigator.pop(context);
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _showAddExpenseDialog() {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController expenseController = TextEditingController();
        return AlertDialog(
          title: Text('Add Expense'),
          content: TextField(
            controller: expenseController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(labelText: 'Amount'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                double expense = double.parse(expenseController.text);
                addExpense(expense);
                Navigator.pop(context);
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
