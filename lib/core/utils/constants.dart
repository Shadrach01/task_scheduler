import 'package:flutter/material.dart';

class Constants {
  // Button Row Texts fot today task screen
  static const List<String> buttonsRowTexts = [
    "All",
    "To Do",
    "In Progress",
    "Completed"
  ];
  static const List<String> taskGroups = [
    "All",
    "To Do",
    "In Progress",
    "Completed"
  ];

  static const List<Map<String, dynamic>> categories = [
    {
      "name": "Office Project",
      "icon": "IconlyBold.work", // Store as string
      "color": Colors.deepOrange
    },
    {
      "name": "Personal Projects",
      "icon": "IconlyBold.profile", // Store as string
      "color": Colors.blue
    },
    {
      "name": "Health & Fitness",
      "icon": "IconlyBold.heart", // Store as string
      "color": Colors.green
    },
    {
      "name": "Study",
      "icon": "IconlyBold.document", // Store as string
      "color": Colors.cyan,
    },
    {
      "name": "Shopping & Errands",
      "icon": "IconlyBold.bag", // Store as string
      "color": Colors.pink,
    },
    {
      "name": "Family",
      "icon": "IconlyBold.user_3", // Store as string
      "color": Colors.brown,
    },
    {
      "name": "Finance",
      "icon": "IconlyBold.wallet", // Store as string
      "color": Colors.amber,
    },
    {
      "name": "Meetings",
      "icon": "IconlyBold.video", // Store as string
      "color": Colors.red,
    },
    {
      "name": "Hobbies",
      "icon": "IconlyBold.discovery", // Store as string
      "color": Colors.indigo,
    },
    {
      "name": "Others",
      "icon": "IconlyBold.category", // Store as string
      "color": Colors.lime,
    },
  ];
}
