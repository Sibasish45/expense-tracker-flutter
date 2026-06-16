import 'package:flutter/material.dart';
import '../models/expense.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<expense> expenses = [];

  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  double TotalExpense() {
    double sum = 0;
    for (var i in expenses) {
      sum = sum+ i.amount;
    }
    return sum;
  }

  void addExpense() {
    titleController.clear();
    amountController.clear();

    showDialog(context: context,builder: (context)
    {return AlertDialog(
          title: const Text("Add Expense"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: "Title:",
                ),
              ),

              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Amount:",
                ),
              ),
            ],
          ),

          actions: [
            ElevatedButton(
              onPressed: () {
                if (titleController.text.isEmpty || amountController.text.isEmpty)
                {
                  return;
                }

                setState(() {
                  expenses.add(
                    expense(
                      title: titleController.text,
                      amount: double.parse(amountController.text),
                    ),
                  );
                });
                Navigator.pop(context);
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  void editExpense(int index) {
    titleController.text = expenses[index].title;
    amountController.text = expenses[index].amount.toString();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Expense"),

          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: "Title:",
                ),
              ),

              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Amount:",
                ),
              ),
            ],
          ),

          actions: [
            ElevatedButton(
              onPressed: () {

                setState(() {
                  expenses[index].title = titleController.text;
                  expenses[index].amount = double.parse(amountController.text);
                });
                Navigator.pop(context);
              },
              child: const Text("Update"),
            ),
          ],
        );
      },
    );
  }

  void deleteExpense(int index) {
    setState(() {
      expenses.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense Tracker"),
        centerTitle: true,
      ),

      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(7),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Text(
                "Total Expense:"+TotalExpense().toString(),
                style: const TextStyle(fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: expenses.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.money),

                    title: Text(
                      expenses[index].title,
                    ),

                    subtitle: Text(
                      "Expense",
                    ),

                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "₹"+expenses[index].amount.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        IconButton(
                          onPressed: () { editExpense(index); },icon: const Icon(Icons.edit),
                        ),

                        IconButton(
                          onPressed: () { deleteExpense(index); },icon: const Icon(Icons.delete),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: addExpense,
        child: const Icon(Icons.add),
      ),
    );
  }
}