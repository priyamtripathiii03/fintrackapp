import 'package:flutter/material.dart';
import '../budget_screen.dart';
import 'category_screen.dart' hide BudgetCategory;


class DashboardScreen extends StatefulWidget {
  final List<BudgetCategory> initialCategories;

  const DashboardScreen({super.key, required this.initialCategories});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late List<BudgetCategory> categories;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    // Copy initial categories so we can modify locally
    categories = List.from(widget.initialCategories);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.credit_card), label: 'Cards'),
          BottomNavigationBarItem(icon: Icon(Icons.card_giftcard), label: 'Rewards'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Row
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 24,
                      backgroundImage: NetworkImage('https://i.pravatar.cc/150'),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Namaste, Priyam',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        Text('Shubh Prabhat',
                            style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                    const Spacer(),
                    Stack(
                      children: const [
                        Icon(Icons.notifications_none),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: CircleAvatar(radius: 4, backgroundColor: Colors.red),
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 20),

                // Balance Card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Total balance",
                          style: TextStyle(color: Colors.white54, fontSize: 14)),
                      const SizedBox(height: 6),
                      const Text("18,987.67 USD",
                          style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const BlackButton(icon: Icons.add, label: "Deposit"),
                          const BlackButton(icon: Icons.send, label: "Transfer"),
                          GestureDetector(
                            onTap: () async {
                              final result = await Navigator.push<List<BudgetCategory>>(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const CreateBudgetScreen(),
                                ),
                              );
                              if (result != null && result.isNotEmpty) {
                                setState(() {
                                  categories = result;
                                });
                              }
                            },
                            child: const BlackButton(icon: Icons.more_horiz, label: "More"),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Budget Card
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEDE6FE),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Set a financial budget",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            const SizedBox(height: 6),
                            const Text(
                              "Setting a budget helps you track your finance easier with fintrack",
                              style: TextStyle(fontSize: 13, color: Colors.black54),
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
                              onPressed: () async {
                                final result = await Navigator.push<List<BudgetCategory>>(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const CreateBudgetScreen(),
                                  ),
                                );
                                if (result != null && result.isNotEmpty) {
                                  setState(() {
                                    categories = result;
                                  });
                                }
                              },
                              child: const Text("Set up now", style: TextStyle(color: Colors.white)),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Icon(Icons.account_balance_wallet, size: 48, color: Colors.deepPurple)
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Transactions Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("Transactions", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    Text("view all", style: TextStyle(color: Colors.deepPurple)),
                  ],
                ),
                const SizedBox(height: 16),

                // Dynamic Transactions
                if (categories.isEmpty) ...[
                  const Text('No budget categories yet'),
                ] else ...[
                  for (var cat in categories)
                    TransactionItem(
                      title: cat.name,
                      icon: cat.icon,
                      amount: cat.amount,
                      isCredit: true,
                      iconColor: cat.color,
                    ),
                ],

                // Sample static transactions
                const TransactionItem(
                    title: "Fitness first", icon: Icons.fitness_center, amount: "- \$50.00", isCredit: false),
                const TransactionItem(
                    title: "Transfer wise", icon: Icons.currency_exchange, amount: "\$50.00", isCredit: true),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BlackButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const BlackButton({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.white24,
          child: Icon(icon, color: Colors.white),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 12))
      ],
    );
  }
}

class TransactionItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final String amount;
  final bool isCredit;
  final Color? iconColor;

  const TransactionItem({
    super.key,
    required this.title,
    required this.icon,
    required this.amount,
    required this.isCredit,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.grey.shade200,
          child: Icon(icon, color: iconColor ?? (isCredit ? Colors.green : Colors.red)),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        trailing: Text(
          amount,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isCredit ? Colors.green : Colors.red),
        ),
      ),
    );
  }
}
