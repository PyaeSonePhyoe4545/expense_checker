import 'package:flutter/foundation.dart';

class Trasaction {
  final String title;
  final String id;
  final double amount;
  final DateTime date;

  Trasaction({
    required this.title,
    required this.id,
    required this.amount,
    required this.date,
  });
}
