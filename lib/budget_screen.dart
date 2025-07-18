import 'package:flutter/material.dart';
import 'package:fintrackapp/views/category_screen.dart';

class BudgetCategory {
  String name;
  IconData icon;
  Color color;
  String amount;

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

  void _editCategoriesDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Categories"),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: categories[index].color.withOpacity(0.2),
                    child: Icon(categories[index].icon, color: categories[index].color),
                  ),
                  title: Text(categories[index].name),
                  subtitle: Text("Amount: ${categories[index].amount}"),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        categories.removeAt(index);
                      });
                      Navigator.of(context).pop(); // Close dialog
                    },
                  ),
                  onTap: () {
                    Navigator.of(context).pop(); // Close dialog
                    _showEditCategorySheet(index);
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Close"),
            )
          ],
        );
      },
    );
  }

  void _showEditCategorySheet(int index) {
    final category = categories[index];
    final nameController = TextEditingController(text: category.name);
    final amountController = TextEditingController(text: category.amount.replaceAll('\$', ''));

    IconData selectedIcon = category.icon;
    Color selectedColor = category.color;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: StatefulBuilder(builder: (context, setStateModal) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Edit Category", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: "Category Name"),
                ),
                TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: "Amount"),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Text("Choose Icon: "),
                    IconButton(
                      icon: const Icon(Icons.circle),
                      onPressed: () => setStateModal(() => selectedIcon = Icons.circle),
                    ),
                    IconButton(
                      icon: const Icon(Icons.directions_bus),
                      onPressed: () => setStateModal(() => selectedIcon = Icons.directions_bus),
                    ),
                    IconButton(
                      icon: const Icon(Icons.favorite),
                      onPressed: () => setStateModal(() => selectedIcon = Icons.favorite),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text("Choose Color: "),
                    IconButton(
                      icon: const Icon(Icons.circle, color: Colors.purple),
                      onPressed: () => setStateModal(() => selectedColor = Colors.purple),
                    ),
                    IconButton(
                      icon: const Icon(Icons.circle, color: Colors.blue),
                      onPressed: () => setStateModal(() => selectedColor = Colors.blue),
                    ),
                    IconButton(
                      icon: const Icon(Icons.circle, color: Colors.pink),
                      onPressed: () => setStateModal(() => selectedColor = Colors.pink),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      category.name = nameController.text;
                      category.amount = '\$${amountController.text}';
                      category.icon = selectedIcon;
                      category.color = selectedColor;
                    });
                    Navigator.pop(context);
                  },
                  child: const Text("Save Changes"),
                ),
              ],
            );
          }),
        ),
      ),
    );
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
                  const Text("Create Budget", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 2))],
                ),
                child: Column(
                  children: [
                    const Text('\$6,000', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
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
                children: [
                  const Text("Set Budget category", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  GestureDetector(
                    onTap: _editCategoriesDialog,
                    child: const Row(
                      children: [
                        Text("Edit", style: TextStyle(color: Colors.deepPurple)),
                        SizedBox(width: 4),
                        Icon(Icons.edit, size: 16, color: Colors.deepPurple),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: categories.length + 1,
                  itemBuilder: (context, index) {
                    if (index == categories.length) {
                      return GestureDetector(
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
                              Text("Add new category", style: TextStyle(color: Colors.grey, fontSize: 16))
                            ],
                          ),
                        ),
                      );
                    }

                    final cat = categories[index];
                    return CategoryTile(
                      icon: cat.icon,
                      color: cat.color,
                      title: cat.name,
                      amount: cat.amount,
                      onEdit: () => _showEditCategorySheet(index),
                      onDelete: () {
                        setState(() {
                          categories.removeAt(index);
                        });
                      },
                    );
                  },
                ),
              ),
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
                  ),
                  child: const Text("Amount left: \$3,000", style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  onPressed: () {
                    Navigator.pop(context, categories);
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
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const CategoryTile({
    super.key,
    required this.icon,
    required this.color,
    required this.title,
    required this.amount,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 2))],
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
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.grey),
            onPressed: onEdit,
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}
