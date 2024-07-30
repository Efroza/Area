import 'dart:convert';
import 'package:http/http.dart' as http;

/// La classe [AuthService] est la classe qui permet de gérer la connexion des utilisateurs.
/// # Résumé du rôle de la classe [AuthService]
/// Cette classe permet de gérer la connexion et l'inscription des utilisateurs.
/// Il y a deux fonctions dans cette classe : 
///  1. [logIn] : permet de se connecter.
///  2. [registration] : permet de s'inscrire.

class AuthService {
  final registrationUrl = Uri.parse("http://10.0.2.2:8080/signup"); /// URL de l'inscription.
  final logInUrl = Uri.parse("http://10.0.2.2:8080/signin"); /// URL de la connexion.
  final forgetPasswordUrl = Uri.parse("http://10.0.2.2:8080/forgetPassword"); /// URL de la récupération de mot de passe.

  Future<String> registration(firstName, lastName, email, password) async { /// Fonction qui permet de s'inscrire.
    var response = await http.post(registrationUrl, body: { /// On envoie les informations de l'utilisateur à l'URL de l'inscription.
      "first_name": firstName, /// On envoie le prénom de l'utilisateur.
      "last_name": lastName, /// On envoie le nom de l'utilisateur.
      "email": email, /// On envoie l'email de l'utilisateur.
      "password": password, /// On envoie le mot de passe de l'utilisateur.
    });
    return response.body; /// On retourne le résultat de l'inscription que le serveur envoie.
  }

  Future<List<dynamic>> logIn(userEmail, password) async {
    var response = await http.post(logInUrl, body: { /// On envoie les informations de l'utilisateur à l'URL de la connexion.
      "email": userEmail, /// On envoie l'email de l'utilisateur.
      "password": password, /// On envoie le mot de passe de l'utilisateur.
    });
    if (response.statusCode == 200) { /// Si le serveur renvoie un code 200, on retourne le token de l'utilisateur.
      var data = jsonDecode(response.body); /// On récupère les données du serveur.
      return [data['username'], data['Token']]; /// On retourne le user de l'utilisateur et son token.
    } else {
      return ["Failed"]; /// Sinon, on retourne "Failed".
    }
  }

  Future<String> forgetPassword(userEmail, newPassword) async { /// Fonction qui permet de changer le mot de passe de l'utilisateur.
    var response = await http.post(forgetPasswordUrl, body : {
      "email": userEmail, /// On envoie l'email de l'utilisateur.
      "password": newPassword, /// On envoie le nouveau mot de passe de l'utilisateur.
    });
    return response.body; /// On retourne le résultat de la récupération de mot de passe que le serveur envoie.
    }
}
