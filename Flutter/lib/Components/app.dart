import 'package:flutter/material.dart';
import 'package:app_area/Components/screens/home_page/logged_in.dart';
import 'package:app_area/Components/screens/settings_screen.dart';
import 'package:provider/provider.dart';
import 'screens/login_screen.dart';
import 'screens/google_sign_in.dart';
import 'screens/home_page_screen.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

/// La classe [App] est la classe principale de l'application, permettant de lancer l'application et de définir les différents thèmes de l'application.
/// # Résumé du rôle de la classe App
/// Cette classe permet de lancer l'application et de définir les différents thèmes de l'application.
/// Permet de Setup le theme de l'application et de changer le dark mode : 
/// ```dart
/// initial: AdaptiveThemeMode.light,
/// ```
/// 
/// Avec un lien vers la classe [HomePage].
/// ```dart
/// home: HomePage(),
/// ```
class App extends StatelessWidget {
  static const String _title = 'Area flutter';

  const App({super.key});

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
    create: (context) => GoogleSignInProvider(),
    child: AdaptiveTheme(
      /// Définition du thème de base de l'application
      /// C'est aussi ce qui nous permettra de changer entre le dark et light mode dans l'application.
      light: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
      ),
      dark: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      initial: AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: _title,
        theme: theme,
        darkTheme: darkTheme,
        home: HomePage(), /// Définit la page d'accueil de l'application.
        routes: { /// Permet de définir les différentes routes de l'application pour ne pas avoir à import chaque fichier à chaque fois.
          '/login': (context) => const LoginScreen(),
          '/settings': (context) => const SettingsScreen(email: 'qzds', name: '', token: ''),
          '/logged': (context) => LoggedInWidget(name: '', mail: '', token: ''),
        },
      ),
    ),
  );
}