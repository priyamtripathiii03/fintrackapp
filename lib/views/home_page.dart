import 'package:fintrackapp/views/budget_over_view_screen.dart';
import 'package:flutter/material.dart';
import '../budget_screen.dart';
import 'category_screen.dart';

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
    categories = List.from(widget.initialCategories);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        backgroundColor: Colors.teal.shade50,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        indicatorColor: Colors.teal.shade200,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.credit_card_outlined),
            selectedIcon: Icon(Icons.credit_card),
            label: 'Cards',
          ),
          NavigationDestination(
            icon: Icon(Icons.card_giftcard_outlined),
            selectedIcon: Icon(Icons.card_giftcard),
            label: 'Rewards',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                        Text('Namaste, Priyam', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        Text('Shubh Prabhat', style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                    const Spacer(),
                    Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BudgetOverviewScreen(categories: categories),
                              ),
                            );
                          },
                          child: const Icon(Icons.notifications_none),
                        ),
                        const Positioned(
                          right: 0,
                          top: 0,
                          child: CircleAvatar(radius: 4, backgroundColor: Colors.red),
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Total balance", style: TextStyle(color: Colors.white54, fontSize: 14)),
                      const SizedBox(height: 6),
                      const Text("18,987.67 USD", style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
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
                                MaterialPageRoute(builder: (context) => const CreateBudgetScreen()),
                              );
                              if (result != null) {
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
                const Text("Transactions", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                const SizedBox(height: 10),
                if (categories.isEmpty)
                  const Text('No budget categories yet')
                else
                  ...categories.map((cat) => TransactionItem(
                    title: cat.name,
                    icon: cat.icon,
                    amount: cat.amount,
                    isCredit: true,
                    iconColor: cat.color,
                  )),
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
          style: TextStyle(fontWeight: FontWeight.bold, color: isCredit ? Colors.green : Colors.red),
        ),
      ),
    );
  }
}
