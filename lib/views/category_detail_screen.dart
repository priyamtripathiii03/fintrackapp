import 'package:flutter/material.dart';

class CategoryDetailScreen extends StatelessWidget {
  const CategoryDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF1F4), // Light pink background
      body: SafeArea(
        child: Column(
          children: [
            // Top Navigation
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Icon(Icons.arrow_back),
                  Text(
                    "Category detail",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Icon(Icons.settings),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Icon & Category
            Column(
              children: const [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 30,
                  child: Icon(Icons.favorite, color: Colors.pink, size: 30),
                ),
                SizedBox(height: 12),
                Text(
                  "Charity",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text("3 transactions",
                    style: TextStyle(color: Colors.grey, fontSize: 14)),
              ],
            ),
            const SizedBox(height: 30),

            // White container with spending breakdown and transactions
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                  BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Spending Breakdown header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Spending Breakdown",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Text(
                          "Adjust",
                          style: TextStyle(
                              color: Color(0xFF7B3EF2),
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Spending Stats
                    Row(
                      children: const [
                        Text(
                          "\$250.00 over",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.circle, color: Colors.orange, size: 10),
                        SizedBox(width: 4),
                        Text("Limit exceeded",
                            style:
                            TextStyle(color: Colors.grey, fontSize: 12)),
                      ],
                    ),
                    const SizedBox(height: 6),
                    LinearProgressIndicator(
                      value: 1.25,
                      minHeight: 8,
                      backgroundColor: Colors.grey.shade300,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                          Colors.orangeAccent),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      "\$1,250 of \$1,000",
                      style: TextStyle(fontSize: 13, color: Colors.black54),
                    ),
                    const SizedBox(height: 30),

                    const Text(
                      "Transactions",
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 16),

                    // Transactions List
                    transactionTile(
                        "Fitness first", "- \$50.00", "assets/fitness.png"),
                    transactionTile(
                        "Transfer wise", "- \$700.00", "assets/transfer.png"),
                    transactionTile(
                        "Transfer wise", "- \$500.00", "assets/transfer.png"),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget transactionTile(String title, String amount, String assetPath) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundColor: Colors.redAccent,
            child: Icon(Icons.flash_on, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(title,
                style: const TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w500)),
          ),
          Text(amount,
              style:
              const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
