// Helper function to convert string to IconData
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

IconData getIconData(String iconName) {
  switch (iconName) {
    case "IconlyBold.work":
      return IconlyBold.work;
    case "IconlyBold.profile":
      return IconlyBold.profile;
    case "IconlyBold.heart":
      return IconlyBold.heart;
    case "IconlyBold.document":
      return IconlyBold.document;
    case "IconlyBold.bag":
      return IconlyBold.bag;
    case "IconlyBold.user_3":
      return IconlyBold.user_3;
    case "IconlyBold.wallet":
      return IconlyBold.wallet;
    case "IconlyBold.video":
      return IconlyBold.video;
    case "IconlyBold.discovery":
      return IconlyBold.discovery;
    case "IconlyBold.category":
      return IconlyBold.category;
    default:
      return IconlyBold.work; // Default icon if no match
  }
}
