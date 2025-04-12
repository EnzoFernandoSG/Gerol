import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/base_screen.dart';
import '../models/plant.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'plant_detail_screen.dart';
import 'add_plant_screen.dart';

class PlantsScreen extends StatefulWidget {
  const PlantsScreen({super.key});

  @override
  State<PlantsScreen> createState() => _PlantsScreenState();
}

class _PlantsScreenState extends State<PlantsScreen> {
  List<Plant> plants = [];
  static const String _plantsKey = 'user_plants';

  Future<List<Plant>> _loadPlants() async {
    final prefs = await SharedPreferences.getInstance();
    final plantsJson = prefs.getString(_plantsKey);
    if (plantsJson != null) {
      final List<dynamic> plantsList = jsonDecode(plantsJson);
      return plantsList.map((json) => Plant.fromJson(json)).toList();
    } else {
      return [
        Plant(
          name: 'Sunflower',
          description: 'Bright yellow flowers that thrive in sunny regions.',
          region: 'Warm climates',
          light: 'Full sun',
          watering: 'Water once a week',
          soil: 'Well-drained soil',
        ),
        Plant(
          name: 'Tomato',
          description: 'Edible fruit that needs well-drained soil and full sun.',
          region: 'Temperate climates',
          light: 'Full sun',
          watering: 'Water 2-3 times a week',
          soil: 'Rich, well-drained soil',
        ),
        Plant(
          name: 'Lavender',
          description: 'Fragrant herb that prefers dry, sunny conditions.',
          region: 'Mediterranean climates',
          light: 'Full sun',
          watering: 'Water sparingly, once every 2 weeks',
          soil: 'Sandy, well-drained soil',
        ),
      ];
    }
  }

  Future<void> _savePlants() async {
    final prefs = await SharedPreferences.getInstance();
    final plantsJson = jsonEncode(plants.map((plant) => plant.toJson()).toList());
    await prefs.setString(_plantsKey, plantsJson);
  }

  Future<bool> _confirmDelete(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.deletePlant),
          content: Text(AppLocalizations.of(context)!.confirmDeletePlant),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(AppLocalizations.of(context)!.cancel),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(AppLocalizations.of(context)!.delete),
            ),
          ],
        );
      },
    ) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: AppLocalizations.of(context)!.myPlants,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newPlant = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddPlantScreen()),
          );
          if (newPlant != null) {
            setState(() {
              plants.add(newPlant);
            });
            await _savePlants();
          }
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
      child: FutureBuilder<List<Plant>>(
        future: _loadPlants(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error loading plants: ${snapshot.error}',
                style: const TextStyle(fontSize: 18, color: Colors.red),
              ),
            );
          } else {
            plants = snapshot.data ?? [];
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: plants.isEmpty
                  ? Center(
                      child: Text(
                        AppLocalizations.of(context)!.noPlants,
                        style: const TextStyle(fontSize: 18),
                      ),
                    )
                  : ListView.builder(
                      itemCount: plants.length,
                      itemBuilder: (context, index) {
                        final plant = plants[index];
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
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () async {
                                // Capturar o ScaffoldMessenger antes do await
                                final scaffoldMessenger = ScaffoldMessenger.of(context);
                                final plantDeletedMessage = AppLocalizations.of(context)!.plantDeleted;
                                final undoLabel = AppLocalizations.of(context)!.undo;
                                final confirm = await _confirmDelete(context);
                                if (confirm) {
                                  setState(() {
                                    plants.removeAt(index);
                                  });
                                  await _savePlants();
                                  if (!mounted) return;
                                  scaffoldMessenger.showSnackBar(
                                    SnackBar(
                                      content: Text(plantDeletedMessage),
                                      action: SnackBarAction(
                                        label: undoLabel,
                                        onPressed: () {
                                          setState(() {
                                            plants.insert(index, plant);
                                          });
                                          _savePlants();
                                        },
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PlantDetailScreen(plant: plant),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
            );
          }
        },
      ),
    );
  }
}