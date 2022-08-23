import 'package:flutter/material.dart';

class Meal {
  late bool skipped;
  late String time;
  late String day;
  String meal;
  late String feeling;
  late String share;
  late String food;

  Meal({
    required this.skipped,
    required this.time,
    required this.meal,
    required this.day,
    required this.feeling,
    required this.share
  });

  Meal.incomplete(this.meal);

  static Meal fromJson(Map<String, dynamic> json) => Meal(
      skipped: json['skipped'],
      time: json['time'],
      day: json['day'],
      meal: json['meal'],
      feeling: json['feeling'],
      share: json['share'],
  );

}