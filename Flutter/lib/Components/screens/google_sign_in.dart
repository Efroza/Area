import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// La classe [GoogleSignInProvider] permet de connecter l'utilisateur via Google.
/// # Résumé du rôle de la classe [GoogleSignInProvider]
/// Cette classe permet de connecter l'utilisateur via Google.
/// Elle permet de se connecter, de se déconnecter et de récupérer les informations de l'utilisateur.
/// Elle est composée de deux fonctions :
///   1. [googleLogin] : permet de se connecter via Google.
///   2. [logout] : permet de se déconnecter.

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future googleLogin() async { /// Fonction qui permet de se connecter via Google.
    try {
      final googleUser = await googleSignIn.signIn(); /// On récupère les informations de l'utilisateur.
      if (googleUser == null) return; /// Si l'utilisateur n'existe pas, on ne fait rien.
      _user = googleUser;

      final googleAuth = await googleUser.authentication; /// On récupère les informations d'authentification de l'utilisateur.

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      ); /// On récupère les informations de l'utilisateur après son authentification.

      await FirebaseAuth.instance.signInWithCredential(credential); /// On connecte l'utilisateur à la base de données.
    } catch (e) {
      print(e.toString());
    }

    notifyListeners();
  }

  Future logout() async { /// Fonction qui permet de se déconnecter.
    if (await googleSignIn.isSignedIn()) { /// Si l'utilisateur est connecté, on le déconnecte.
      await googleSignIn.disconnect();
      FirebaseAuth.instance.signOut();
    } else { /// Sinon, on ne fait rien.
      FirebaseAuth.instance.signOut();
    }
  }
}
