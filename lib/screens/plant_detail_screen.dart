import 'package:flutter/material.dart';
import '../widgets/base_screen.dart';
import '../models/plant.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class PlantDetailScreen extends StatelessWidget {
  final Plant plant;

  const PlantDetailScreen({super.key, required this.plant});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: plant.name,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              AppLocalizations.of(context)!.description,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(plant.description),
            const SizedBox(height: 16),
            Text(
              AppLocalizations.of(context)!.region,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(plant.region),
            const SizedBox(height: 16),
            Text(
              AppLocalizations.of(context)!.light,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(plant.light),
            const SizedBox(height: 16),
            Text(
              AppLocalizations.of(context)!.watering,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(plant.watering),
            const SizedBox(height: 16),
            Text(
              AppLocalizations.of(context)!.soil,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(plant.soil),
          ],
        ),
      ),
    );
  }
}