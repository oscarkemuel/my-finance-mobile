import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

enum CategoryIdentifier {
  unknown,
  food,
  transport,
  health,
  education,
  entertainment,
  services,
  others,
  home,
  // ignore: constant_identifier_names
  fast_food,
  shopping,
  travel,
  fitness,
  pets,
}

class CategoryIcon {
  final String name;
  final IconData icon;
  final CategoryIdentifier identifier;

  const CategoryIcon({
    required this.name,
    required this.icon,
    required this.identifier,
  });
}

class Utils {
  static const Map<CategoryIdentifier, CategoryIcon> iconMap = {
    CategoryIdentifier.unknown: CategoryIcon(
        name: 'Unknown',
        icon: Icons.help,
        identifier: CategoryIdentifier.unknown),
    CategoryIdentifier.food: CategoryIcon(
        name: 'Food',
        icon: Icons.food_bank,
        identifier: CategoryIdentifier.food),
    CategoryIdentifier.transport: CategoryIcon(
        name: 'Transport',
        icon: Icons.directions_bus,
        identifier: CategoryIdentifier.transport),
    CategoryIdentifier.health: CategoryIcon(
        name: 'Health',
        icon: Icons.local_hospital,
        identifier: CategoryIdentifier.health),
    CategoryIdentifier.education: CategoryIcon(
        name: 'Education',
        icon: Icons.school,
        identifier: CategoryIdentifier.education),
    CategoryIdentifier.entertainment: CategoryIcon(
        name: 'Entertainment',
        icon: Icons.movie,
        identifier: CategoryIdentifier.entertainment),
    CategoryIdentifier.services: CategoryIcon(
        name: 'Services',
        icon: Icons.settings,
        identifier: CategoryIdentifier.services),
    CategoryIdentifier.others: CategoryIcon(
        name: 'Others',
        icon: Icons.more_horiz,
        identifier: CategoryIdentifier.others),
    CategoryIdentifier.home: CategoryIcon(
        name: 'Home', icon: Icons.home, identifier: CategoryIdentifier.home),
    CategoryIdentifier.fast_food: CategoryIcon(
        name: 'Fast Food',
        icon: Icons.fastfood,
        identifier: CategoryIdentifier.fast_food),
    CategoryIdentifier.shopping: CategoryIcon(
        name: 'Shopping',
        icon: Icons.shopping_cart,
        identifier: CategoryIdentifier.shopping),
    CategoryIdentifier.travel: CategoryIcon(
        name: 'Travel',
        icon: Icons.flight,
        identifier: CategoryIdentifier.travel),
    CategoryIdentifier.fitness: CategoryIcon(
        name: 'Fitness',
        icon: Icons.fitness_center,
        identifier: CategoryIdentifier.fitness),
    CategoryIdentifier.pets: CategoryIcon(
        name: 'Pets', icon: Icons.pets, identifier: CategoryIdentifier.pets),
  };

  static CategoryIdentifier stringToCategoryIdentifier(String key) {
    return CategoryIdentifier.values.firstWhere(
        (e) => e.toString().split('.').last == key,
        orElse: () => CategoryIdentifier.unknown // Fallback seguro
        );
  }
}

Future<bool> isConnected() async {
  var connectivityResult = await (Connectivity().checkConnectivity());

  return connectivityResult != ConnectivityResult.none;
}
