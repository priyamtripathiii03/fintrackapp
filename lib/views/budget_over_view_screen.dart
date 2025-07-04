import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class BudgetOverviewScreen extends StatelessWidget {
  const BudgetOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, double> dataMap = {
      "General": 600,
      "Transportation": 600,
      "Charity": 1210,
      "Education": 925,
    };

    Map<String, Color> colorMap = {
      "General": Colors.purple,
      "Transportation": Colors.blue,
      "Charity": Colors.pink,
      "Education": Colors.orange,
    };

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // Top Bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Spending insight",
                    style:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Row(
                  children: [
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
                    style:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                Row(
                  children: const [
                    Text("Adjust",
                        style: TextStyle(
                            color: Color(0xFF7B3EF2),
                            fontWeight: FontWeight.w500)),
                    SizedBox(width: 4),
                    Icon(Icons.edit, size: 18, color: Color(0xFF7B3EF2)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Pie Chart Card
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
                  const Text("\$6,000",
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),

                  // Pie Chart
                  PieChart(
                    dataMap: dataMap,
                    colorList: colorMap.values.toList(),
                    chartRadius: 100,
                    ringStrokeWidth: 20,
                    chartType: ChartType.ring,
                    centerText: "\$2,335.20\nSpent",
                    centerTextStyle: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 14,color: Colors.black),
                    chartValuesOptions:
                    const ChartValuesOptions(showChartValues: false),
                    legendOptions:
                    const LegendOptions(showLegends: false), // hidden
                  ),
                  const SizedBox(height: 10),
                  const Text("Left to spend: \$3,665.80",
                      style: TextStyle(
                          color: Color(0xFF7B3EF2),
                          fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            const SizedBox(height: 30),

            const Text("Budget category",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 20),

            // Category List
            categoryTile("General", "3 transactions", "\$600 / \$3,000",
                Icons.category, Colors.purple),
            categoryTile("Transportation", "5 transactions", "\$600 / \$1,000",
                Icons.directions_car, Colors.blue),
            categoryTile("Charity", "12 transactions", "\$1,210 / \$1,000",
                Icons.favorite, Colors.pink),
            categoryTile("Education", "6 transactions", "\$925 / \$1,000",
                Icons.school, Colors.orange),
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
                    style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                const SizedBox(height: 4),
                Text(subtitle,
                    style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          Text(amount,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        ],
      ),
    );
  }
}
