import 'package:flutter/material.dart';

void main() {
  runApp(BudgetTrackerApp());
}

class BudgetTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Budget Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Budget Tracker'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Welcome, User!',
              style: TextStyle(fontSize: 24.0),
            ),
          ),
          Text(
            'Total Expenses: \$0',
            style: TextStyle(fontSize: 18.0),
          ),
          Expanded(
            child: ListView(
              children: [
                CategoryItem('Category 1'),
                CategoryItem('Category 2'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String categoryName;

  CategoryItem(this.categoryName);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(categoryName),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ExpenseScreen(categoryName),
          ),
        );
      },
    );
  }
}

class ExpenseScreen extends StatelessWidget {
  final String categoryName;

  ExpenseScreen(this.categoryName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                ExpenseItem('Expense 1'),
                ExpenseItem('Expense 2'),
                ExpenseItem('Expense 3'),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddExpenseScreen(),
                ),
              );
            },
            child: Text('Add Expense'),
          ),
        ],
      ),
    );
  }
}

class ExpenseItem extends StatelessWidget {
  final String expenseName;

  ExpenseItem(this.expenseName);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(expenseName),
    );
  }
}

class AddExpenseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Expense'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Expense Value'),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Description'),
            ),
            ElevatedButton(
              onPressed: () {
                // Save expense logic
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
