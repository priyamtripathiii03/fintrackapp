import 'package:fintrackapp/budget_screen.dart';
import 'package:fintrackapp/views/adjust_limit_screen.dart';
import 'package:fintrackapp/views/budget_adjusted_successfully_screen.dart';
import 'package:fintrackapp/views/budget_over_view_screen.dart';
import 'package:fintrackapp/views/budget_successfull_screen.dart';
import 'package:fintrackapp/views/category_detail_screen.dart';
import 'package:fintrackapp/views/category_screen.dart';
import 'package:fintrackapp/views/home_page.dart';
import 'package:fintrackapp/views/spending_insight_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const DashboardScreen(initialCategories: [],),
        '/budgetscreen': (context) => const CreateBudgetScreen(),
        '/newcategory': (context) => const CreateCategoryScreen(),
        '/budgetsuccessfull': (context) => const BudgetScreen(),
        '/createbudget': (context) => const CreateBudgetScreen(),
        '/budgetoverview': (context) => BudgetOverviewScreen(categories: [],),

      },
    );
  }
}
