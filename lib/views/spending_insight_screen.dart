import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class SpendingInsightScreen extends StatelessWidget {
  const SpendingInsightScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // Top bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Spending insight",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Text(
                      "Jan",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Icon(Icons.keyboard_arrow_down),
                  ],
                )
              ],
            ),
            const SizedBox(height: 20),

            // Budget overview title
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Budget overview",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Row(
                  children: const [
                    Text("Adjust",
                        style: TextStyle(
                          color: Color(0xFF7B3EF2),
                          fontWeight: FontWeight.w500,
                        )),
                    SizedBox(width: 4),
                    Icon(Icons.edit, color: Color(0xFF7B3EF2), size: 18)
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Budget Card with Circular Chart
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

                  // Circular progress
                  CircularPercentIndicator(
                    radius: 60.0,
                    lineWidth: 12.0,
                    percent: 2335.20 / 6000,
                    center: const Text(
                      "\$2,335.20\nSpent",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    progressColor: const Color(0xFF7B3EF2),
                    backgroundColor: Colors.grey.shade300,
                    circularStrokeCap: CircularStrokeCap.round,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Left to spend: \$3,665.80",
                    style: TextStyle(
                        color: Color(0xFF7B3EF2), fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
            const SizedBox(height: 30),

            const Text(
              "Budget category",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 20),

            // Category Cards
            categoryItem("General", "\$600 / \$3,000", "3 transactions",
                Icons.category, Colors.purple),
            categoryItem("Transportation", "\$600 / \$1,000", "5 transactions",
                Icons.directions_car, Colors.blue),
            categoryItem("Charity", "\$1,210 / \$1,000", "12 transactions",
                Icons.favorite, Colors.pink),
            categoryItem("Education", "\$900 / \$1,000", "6 transactions",
                Icons.school, Colors.orange),
          ],
        ),
      ),
    );
  }

  Widget categoryItem(String title, String amount, String subtitle,
      IconData icon, Color iconColor) {
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
            backgroundColor: iconColor.withOpacity(0.1),
            child: Icon(icon, color: iconColor),
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
