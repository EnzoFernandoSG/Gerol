import 'package:flutter/material.dart';
import '../widgets/base_screen.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: AppLocalizations.of(context)!.about,
      child: const Center(
        child: Text(
          'About this app:\nPlant Guide helps you manage and learn about plants.',
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}