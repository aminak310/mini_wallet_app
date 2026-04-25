import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/add_money_screen.dart';
import '../screens/send_money_screen.dart';
import '../screens/transaction_history_screen.dart';
import '../models/transaction.dart';
import '../screens/splash_screen.dart';
import '../screens/onboarding_screen.dart';

class AppRoutes {
  // Route names
  static const String home = '/';
  static const String addMoney = '/add-money';
  static const String sendMoney = '/send-money';
  static const String history = '/history';
  static const String splash = '/splash';
  static const String onboarding = '/onboarding';

  // Routes map
  static Map<String, WidgetBuilder> routes = {
    // Splash Screen
    splash: (context) => const SplashScreen(),

    // Onboarding Screen
    onboarding: (context) => const OnboardingScreen(),

    // Home Screen
    home: (context) => const HomeScreen(),

    // Add Money Screen
    addMoney: (context) {
      final onAdd =
      ModalRoute.of(context)?.settings.arguments as Function(double)?;
      return AddMoneyScreen(onAdd: onAdd ?? (double value) {});
    },

    // Send Money Screen
    sendMoney: (context) {
      final onSend =
      ModalRoute.of(context)?.settings.arguments as Function(double)?;
      return SendMoneyScreen(onSend: onSend ?? (double value) {});
    },

    // Transaction History Screen
    history: (context) {
      final transactions =
      ModalRoute.of(context)?.settings.arguments as List<TransactionModel>?;
      return TransactionHistoryScreen(transactions: transactions ?? []);
    },
  };
}