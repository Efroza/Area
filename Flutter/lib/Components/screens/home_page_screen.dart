import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_page/logged_in.dart';

/// La classe [HomePage] est la classe qui permet de rediriger vers [LoginScreen] et connecter Firebase.
/// # Résumé du rôle de la classe [HomePage]
/// Cette classe permet de rediriger vers [LoginScreen] et connecter Firebase.
/// Si l'utilisateur est déjà connecté redirige automatiquement vers [LoggedInWidget].

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(), /// Connecte Firebase
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) { /// Si l'utilisateur est en train de se connecter affiche un cercle d'attente.
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) { /// Si l'utilisateur est connecté redirige vers page d'accueil de l'utilisateur.
              String? nameUser = snapshot.data?.displayName!; /// Récupère le nom de l'utilisateur.
              String? emailUser = snapshot.data?.email!; /// Récupère l'email de l'utilisateur.
              return LoggedInWidget(name: nameUser!, mail: emailUser!, token: '');
            } else if (snapshot.hasError) { /// Si il y a une erreur aevc Firebase affiche un message d'erreur.
              return const Center(child: Text('Something went wrong!'));
            } else { /// Sinon redirige vers la page de connexion.
              return const LoginScreen();
            }
          },
        ),
      );
}
