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
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text("Expense Tracker",
        style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),

        centerTitle: true,
        backgroundColor: Colors.amber,
      ),

      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(15),
            padding: const EdgeInsets.all(10),

            decoration: BoxDecoration(
              color: Colors.amberAccent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                const Text(
                  'Total Expense',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

            const SizedBox(height: 10),

            Text(
                  '₹'+TotalExpense().toString(),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: expenses.length,
              itemBuilder: (context, index) {
                return Card (
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.money),

                    title: Text(
                      expenses[index].title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
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
                            fontSize: 15,
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
        backgroundColor: Colors.amber,
        child: const Text("Add"),
      ),
    );
  }
}