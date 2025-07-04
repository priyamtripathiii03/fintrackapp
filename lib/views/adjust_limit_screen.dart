import 'package:flutter/material.dart';

class AdjustLimitScreen extends StatefulWidget {
  const AdjustLimitScreen({super.key});

  @override
  State<AdjustLimitScreen> createState() => _AdjustLimitScreenState();
}

class _AdjustLimitScreenState extends State<AdjustLimitScreen> {
  String input = "1500";
  String selectedBillingCycle = 'Apply immediately';

  void _showBillingCycleSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        String tempSelected = selectedBillingCycle;

        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Set billing cycle",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      Icon(Icons.close),
                    ],
                  ),
                  const SizedBox(height: 20),
                  RadioListTile(
                    value: 'Apply immediately',
                    groupValue: tempSelected,
                    onChanged: (value) {
                      setModalState(() => tempSelected = value!);
                    },
                    title: const Text("Apply immediately"),
                  ),
                  RadioListTile(
                    value: 'Apply next month',
                    groupValue: tempSelected,
                    onChanged: (value) {
                      setModalState(() => tempSelected = value!);
                    },
                    title: const Text("Apply next month"),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedBillingCycle = tempSelected;
                        });
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF7B3EF2),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text("Confirm",
                          style: TextStyle(fontSize: 16, color: Colors.white)),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void onNumberTap(String number) {
    setState(() {
      if (number == '←') {
        if (input.isNotEmpty) {
          input = input.substring(0, input.length - 1);
        }
      } else {
        input += number;
      }
    });
  }

  Widget buildKey(String number) {
    return GestureDetector(
      onTap: () => onNumberTap(number),
      child: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFFF5F5F5),
        ),
        child: number == '←'
            ? const Icon(Icons.backspace_outlined)
            : Text(number,
            style: const TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          child: Column(
            children: [
              // Top bar
              Row(
                children: const [
                  Icon(Icons.arrow_back),
                  SizedBox(width: 12),
                  Text("Adjust limit",
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
                ],
              ),
              const SizedBox(height: 40),

              // Input amount
              Text("\$${input.isEmpty ? "0" : input}",
                  style: const TextStyle(
                      fontSize: 32, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text("Current limit: \$1,000",
                  style: TextStyle(color: Colors.grey, fontSize: 14)),
              const SizedBox(height: 16),

              // Dropdown-like Button
              GestureDetector(
                onTap: _showBillingCycleSheet,
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        selectedBillingCycle,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.keyboard_arrow_down),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Keypad
              Expanded(
                child: GridView.count(
                  crossAxisCount: 3,
                  childAspectRatio: 1.3,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    ...List.generate(9, (index) => buildKey('${index + 1}')),
                    buildKey('.'),
                    buildKey('0'),
                    buildKey('←'),
                  ],
                ),
              ),

              // Confirm Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle confirm
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7B3EF2),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text("Confirm",
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
