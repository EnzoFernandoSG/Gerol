import 'package:flutter/material.dart';
import '../widgets/base_screen.dart';
import '../models/plant.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class RecommendedPlantsScreen extends StatefulWidget {
  const RecommendedPlantsScreen({super.key});

  @override
  State<RecommendedPlantsScreen> createState() => _RecommendedPlantsScreenState();
}

class _RecommendedPlantsScreenState extends State<RecommendedPlantsScreen> {
  static const String _plantsKey = 'user_plants';

  final List<Plant> recommendedPlants = [
    Plant(
      name: 'Aloe Vera',
      description: 'A succulent plant that thrives in dry, sunny conditions.',
      region: 'Arid climates',
      light: 'Full sun',
      watering: 'Water sparingly, once every 3 weeks',
      soil: 'Sandy, well-drained soil',
    ),
    Plant(
      name: 'Basil',
      description: 'Aromatic herb that grows well in warm, sunny climates.',
      region: 'Temperate climates',
      light: 'Full sun',
      watering: 'Water 2-3 times a week',
      soil: 'Rich, well-drained soil',
    ),
    Plant(
      name: 'Cactus',
      description: 'A desert plant that requires minimal care.',
      region: 'Desert climates',
      light: 'Full sun',
      watering: 'Water once a month',
      soil: 'Sandy, well-drained soil',
    ),
  ];

  Future<void> _addToMyPlants(Plant plant) async {
    final plantAddedMessage = AppLocalizations.of(context)!.plantAdded;
    final plantAlreadyAddedMessage = AppLocalizations.of(context)!.plantAlreadyAdded;

    final prefs = await SharedPreferences.getInstance();
    final plantsJson = prefs.getString(_plantsKey);
    List<Plant> myPlants = [];

    if (plantsJson != null) {
      final List<dynamic> plantsList = jsonDecode(plantsJson);
      myPlants = plantsList.map((json) => Plant.fromJson(json)).toList();
    }

    if (!myPlants.any((p) => p.name == plant.name)) {
      myPlants.add(plant);
      final updatedPlantsJson = jsonEncode(myPlants.map((p) => p.toJson()).toList());
      await prefs.setString(_plantsKey, updatedPlantsJson);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(plantAddedMessage),
        ),
      );
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(plantAlreadyAddedMessage),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: AppLocalizations.of(context)!.recommendedPlants,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: recommendedPlants.length,
          itemBuilder: (context, index) {
            final plant = recommendedPlants[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                title: Text(
                  plant.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  '${plant.description}\n${AppLocalizations.of(context)!.region}: ${plant.region}',
                ),
                trailing: IconButton(
                  icon: const Icon(
                    Icons.add,
                    color: Colors.green,
                  ),
                  onPressed: () {
                    _addToMyPlants(plant);
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}