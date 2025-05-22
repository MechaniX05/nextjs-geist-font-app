import 'package:flutter/material.dart';

enum Attendance { present, absent }

class Child {
  final String id;
  final String name;
  final int age;
  final String className;
  final Attendance attendance;
  final String imageUrl;
  final List<String> activities;

  Child({
    required this.id,
    required this.name,
    required this.age,
    required this.className,
    required this.attendance,
    required this.imageUrl,
    this.activities = const [],
  });

  String get attendanceStatus => 
    attendance == Attendance.present ? 'Present' : 'Absent';

  Color get attendanceColor =>
    attendance == Attendance.present 
      ? const Color(0xFF7ED3B2)  // Green for present
      : const Color(0xFFFF7C7C); // Red for absent
}
