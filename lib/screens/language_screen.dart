import 'package:flutter/material.dart';
import '../widgets/base_screen.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);

    return BaseScreen(
      title: AppLocalizations.of(context)!.language,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.selectLanguage,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ListTile(
              title: const Text('English'),
              onTap: () {
                languageProvider.setLocale(const Locale('en'));
              },
            ),
            ListTile(
              title: const Text('Português'),
              onTap: () {
                languageProvider.setLocale(const Locale('pt'));
              },
            ),
          ],
        ),
      ),
    );
  }
}