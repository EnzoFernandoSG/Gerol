import 'package:flutter/material.dart';
import '../widgets/base_screen.dart';
import '../models/plant.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class AddPlantScreen extends StatefulWidget {
  const AddPlantScreen({super.key});

  @override
  State<AddPlantScreen> createState() => _AddPlantScreenState();
}

class _AddPlantScreenState extends State<AddPlantScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _regionController = TextEditingController();
  final _lightController = TextEditingController();
  final _wateringController = TextEditingController();
  final _soilController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _regionController.dispose();
    _lightController.dispose();
    _wateringController.dispose();
    _soilController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final newPlant = Plant(
        name: _nameController.text,
        description: _descriptionController.text,
        region: _regionController.text,
        light: _lightController.text,
        watering: _wateringController.text,
        soil: _soilController.text,
      );
      Navigator.pop(context, newPlant);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: AppLocalizations.of(context)!.addPlant,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.name,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context)!.pleaseEnterName;
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.description,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context)!.pleaseEnterDescription;
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _regionController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.region,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context)!.pleaseEnterRegion;
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _lightController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.light,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context)!.pleaseEnterLight;
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _wateringController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.watering,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context)!.pleaseEnterWatering;
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _soilController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.soil,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context)!.pleaseEnterSoil;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                child: Text(AppLocalizations.of(context)!.add),
              ),
            ],
          ),
        ),
      ),
    );
  }
}