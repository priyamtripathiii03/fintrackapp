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
  List<BudgetCategory> categories = [
    BudgetCategory(icon: Icons.circle, color: Colors.purple, name: "General", amount: "\$1,000"),
    BudgetCategory(icon: Icons.directions_bus, color: Colors.blue, name: "Transportation", amount: "\$1,000"),
    BudgetCategory(icon: Icons.favorite, color: Colors.pink, name: "Charity", amount: "\$1,000"),
  ];

  final List<String> predefinedAmounts = ["100", "200", "500", "1,000"];
  String selectedAmount = "100";

  @override
  void dispose() {
    // Dispose any controllers if added later (currently none)
    super.dispose();
  }

  void _addNewCategory() async {
    final newCategory = await Navigator.push<BudgetCategory>(
      context,
      MaterialPageRoute(builder: (context) => const CreateCategoryScreen()),
    );

    if (newCategory != null) {
      setState(() {
        categories.add(BudgetCategory(
          name: newCategory.name,
          icon: newCategory.icon,
          color: newCategory.color,
          amount: "\$$selectedAmount",
        ));
      });
    }
  }

  void _editCategory(int index) async {
    final edited = await showDialog<BudgetCategory>(
      context: context,
      builder: (context) => EditCategoryDialog(category: categories[index]),
    );

    if (edited != null) {
      setState(() {
        categories[index] = edited;
      });
    }
  }

  void _deleteCategory(int index) {
    setState(() {
      categories.removeAt(index);
    });
  }

  void _submitBudget() {
    Navigator.pop(context, categories);
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
              // Back & Title
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context, categories),
                    child: const Icon(Icons.arrow_back_ios, size: 20),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "Create Budget",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Budget amount selector
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
                    Text('\$$selectedAmount',
                        style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
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
                          labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
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

              // Categories list with add button
              Expanded(
                child: ListView.separated(
                  itemCount: categories.length + 1,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    if (index == categories.length) {
                      return ElevatedButton.icon(
                        icon: const Icon(Icons.add),
                        label: const Text("Add Category"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                        ),
                        onPressed: _addNewCategory,
                      );
                    }

                    final cat = categories[index];
                    return Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: ListTile(
                        leading: CircleAvatar(backgroundColor: cat.color, child: Icon(cat.icon, color: Colors.white)),
                        title: Text(cat.name),
                        subtitle: Text(cat.amount),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.grey),
                              onPressed: () => _editCategory(index),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _deleteCategory(index),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Submit Button
              ElevatedButton(
                onPressed: _submitBudget,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  minimumSize: const Size.fromHeight(48),
                ),
                child: const Text("Submit Budget", style: TextStyle(color: Colors.white, fontSize: 16)),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// Screen to create a new category
class CreateCategoryScreen extends StatefulWidget {
  const CreateCategoryScreen({super.key});

  @override
  State<CreateCategoryScreen> createState() => _CreateCategoryScreenState();
}

class _CreateCategoryScreenState extends State<CreateCategoryScreen> {
  final _nameController = TextEditingController();
  IconData selectedIcon = Icons.category;
  Color selectedColor = Colors.deepPurple;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Category")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: "Category Name"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final name = _nameController.text.trim();
                if (name.isEmpty) return;
                Navigator.pop(
                  context,
                  BudgetCategory(
                    name: name,
                    icon: selectedIcon,
                    color: selectedColor,
                    amount: "\$100", // default amount for new category
                  ),
                );
              },
              child: const Text("Add"),
            ),
          ],
        ),
      ),
    );
  }
}

// Dialog to edit category
class EditCategoryDialog extends StatefulWidget {
  final BudgetCategory category;

  const EditCategoryDialog({super.key, required this.category});

  @override
  State<EditCategoryDialog> createState() => _EditCategoryDialogState();
}

class _EditCategoryDialogState extends State<EditCategoryDialog> {
  late TextEditingController _nameController;
  late IconData _icon;
  late Color _color;
  late String _amount;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.category.name);
    _icon = widget.category.icon;
    _color = widget.category.color;
    _amount = widget.category.amount;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Edit Category"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(controller: _nameController, decoration: const InputDecoration(labelText: "Name")),
          // You can add editing for icon, color, and amount here if needed
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
        ElevatedButton(
          onPressed: () {
            final name = _nameController.text.trim();
            if (name.isEmpty) return;
            Navigator.pop(
              context,
              BudgetCategory(name: name, icon: _icon, color: _color, amount: _amount),
            );
          },
          child: const Text("Save"),
        )
      ],
    );
  }
}
