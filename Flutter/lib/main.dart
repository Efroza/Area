import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:app_area/Components/app.dart';

/// La fonction main est le point d'entrée de l'application.
///
/// Il s'agit de la première fonction à être appelée lorsque l'application est lancée.
///
/// ```dart
/// await Firebase.initializeApp();
/// ```
/// Cette fonction permet d'initialiser Firebase qui nous servira ensuite pour la connexion des utilisateurs via google
/// ```dart
/// runApp(const App());
/// ```
/// Cette fonction permet ensuite de lancer l'application [App].
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const App());
}
