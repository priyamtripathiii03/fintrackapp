import 'package:fintrackapp/views/budget_successfull_screen.dart';
import 'package:fintrackapp/views/category_screen.dart';
import 'package:flutter/material.dart';

class BudgetCategory {
  final String name;
  final IconData icon;
  final Color color;
  final String amount;

  BudgetCategory({
    required this.name,
    required this.icon,
    required this.color,
    required this.amount,
  });
}

class CreateBudgetScreen extends StatefulWidget {
  const CreateBudgetScreen({super.key});

  @override
  State<CreateBudgetScreen> createState() => _CreateBudgetScreenState();
}

class _CreateBudgetScreenState extends State<CreateBudgetScreen> {
  final List<BudgetCategory> categories = [
    BudgetCategory(name: "General", icon: Icons.circle, color: Colors.purple, amount: "\$1,000"),
    BudgetCategory(name: "Transportation", icon: Icons.directions_bus, color: Colors.blue, amount: "\$1,000"),
    BudgetCategory(name: "Charity", icon: Icons.favorite, color: Colors.pink, amount: "\$1,000"),
  ];

  void _addNewCategory() async {
    final newCategory = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CreateCategoryScreen()),
    );

    if (newCategory != null && newCategory is BudgetCategory) {
      setState(() {
        categories.add(BudgetCategory(
          name: newCategory.name,
          icon: newCategory.icon,
          color: newCategory.color,
          amount: "\$1,000",
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios, size: 20),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 10),
                  const Text("Create Budget",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 2))
                  ],
                ),
                child: Column(
                  children: [
                    const Text('\$6,000',
                        style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    const Text("Set budget amount", style: TextStyle(color: Colors.grey)),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 12,
                      children: [
                        for (var amount in ["100", "200", "500", "1,000"])
                          Chip(
                            label: Text("\$$amount"),
                            backgroundColor: const Color(0xFFF0F0F0),
                          )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Set Budget category",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      Text("Edit", style: TextStyle(color: Colors.deepPurple)),
                      SizedBox(width: 4),
                      Icon(Icons.edit, size: 16, color: Colors.deepPurple),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView(
                  children: [
                    ...categories.map((cat) => CategoryTile(
                      icon: cat.icon,
                      color: cat.color,
                      title: cat.name,
                      amount: cat.amount,
                    )),
                    GestureDetector(
                      onTap: _addNewCategory,
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.add, color: Colors.grey),
                            SizedBox(width: 16),
                            Text("Add new category",
                                style: TextStyle(color: Colors.grey, fontSize: 16))
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))
                    ],
                  ),
                  child: const Text("Amount left: \$3,000",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: GestureDetector(
                  onTap: () {
              MaterialPageRoute(
              builder: (context) => const BudgetScreen(),
              );
              },
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.deepPurple,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                    onPressed: () {  },
                    child: const Text("Get Started",
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String amount;

  const CategoryTile({
    super.key,
    required this.icon,
    required this.color,
    required this.title,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 2))
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(0.2),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 16),
          Expanded(child: Text(title, style: const TextStyle(fontSize: 16))),
          Text(amount, style: const TextStyle(fontWeight: FontWeight.bold))
        ],
      ),
    );
  }
}
