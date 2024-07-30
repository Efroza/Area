import 'package:app_area/Components/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:app_area/Components/link_database/authentification.dart';
import 'package:app_area/Components/mixins/validation_mixin.dart';
import 'package:app_area/Components/screens/sign_up_screen.dart';
import 'package:app_area/Components/mixins/messages_mixin.dart';

/// Dans ce fichier ce trouve la classe [ForgotScreen] qui permet à l'utilisateur de récupérer son mot de passe.
class ForgotScreen extends StatefulWidget {
  const ForgotScreen({super.key});

  @override
  createState() {
    return ForgotScreenState();
  }
}

/// # Résumé de la classe [ForgotScreenState]
/// La classe [ForgotScreenState] permet à l'utilisateur de récupérer son mot de passe.
/// 1. Elle permet de récupérer l'email de l'utilisateur et de l'envoyer à la base de données via la classe [AuthService], qui enverra ensuite un email à l'utilisateur.
/// 2. Elle permet aussi de vérifier les informations entré par l'utilisateur est correct, via la classe [ValidationMixin].
/// 3. Elle permet aussi d'afficher des messages d'erreurs, via la classe [MessagesMixin].
/// 4. Cette classe est composée de différentes widget :
///   * [emailField] : permet de récupérer l'email de l'utilisateur.
///   * [newPassword] : permet de récupérer le nouveau mot de passe de l'utilisateur.
///   * [submitButton] : permet de valider les informations entrées par l'utilisateur et de les envoyer à la base de données.
///   * [descriptionPage] : permet d'afficher une description de la page.
///   * [signUp] : permet de rediriger l'utilisateur vers la page de création de compte.

class ForgotScreenState extends State<ForgotScreen> with ValidationMixin {
  final formKey = GlobalKey<FormState>();

  /// Permet de vérifier les informations de l'utilisateur dans le form
  final TextEditingController _passwordController = TextEditingController();

  /// Permet de récupérer le nouveau mot de passe de l'utilisateur.
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  /// Permet de récupérer la confirmation du mot de passe de l'utilisateur.

  String email = '';
  String password = '';
  String confirmPassword = '';

  @override
  Widget build(context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      /// Permet de faire en sorte que le clavier cache les widgets et de pas avoir les problèmes de taille de widget quand apparait le clavier.
      appBar: AppBar(
          title: const Text('Forgot your password ?'),
          backgroundColor: const Color.fromARGB(255, 243, 85, 106)),
      body: Container(
        margin: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: descriptionPage(),
                  ),
                ],
              ),
              Expanded(
                flex: 1,
                child: Column(
                  /// We create the different widget of the page and put them in a column.
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    emailField(),
                    newPassword(),
                    confirmNewPassword(),
                    submitButton(),
                  ],
                ),
              ),
              Expanded(
                /// Change to Row to be able to align Text with sign up button
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('Don' 't have an account ?',
                        style: TextStyle(fontSize: 16.0, color: Colors.black)),
                    signUp(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// La méthode [descriptionPage] permet d'afficher une description de la page.
  /// Elle retourne un widget [Text] qui affiche une description de la page.
  Text descriptionPage() {
    return const Text(
      "Enter your email adress and your new password and we will send you a link to validate your new password.",
      style: TextStyle(
        fontSize: 18,
        color: Colors.black,
      ),
    );
  }

  /// La méthode [emailField] permet de récupérer l'email de l'utilisateur.
  /// Elle retourne un widget [TextFormField] qui permet de récupérer l'email de l'utilisateur et valide l'email avec [validateEmail].
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

  /// La méthode [newPassword] permet de récupérer le nouveau mot de passe de l'utilisateur.
  /// Elle retourne un widget [TextFormField] qui permet de récupérer le nouveau mot de passe de l'utilisateur et valide le mot de passe avec [validatePassword].
  /// Afin de vérifier si [password] est identique à [confirmPassword], on initialise un [_passwordController] qui sera utiliser dans [confirmNewPassword]
  Widget newPassword() {
    return TextFormField(
      obscureText: true,
      decoration: const InputDecoration(
        labelText: 'New Password',
        hintText: 'New Password',
      ),
      controller: _passwordController,
      validator: validatePassword,
      onSaved: (value) {
        password = value!;
      },
    );
  }

  /// La méthode [confirmNewPassword] permet de récupérer la confirmation du nouveau mot de passe de l'utilisateur.
  /// Elle retourne un widget [TextFormField] qui permet de récupérer la confirmation du nouveau mot de passe de l'utilisateur.
  /// Afin de vérifier si [password] est identique à [confirmPassword], on compare [_passwordController] avec la value entrée par l'utilisateur.
  Widget confirmNewPassword() {
    return TextFormField(
      obscureText: true,
      decoration: const InputDecoration(
        labelText: 'Confirm New Password',
        hintText: 'Confirm New Password',
      ),
      controller: _confirmPasswordController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a password';
        }
        if (value != _passwordController.text) {
          return 'Passwords do not match';
        }
        return null;
      },
      onSaved: (value) {
        confirmPassword = value!;
      },
    );
  }

  /// La méthode [submitButton] permet de valider les informations entrées par l'utilisateur et de les envoyer à la base de données.
  /// Elle va vérifier si le formulaire est valide avec [formKey] et va ensuite envoyer [email] et [password] au serveur avec [AuthService.forgetPassword].
  /// Si le serveur renvoie 'An email has been sent to you to confirm your new password', alors on affiche une popup avec [MessagesMixin.popUp].
  /// Sinon, on affiche une FlushBar avec [MessagesMixin.messageTopOfScreen] et on affiche l'erreur du serveur.
  Widget submitButton() {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 243, 85, 106),
          foregroundColor: Colors.white,
        ),
        child: const Text('Reset Password'),
        onPressed: () async {
          if (formKey.currentState!.validate()) {
            formKey.currentState!.save();
            AuthService sendNewPassword = AuthService();
            final response =
                await sendNewPassword.forgetPassword(email, password);

            /// On envoie l'email et le nouveau mot de passe au serveur et on garde la réponse de ce dernier.
            if (response ==
                'An email has been sent to you to confirm your new password') {
              /// Reponse positive du serveur, on affiche une popup et on renvoie vers la page d'accueil
              // ignore: use_build_context_synchronously
              MessagesMixin().popUp(

                  /// Voir MessagesMixin pour plus d'informations
                  'Success',
                  'An email has been sent to $email to confirm your new password.',
                  const LoginScreen(),
                  context,
                  const Icon(Icons.check_circle_outline,
                      color: Colors.green, size: 50));
            } else {
              /// Reponse negative du serveur, on affiche un message d'erreur.
              // ignore: use_build_context_synchronously
              MessagesMixin().messageTopOfScreen(
                  'Error',
                  response,
                  3,
                  context,
                  const Icon(
                    Icons.error,
                    color: Colors.red,
                    size: 28.0,
                  ));
            }
          }
        });
  }

  /// La méthode [signUp] permet de rediriger l'utilisateur vers la page de création de compte.
  Widget signUp() {
    return Container(
      alignment: Alignment.center,
      child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SignUpScreen()),
          );
        },
        child: Text(
          'Sign Up Here !',
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
