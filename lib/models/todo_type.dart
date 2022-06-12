import 'package:flutter/material.dart';

class TodoType {

  final int tasks;
  final String title;
  final Color color;
  final IconData icon;

  const TodoType({
    required this.color,
    required this.tasks,
    required this.title,
    required this.icon,
  });
}