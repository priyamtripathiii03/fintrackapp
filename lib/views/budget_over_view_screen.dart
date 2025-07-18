import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import '../budget_screen.dart';

class BudgetOverviewScreen extends StatefulWidget {
  final List<BudgetCategory> categories;

  const BudgetOverviewScreen({super.key, required this.categories});

  @override
  State<BudgetOverviewScreen> createState() => _BudgetOverviewScreenState();
}

class _BudgetOverviewScreenState extends State<BudgetOverviewScreen> {
  late List<BudgetCategory> _editableCategories;

  @override
  void initState() {
    super.initState();
    _editableCategories = widget.categories
        .map((cat) => BudgetCategory(
      name: cat.name,
      amount: cat.amount,
      icon: cat.icon,
      color: cat.color,
    ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, double> dataMap = {
      for (var cat in _editableCategories) cat.name: _parseAmount(cat.amount),
    };

    final Map<String, Color> colorMap = {
      for (var cat in _editableCategories) cat.name: cat.color,
    };

    final double totalBudget = _editableCategories.fold(
      0,
          (prev, cat) => prev + _parseAmount(cat.amount),
    );

    final double totalSpent = dataMap.values.fold(0, (sum, item) => sum + item);
    final double leftToSpend = totalBudget - totalSpent;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // 🔽 Top Bar with Close Icon
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
                const Spacer(),
                const Text(
                  "Spending insight",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Spacer(flex: 2),
                Row(
                  children: const [
                    Text("Jan", style: TextStyle(fontWeight: FontWeight.bold)),
                    Icon(Icons.keyboard_arrow_down),
                  ],
                )
              ],
            ),
            const SizedBox(height: 20),

            // Budget Overview Title
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Budget overview",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                GestureDetector(
                  onTap: () => _showAdjustBottomSheet(context),
                  child: Row(
                    children: const [
                      Text("Adjust",
                          style: TextStyle(
                              color: Color(0xFF7B3EF2), fontWeight: FontWeight.w500)),
                      SizedBox(width: 4),
                      Icon(Icons.edit, size: 18, color: Color(0xFF7B3EF2)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            if (_editableCategories.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    const Text("Monthly budget", style: TextStyle(color: Colors.grey)),
                    const SizedBox(height: 4),
                    Text("\$${totalBudget.toStringAsFixed(2)}",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20),
                    PieChart(
                      dataMap: dataMap,
                      colorList: colorMap.values.toList(),
                      chartRadius: 100,
                      ringStrokeWidth: 20,
                      chartType: ChartType.ring,
                      centerText: "\$${totalSpent.toStringAsFixed(2)}\nSpent",
                      centerTextStyle: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Colors.black),
                      chartValuesOptions:
                      const ChartValuesOptions(showChartValues: false),
                      legendOptions: const LegendOptions(showLegends: false),
                    ),
                    const SizedBox(height: 10),
                    Text("Left to spend: \$${leftToSpend.toStringAsFixed(2)}",
                        style: const TextStyle(
                            color: Color(0xFF7B3EF2),
                            fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
            if (_editableCategories.isNotEmpty) const SizedBox(height: 30),

            if (_editableCategories.isNotEmpty)
              const Text("Budget category",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            if (_editableCategories.isNotEmpty) const SizedBox(height: 20),

            if (_editableCategories.isNotEmpty)
              ..._editableCategories.map((cat) => categoryTile(
                cat.name,
                "3 transactions",
                "${cat.amount} / \$1,000",
                cat.icon,
                cat.color,
              )),
          ],
        ),
      ),
    );
  }

  Widget categoryTile(String title, String subtitle, String amount,
      IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(0.1),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 14)),
                const SizedBox(height: 4),
                Text(subtitle,
                    style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          Text(amount,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 14)),
        ],
      ),
    );
  }

  double _parseAmount(String amount) {
    return double.tryParse(amount.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0.0;
  }

  void _showAdjustBottomSheet(BuildContext context) {
    final List<TextEditingController> controllers = _editableCategories
        .map((cat) => TextEditingController(text: _parseAmount(cat.amount).toString()))
        .toList();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
              left: 20,
              right: 20,
              top: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Adjust Budgets",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 20),
              ..._editableCategories.asMap().entries.map((entry) {
                int i = entry.key;
                BudgetCategory cat = entry.value;

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: TextField(
                    controller: controllers[i],
                    keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: "${cat.name} Budget",
                      prefixIcon: Icon(cat.icon, color: cat.color),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                );
              }),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7B3EF2)),
                onPressed: () {
                  setState(() {
                    for (int i = 0; i < _editableCategories.length; i++) {
                      _editableCategories[i].amount =
                          controllers[i].text.trim();
                    }
                  });
                  Navigator.pop(context);
                },
                child: const Text("Save Changes",style: TextStyle(color: Colors.white),),
              ),
            ],
          ),
        );
      },
    );
  }
}
