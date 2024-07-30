import 'package:flutter/material.dart';
import '../sidebar.dart';

/// La classe [SettingsScreen] est la classe qui permet d'afficher les paramètres de l'application.
/// # Résumé du rôle de la classe [SettingsScreen]
/// Cette classe permet d'afficher les paramètres de l'application.
class SettingsScreen extends StatelessWidget {
  final String name;
  final String email;
  final String token;

  const SettingsScreen({Key? key, required this.name, required this.email, required this.token})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
        flexibleSpace: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
          image: NetworkImage(
              "https://i.pinimg.com/474x/75/af/d4/75afd4263c2d06662c52ac8e9fd0e155.jpg"),
          fit: BoxFit.cover,
        ))),
      ),
      body: const Center(
        child: Text('Settings'),
      ),
      drawer: SideBar(name: name, email: email, token: token),
    );
  }
}
