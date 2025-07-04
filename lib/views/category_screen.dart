import 'package:flutter/material.dart';
import '../budget_screen.dart';

class CreateCategoryScreen extends StatefulWidget {
  const CreateCategoryScreen({super.key});

  @override
  State<CreateCategoryScreen> createState() => _CreateCategoryScreenState();
}

class _CreateCategoryScreenState extends State<CreateCategoryScreen> {
  final TextEditingController _controller = TextEditingController();
  int selectedColorIndex = 0;

  final List<Color> colorOptions = [
    Colors.pink.shade100,
    Colors.purple.shade100,
    Colors.blue.shade100,
    Colors.lightBlue.shade100,
    Colors.teal.shade100,
    Colors.green.shade100,
    Colors.orange.shade100,
    Colors.red.shade100,
  ];

  final List<String> tags = [
    "Self care",
    "Education",
    "Shopping",
    "Lifestyle",
  ];

  IconData getIconForCategory(String name) {
    name = name.toLowerCase();
    if (name.contains("self")) return Icons.spa;
    if (name.contains("education")) return Icons.school;
    if (name.contains("shopping")) return Icons.shopping_cart;
    if (name.contains("lifestyle")) return Icons.style;
    return Icons.category;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 15,
                  color: Colors.black12,
                  spreadRadius: 1,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Create new category",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    Icon(
                      getIconForCategory(_controller.text),
                      size: 50,
                      color: colorOptions[selectedColorIndex],
                    ),
                    const SizedBox(height: 5),
                    const Text("Choose category icon"),
                  ],
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    labelText: "Set name for category",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onChanged: (_) {
                    setState(() {}); // Update icon on typing
                  },
                ),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: tags.map((tag) {
                    return Chip(
                      label: Text(tag),
                      backgroundColor: Colors.purple.shade50,
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Select color",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  children: List.generate(colorOptions.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedColorIndex = index;
                        });
                      },
                      child: CircleAvatar(
                        backgroundColor: colorOptions[index],
                        radius: 15,
                        child: selectedColorIndex == index
                            ? const Icon(Icons.check, size: 18, color: Colors.white)
                            : null,
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.deepPurpleAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      if (_controller.text.trim().isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Please enter a category name")),
                        );
                        return;
                      }

                      final newCategory = BudgetCategory(
                        name: _controller.text.trim(),
                        icon: getIconForCategory(_controller.text),
                        color: colorOptions[selectedColorIndex],
                        amount: "",
                      );

                      Navigator.pop(context, newCategory);
                    },
                    child: const Text(
                      "Save category",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}