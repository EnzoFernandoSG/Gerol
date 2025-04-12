import 'package:flutter/material.dart';
import '../widgets/base_screen.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Função para obter a dica do dia com base no dia do ano
  String _getDailyTip(BuildContext context) {
    final List<String> tipsKeys = [
      'tipWaterPlants',
      'tipCheckSoil',
      'tipPrunePlants',
      'tipFertilize',
      'tipCheckLight',
      'tipRotatePlants',
      'tipCleanLeaves',
      'tipMonitorPests',
      'tipWaterDeeply',
      'tipAvoidOverwatering',
    ];

    // Usa o dia do ano para selecionar uma dica (cíclico)
    final int dayOfYear = DateTime.now().difference(DateTime(DateTime.now().year, 1, 1)).inDays;
    final int tipIndex = dayOfYear % tipsKeys.length;
    final String tipKey = tipsKeys[tipIndex];

    // Retorna a dica localizada com base na chave
    switch (tipKey) {
      case 'tipWaterPlants':
        return AppLocalizations.of(context)!.tipWaterPlants;
      case 'tipCheckSoil':
        return AppLocalizations.of(context)!.tipCheckSoil;
      case 'tipPrunePlants':
        return AppLocalizations.of(context)!.tipPrunePlants;
      case 'tipFertilize':
        return AppLocalizations.of(context)!.tipFertilize;
      case 'tipCheckLight':
        return AppLocalizations.of(context)!.tipCheckLight;
      case 'tipRotatePlants':
        return AppLocalizations.of(context)!.tipRotatePlants;
      case 'tipCleanLeaves':
        return AppLocalizations.of(context)!.tipCleanLeaves;
      case 'tipMonitorPests':
        return AppLocalizations.of(context)!.tipMonitorPests;
      case 'tipWaterDeeply':
        return AppLocalizations.of(context)!.tipWaterDeeply;
      case 'tipAvoidOverwatering':
        return AppLocalizations.of(context)!.tipAvoidOverwatering;
      default:
        return AppLocalizations.of(context)!.tipWaterPlants; // Fallback
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: AppLocalizations.of(context)!.home,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.welcome,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.dailyTip,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _getDailyTip(context),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}