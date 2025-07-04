import 'package:flutter/material.dart';

class BudgetAdjustedScreen extends StatelessWidget {
  const BudgetAdjustedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),

            // Green check icon
            const CircleAvatar(
              radius: 36,
              backgroundColor: Colors.green,
              child: Icon(Icons.check, color: Colors.white, size: 40),
            ),
            const SizedBox(height: 30),

            // Main text
            const Text(
              "Your budget has been adjusted!",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),

            // Subtext
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                "Your limit for “charity” category has been increased to “\$1500” successfully",
                style: TextStyle(color: Colors.grey, fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ),

            const Spacer(),

            // Done button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to dashboard or pop
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7B3EF2),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  child: const Text("Done",
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
