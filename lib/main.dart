import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import './Theme/color_schemes.g.dart';

import './app.dart';

void main() {
    runApp(const ProviderScope(child: MyStudyLife()));
}

final themeModeProvider = StateProvider<ThemeMode>((ref) {
  return ThemeMode.dark;
});

class MyStudyLife extends ConsumerWidget {
  const MyStudyLife({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themMode = ref.watch(themeModeProvider);

    return MaterialApp(
      title: 'Flutter Demo',
        theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
       // textTheme: textTheme,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: darkColorScheme,
       // textTheme: textTheme,
      ),
      themeMode: themMode,
      home: const App(),
    );
  }
}

