import 'package:flutter/material.dart';

class PaymentBalanceModel {
  final String title;
  final String? subtitle;
  final IconData icon;
  final Color color;

  double openingBalance;
  double systemMovement;
  double actualBalance;

  PaymentBalanceModel({
    required this.title,
    required this.icon,
    required this.color,
    this.subtitle,
    this.openingBalance = 0,
    this.systemMovement = 0,
    this.actualBalance = 0,
  });

  double get expectedBalance {
    return openingBalance + systemMovement;
  }

  double get difference {
    return actualBalance - expectedBalance;
  }
}