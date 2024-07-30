import 'package:flutter/material.dart';
import '../mixins/validation_mixin.dart';
import 'login_screen.dart';
import '../link_database/authentification.dart';
import 'package:app_area/Components/mixins/messages_mixin.dart';

/// Dans ce fichier ce trouve la classe [SignUpScreen] qui permet de créer un compte utilisateur.

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  createState() {
    return SignUpScreenState();
  }
}

/// # Résumé de la classe [SignUpScreenState]
/// La classe [SignUpScreenState] permet de créer un compte utilisateur.
/// 1. Elle permet de récupérer les informations de l'utilisateur et de les envoyer à la base de données, via différentes fonctions dans [AuthService].
/// 2. Elle permet aussi de vérifier que les informations entrées par l'utilisateur sont correctes, via différentes fonctions dans [ValidationMixin].
/// 3. Elle permet aussi d'afficher des messages d'erreurs, via différentes fonctions dans [MessagesMixin].
/// 4. Elle est composée de plusieurs widgets, dont :
///   * [firstNameField] : permet de récupérer le prénom de l'utilisateur.
///   * [lastNameField] : permet de récupérer le nom de l'utilisateur.
///   * [emailField] : permet de récupérer l'email de l'utilisateur.
///   * [passwordField] : permet de récupérer le mot de passe de l'utilisateur.
///   * [confirmPasswordField] : permet de récupérer la confirmation du mot de passe de l'utilisateur.
///   * [submitButton] : permet de valider les informations entrées par l'utilisateur et de les envoyer à la base de données.
///   * [signIn] : permet de rediriger l'utilisateur vers la page de connexion.

class SignUpScreenState extends State<SignUpScreen> with ValidationMixin {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController(); /// Permet de récupérer le mot de passe de l'utilisateur.
  final TextEditingController _confirmPasswordController =
      TextEditingController(); /// Permet de récupérer la confirmation du mot de passe de l'utilisateur.

  String email = '';
  String firstName = '';
  String lastName = '';
  String password = '';
  String confirmPassword = '';

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Sign Up'),
          backgroundColor: const Color.fromARGB(255, 243, 85, 106)),
      body: Container(
        margin: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[ /// Permet de mettre les différents champs de saisie dans un ordre précis.
              firstNameField(),
              lastNameField(), 
              emailField(),
              passwordField(),
              confirmPasswordField(),
              submitButton(),
              Expanded( /// Création du boutton pour retourner vers la page [LoginScreen].
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('Already have an account ?',
                        style: TextStyle(fontSize: 16.0, color: Colors.black)),
                    signIn(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// # Widget [firstNameField]
  /// Permet de créer le champ de saisie pour le prénom de l'utilisateur, récupére la saisie de l'utilisateur, valide le nom d'utilisateur avec la fonction [validateName] puis la stocke dans la variable [firstName].
  Widget firstNameField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        labelText: 'First Name',
        hintText: 'John',
      ),
      validator: validateName,
      onSaved: (value) {
        firstName = value!;
      },
    );
  }

  /// # Widget [lastNameField]
  /// Permet de créer le champ de saisie pour le nom de l'utilisateur, récupére la saisie de l'utilisateur, valide le nom d'utilisateur avec la fonction [validateName] puis la stocke dans la variable [lastName].
  Widget lastNameField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        labelText: 'Last Name',
        hintText: 'Doe',
      ),
      validator: validateName,
      onSaved: (value) {
        lastName = value!;
      },
    );
  }

  /// # Widget [emailField]
  /// Permet de créer le champ de saisie pour l'email de l'utilisateur, récupére la saisie de l'utilisateur, valide l'email avec la fonction [validateEmail] puis la stocke dans la variable [email].
  Widget emailField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
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
  /// Permet de créer le champ de saisie pour le mot de passe de l'utilisateur, récupére la saisie de l'utilisateur, valide le mot de passe avec la fonction [validatePassword] puis la stocke dans la variable [password].
  Widget passwordField() {
    return TextFormField(
      obscureText: true,
      decoration: const InputDecoration(
        labelText: 'Password',
        hintText: 'Password',
      ),
      controller: _passwordController,
      validator: validatePassword,
      onSaved: (value) {
        password = value!;
      },
    );
  }

  /// # Widget [confirmPasswordField]
  /// Permet de créer le champ de saisie pour la confirmation du mot de passe de l'utilisateur, récupére la saisie de l'utilisateur, valide la confirmation du mot de passe en comparant [_passwordController] et [password] puis la stocke dans la variable [confirmPassword].
  Widget confirmPasswordField() {
    return TextFormField(
      obscureText: true,
      decoration: const InputDecoration(
        labelText: 'Confirm Password',
        hintText: 'Confirm Password',
      ),
      controller: _confirmPasswordController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please confirm your password';
        } else if (value != _passwordController.text) {
          return 'Passwords do not match';
        }
        return null;
      },
      onSaved: (value) {
        confirmPassword = value!;
      },
    );
  }

  /// # Widget [submitButton]
  /// Permet de créer le bouton pour valider la création du compte de l'utilisateur, vérifie que le formulaire est valide en regardant chaque variables => [firstName], [lastName], [email], [password], [confirmPassword].
  /// Si le formulaire est valide, alors on envoie les données au serveur via la fonction ```dart
  /// await authService.registration(firstName, lastName, email, password);
  /// ``` puis on affiche une popup avec [MessagesMixin.popUp] et on redirige l'utilisateur vers la page [LoginScreen] si la création du compte est un succès.
  /// Sinon, on affiche un message d'erreur avec [MessagesMixin.messageTopOfScreen].
  Widget submitButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 243, 85, 106),
        foregroundColor: Colors.white,
      ),
      child: const Text('Create account'),
      onPressed: () async {
        if (formKey.currentState!.validate()) { /// Vérifie que le formulaire est valide.
          formKey.currentState!.save();
          AuthService authService = AuthService();
          var response = await authService.registration(
              firstName, lastName, email, password); /// Envoie les données au serveur et récupére la réponse.
          if (response == "Email already exists") { /// Si le serveur renvoie "Email already exists", alors on affiche un message d'erreur.
            // ignore: use_build_context_synchronously
            MessagesMixin().messageTopOfScreen('Error', /// Affiche un message d'erreur.
            'Email already used',
            3,
            context,
            const Icon(Icons.error, color: Colors.red, size: 24.0));
          } else { /// Sinon, on affiche une popup disant qu'un email a été envoyé ensuite on redirige l'utilisateur vers la page LoginScreen
            // ignore: use_build_context_synchronously
            MessagesMixin().popUp('Account created', /// Affiche une popup disant qu'un email a été envoyé.
            'A verification email has been sent to $email',
            const LoginScreen(),
            context,
            const Icon (Icons.check_circle_outline, color: Colors.green, size: 50.0));
          }
        }
      },
    );
  }

  /// # Widget [signIn]
  /// Permet de créer un bouton dans un text qui redirige l'utilisateur vers la page [LoginScreen].
  Widget signIn() {
    return Container(
      alignment: Alignment.center,
      child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        },
        child: Text(
          'Sign In Here !',
          style: TextStyle(
            foreground: Paint()
              ..shader = const LinearGradient(
                colors: <Color>[
                  Color.fromARGB(255, 0, 108, 196),
                  Color.fromARGB(255, 0, 105, 192)
                ],
              ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
