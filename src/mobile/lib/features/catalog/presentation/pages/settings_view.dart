import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_catalog_app/app/locale_cubit.dart';
import 'package:media_catalog_app/core/theme/theme_cubit.dart';
import 'package:media_catalog_app/features/catalog/presentation/widgets/settings_section_card.dart';
import 'package:media_catalog_app/generated/app_localizations.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return SafeArea(
      top: false,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
        children: [
          Text(
            l10n.settingsTitle,
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 6),
          Text(
            l10n.settingsSubtitle,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 28),
          SettingsSectionCard(
            icon: Icons.palette_outlined,
            title: l10n.appearance,
            description: l10n.themeDescription,
            child: BlocBuilder<ThemeCubit, ThemeMode>(
              builder: (context, mode) => SegmentedButton<ThemeMode>(
                showSelectedIcon: false,
                segments: [
                  ButtonSegment(
                    value: ThemeMode.system,
                    icon: const Icon(Icons.brightness_auto_rounded),
                    label: Text(l10n.systemTheme),
                  ),
                  ButtonSegment(
                    value: ThemeMode.light,
                    icon: const Icon(Icons.light_mode_outlined),
                    label: Text(l10n.lightTheme),
                  ),
                  ButtonSegment(
                    value: ThemeMode.dark,
                    icon: const Icon(Icons.dark_mode_outlined),
                    label: Text(l10n.darkTheme),
                  ),
                ],
                selected: {mode},
                onSelectionChanged: (selection) =>
                    context.read<ThemeCubit>().setMode(selection.first),
              ),
            ),
          ),
          const SizedBox(height: 16),
          SettingsSectionCard(
            icon: Icons.translate_rounded,
            title: l10n.language,
            description: l10n.languageDescription,
            child: BlocBuilder<LocaleCubit, Locale>(
              builder: (context, locale) => SegmentedButton<String>(
                segments: [
                  ButtonSegment(value: 'en', label: Text(l10n.english)),
                  ButtonSegment(value: 'pt', label: Text(l10n.portuguese)),
                ],
                selected: {locale.languageCode},
                onSelectionChanged: (selection) => context
                    .read<LocaleCubit>()
                    .setLocale(Locale(selection.first)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
