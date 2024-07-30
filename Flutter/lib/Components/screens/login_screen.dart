import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../mixins/validation_mixin.dart';
import 'forgot_password_screen.dart';
import 'google_sign_in.dart';
import 'package:provider/provider.dart';
import '../link_database/authentification.dart';
import 'home_page/logged_in.dart';
import 'sign_up_screen.dart';

/// Dans ce fichier ce trouve la classe [LoginScreen] qui permet de se connecter à un compte utilisateur existant.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  createState() {
    return LoginScreenState();
  }
}

/// # Résumé de la classe [LoginScreenState]
/// La classe [LoginScreenState] permet de se connecter à un compte utilisateur existant.
/// Elle permet de récupérer les informations de l'utilisateur et de les envoyer à la base de données, via différentes fonctions dans [AuthService].
/// Elle permet aussi de vérifier que les informations entrées par l'utilisateur sont correctes, via différentes fonctions dans [ValidationMixin].
/// Elle est composée de plusieurs widgets, dont :
///   * [emailField] : permet de récupérer l'email de l'utilisateur.
///   * [passwordField] : permet de récupérer le mot de passe de l'utilisateur.
///   * [submitButton] : permet de valider les informations entrées par l'utilisateur et de les envoyer à la base de données.
///   * [forgotPassword] : permet de rediriger l'utilisateur vers la page de récupération de mot de passe.
///   * [GoogleSignIn] : permet de rediriger l'utilisateur vers la page de connexion avec Google.
///   * [noAccount] : permet de rediriger l'utilisateur vers la page de création de compte.

class LoginScreenState extends State<LoginScreen> with ValidationMixin {
  final formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';

  /// [email] et [password] sont les variables qui vont contenir les informations entrées par l'utilisateur.

  @override
  Widget build(context) {
    return Scaffold(
        body: Container(
      margin: const EdgeInsets.all(20.0),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// Liste des widgets de la page de connexion.
            emailField(),
            passwordField(),
            submitButton(),
            forgotPassword(),
            GoogleSignIn(),
            noAccount(),
          ],
        ),
      ),
    ));
  }

  /// # Widget [emailField]
  /// Ce widget permet de récupérer l'email de l'utilisateur, et de vérifier celui-ci via la fonction [validateEmail] dans [ValidationMixin].
  Widget emailField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,

      /// Permet de récupérer l'input de l'utilisateur sous forme d'email.
      decoration: const InputDecoration(
        labelText: 'Email',
        hintText: 'you@example.com',
      ),
      validator: validateEmail,
      onSaved: (value) {
        email = value!;
      },
    );
  }

  /// # Widget [passwordField]
  /// Ce widget permet de récupérer le mot de passe de l'utilisateur, et de vérifier celui-ci via la fonction [validatePassword] dans [ValidationMixin].
  Widget passwordField() {
    return TextFormField(
      obscureText: true,

      /// Permet de cacher le mot de passe de l'utilisateur.
      decoration: const InputDecoration(
        labelText: 'Password',
        hintText: 'Password',
      ),
      validator: validatePassword,
      onSaved: (value) {
        password = value!;
      },
    );
  }

  /// # Widget [forgotPassword]
  /// Ce widget permet de rediriger l'utilisateur vers la page de récupération de mot de passe.
  Widget forgotPassword() {
    return Container(
      alignment: Alignment.center,
      child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ForgotScreen()),
          );
        },

        /// Redirige l'utilisateur vers la page de récupération de mot de passe.
        child: Text(
          'Forgot Password?',
          style: TextStyle(
            foreground: Paint()
              ..shader = const LinearGradient(
                colors: <Color>[Colors.grey, Colors.grey],
              ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  /// # Widget [submitButton]
  /// Ce widget permet de vérifier que les informations entrées par l'utilisateur sont correctes via [formKey].
  /// Si les informations sont correctes, les données sont envoyés au serveur via la fonction [AuthService.logIn].
  /// Selon le résultat reçu, l'utilisateur est redirigé vers la page d'accueil ou un message d'erreur est affiché.
  Widget submitButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 243, 85, 106),
        foregroundColor: Colors.white,
      ),
      child: const Text('Sign In'),
      onPressed: () async {
        if (formKey.currentState!.validate()) {
          /// Vérifie que les informations entrées par l'utilisateur sont correctes.
          formKey.currentState!.save();
          AuthService loginService = AuthService();
          var response = await loginService.logIn(email, password);

          /// Envoie les informations entrées par l'utilisateur au serveur.
          if (response.contains("Failed")) {
            /// Si le serveur renvoie "Failed", un message d'erreur est affiché.
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Email or Password incorrect.'),
              ),
            );
            // print("Successfully connected");
          } else {
            /// Si le serveur renvoie autre chose que "Failed", l'utilisateur est redirigé vers la page d'accueil.
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      LoggedInWidget(name: response[0], mail: email, token: response[1])),
            );
          }
        }
      },
    );
  }

  /// # Widget [GoogleSignIn]
  /// Ce widget permet de rediriger l'utilisateur vers la page de connexion avec Google via :
  /// ```dart
  /// final provider =
  ///             Provider.of<GoogleSignInProvider>(context, listen: false);
  ///         await provider.googleLogin();
  /// ```
  /// Si l'utilisateur est déjà connecté, il est redirigé vers la page d'accueil.
  Widget GoogleSignIn() {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 243, 85, 106),
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 50),
      ),
      icon: const FaIcon(FontAwesomeIcons.google, color: Colors.black),
      label: const Text('Sign Up with Google'),
      onPressed: () async {
        final provider =
            Provider.of<GoogleSignInProvider>(context, listen: false);

        /// Permet de récupérer les informations de l'utilisateur.
        await provider.googleLogin();

        /// Redirige l'utilisateur vers la page de connexion avec Google.
        final user = FirebaseAuth.instance.currentUser!;

        /// Récupère les informations de l'utilisateur.
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  LoggedInWidget(name: user.displayName!, mail: user.email!, token:'')),
        );
      },
    );
  }

  /// # Widget [noAccount]
  /// Ce widget permet de rediriger l'utilisateur vers la page d'inscription [SignUpScreen].
  Widget noAccount() {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SignUpScreen()),
          );
        },
        child: Text(
          'Sign Up',
          style: TextStyle(
            foreground: Paint()
              ..shader = const LinearGradient(
                colors: <Color>[
                  Color.fromARGB(255, 243, 85, 106),
                  Color.fromARGB(255, 243, 85, 106),
                ],
              ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
