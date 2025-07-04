import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import '../budget_screen.dart';

class BudgetOverviewScreen extends StatelessWidget {
  final List<BudgetCategory> categories;

  const BudgetOverviewScreen({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    // Convert categories to a dataMap for PieChart
    final Map<String, double> dataMap = {
      for (var cat in categories) cat.name: _parseAmount(cat.amount),
    };

    // Generate colorMap
    final Map<String, Color> colorMap = {
      for (var cat in categories) cat.name: cat.color,
    };

    final double totalBudget = categories.fold(
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
                // Close Icon
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context); // Go back to previous screen
                  },
                ),

                // Title and Month
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
                Row(
                  children: const [
                    Text("Adjust",
                        style: TextStyle(
                            color: Color(0xFF7B3EF2), fontWeight: FontWeight.w500)),
                    SizedBox(width: 4),
                    Icon(Icons.edit, size: 18, color: Color(0xFF7B3EF2)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Show Pie Chart only if categories are not empty
            if (categories.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    const Text("Monthly budget",
                        style: TextStyle(color: Colors.grey)),
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
                      chartValuesOptions: const ChartValuesOptions(
                          showChartValues: false),
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
            if (categories.isNotEmpty) const SizedBox(height: 30),

            if (categories.isNotEmpty)
              const Text("Budget category",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            if (categories.isNotEmpty) const SizedBox(height: 20),

            // Dynamic category tiles
            if (categories.isNotEmpty)
              ...categories.map((cat) => categoryTile(
                cat.name,
                "3 transactions", // You can customize this later
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
}
