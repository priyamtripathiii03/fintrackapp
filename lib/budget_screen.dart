import 'package:fintrackapp/views/category_screen.dart';
import 'package:flutter/material.dart';
 // Ensure this contains BudgetCategory model

class CreateBudgetScreen extends StatefulWidget {
  const CreateBudgetScreen({super.key});

  @override
  State<CreateBudgetScreen> createState() => _CreateBudgetScreenState();
}

class _CreateBudgetScreenState extends State<CreateBudgetScreen> {
  final List<BudgetCategory> categories = [
    BudgetCategory(icon: Icons.circle, color: Colors.purple, name: "General", amount: "\$1,000"),
    BudgetCategory(icon: Icons.directions_bus, color: Colors.blue, name: "Transportation", amount: "\$1,000"),
    BudgetCategory(icon: Icons.favorite, color: Colors.pink, name: "Charity", amount: "\$1,000"),
  ];

  final List<String> predefinedAmounts = ["100", "200", "500", "1,000"];
  String selectedAmount = "100"; // Default selected amount

  void _addNewCategory() async {
    final newCategory = await Navigator.push<BudgetCategory>(
      context,
      MaterialPageRoute(builder: (context) => const CreateCategoryScreen()),
    );

    if (newCategory != null) {
      setState(() {
        // Set selected amount to new category
        final categoryWithAmount = BudgetCategory(
          name: newCategory.name,
          icon: newCategory.icon,
          color: newCategory.color,
          amount: "\$$selectedAmount",
        );
        categories.add(categoryWithAmount);
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
              // Top Bar
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back_ios, size: 20),
                  ),
                  const SizedBox(width: 10),
                  const Text("Create Budget",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 24),

              // Budget Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 2))
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      '\$${selectedAmount}',
                      style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    const Text("Set budget amount", style: TextStyle(color: Colors.grey)),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 12,
                      children: predefinedAmounts.map((amount) {
                        final isSelected = amount == selectedAmount;
                        return ChoiceChip(
                          label: Text("\$$amount"),
                          selected: isSelected,
                          selectedColor: Colors.deepPurple,
                          backgroundColor: const Color(0xFFF0F0F0),
                          labelStyle: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                          onSelected: (_) {
                            setState(() {
                              selectedAmount = amount;
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Set Category Header
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

              // Category List
              Expanded(
                child: ListView(
                  children: [
                    for (var cat in categories)
                      CategoryTile(
                        icon: cat.icon,
                        color: cat.color,
                        title: cat.name,
                        amount: cat.amount,
                      ),
                    AddCategoryTile(onTap: _addNewCategory),
                  ],
                ),
              ),

              // Amount Left
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))
                    ],
                  ),
                  child: const Text("Amount left: \$3,000",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 16),

              // Get Started Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  onPressed: () {
                    // Get started logic
                  },
                  child: const Text("Get Started", style: TextStyle(fontSize: 16, color: Colors.white)),
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
        boxShadow: const [
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
          Text(amount, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class AddCategoryTile extends StatelessWidget {
  final VoidCallback onTap;

  const AddCategoryTile({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: const [
            Icon(Icons.add, color: Colors.grey),
            SizedBox(width: 16),
            Text("Add new category", style: TextStyle(color: Colors.grey, fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
