import 'package:app_area/Components/mixins/messages_mixin.dart';
import 'package:app_area/Components/screens/home_page/logged_in.dart';
import 'package:app_area/Components/screens/services/servicepage.dart';
import 'package:flutter/material.dart';
import '../../mixins/validation_mixin.dart';
import './services.dart';
import './utils.dart';
import './oauth.dart';
import '../../user.dart';

class ConnectService extends StatelessWidget with ValidationMixin {
  final Service service;
  final String token;
  final String imageUrl;
  final String email;
  final String name;

  ConnectService(
      {super.key,
      required this.service,
      required this.token,
      required this.imageUrl,
      required this.email,
      required this.name});

  String emailUser = '';
  String password = '';
  String getToken = '';
  String extra = '';

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    if (service.infos.length < 3) {
      Navigator.pop(context);
      return (const Text('Error'));
    }
    var infosextra =
        service.infos[3].replaceAll('{', '').replaceAll('}', '').split(',');
    var extraName = infosextra[0].split(':')[1];
    var extraRequired = infosextra[1].split(':')[1].trim();
    return Scaffold(
        appBar: AppBar(
          title: Text('Connection ${service.name}'),
          centerTitle: true,
        ),
        body: Container(
          margin: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipOval(
                  child: Image.network('http://10.0.2.2:8080/$imageUrl',
                      width: 100, height: 100, fit: BoxFit.cover, scale: 1.0),
                ),

                /// Liste des widgets de la page de connexion au service.
                service.infos[0] == 'true' ? emailField() : Container(),
                service.infos[1] == 'true' ? passwordField() : Container(),
                service.infos[2] == 'true' ? tokenField() : Container(),
                extraRequired == 'true' ? extraField(extraName) : Container(),
                submitButton(context),
                oauthButton(context, service)
              ],
            ),
          ),
        ));
  }

  /// # Widget [emailField]
  /// Ce widget permet de récupérer l'email de l'utilisateur, puis on vérifie l'email avec [validateEmail] dans [ValidationMixin].
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
        emailUser = value!;
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

  /// # Widget [tokenField]
  /// Ce widget permet de récupérer le token de l'utilisateur pour la connexion au service.
  Widget tokenField() {
    return TextFormField(
      obscureText: false,
      decoration: const InputDecoration(
        labelText: 'Token',
        hintText: 'Token',
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a token';
        }
        return null;
      },
      onSaved: (value) {
        getToken = value!;
      },
    );
  }

  /// # Widget [extraField]
  /// Ce widget permet de récupérer les informations supplémentaires pour la connexion au service.
  Widget extraField(name) {
    return TextFormField(
      obscureText: false,
      decoration: InputDecoration(
        labelText: name,
        hintText: name,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a valid $name';
        }
        return null;
      },
      onSaved: (value) {
        extra = value!;
      },
    );
  }

  /// # Widget [submitButton]
  /// Ce widget permet de soumettre le formulaire de connexion au service.
  Widget submitButton(context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 243, 85, 106),
        foregroundColor: Colors.white,
      ),
      onPressed: () async {
        if (formKey.currentState!.validate()) {
          formKey.currentState!.save();
          // print('Time to post $email and $password to my API');
          var newListInfo = [emailUser, password, getToken, extra];
          print("pressed on button");
          var response = await UtilsPost()
              .postConnexionService(service.name, newListInfo, token);
          print(response);
          if (response[0] == "error") {
            /// Si le serveur renvoie "error", alors on affiche un message d'erreur.
            // ignore: use_build_context_synchronously
            MessagesMixin().messageTopOfScreen(
                'Error',

                /// Affiche un message d'erreur.
                response[1],
                3,
                context,
                const Icon(Icons.error, color: Colors.red, size: 24.0));
          } else {
            MessagesMixin().popUp(
                "Success",
                response[1],
                LoggedInWidget(mail: email, name: name, token: token),
                context,
                const Icon(Icons.check_circle_outline,
                    color: Colors.green, size: 50.0));
          }
        }
      },
      child: const Text('Submit informations'),
    );
  }

  Widget oauthButton(context, service) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 243, 85, 106),
        foregroundColor: Colors.white,
      ),
      onPressed: () async {
        var response = await Utils().getOauthUrl(service.name);
        print(response[1]);
        if (response[0] == "error") {
          MessagesMixin().messageTopOfScreen(
              'Error',
              'Oauth is not available for this service',
              3,
              context,
              const Icon(Icons.error, color: Colors.red, size: 24.0));
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Oauth(
                      response[0],
                      response[1],
                      service.name,
                      token,
                      response[2],
                    )),
          );
          // print("done");
        }
        // if (response[0] == "error") {
        //   /// Si le serveur renvoie "error", alors on affiche un message d'erreur.
        //   // ignore: use_build_context_synchronously
        //   MessagesMixin().messageTopOfScreen(
        //       'Error',

        //       /// Affiche un message d'erreur.
        //       response[1],
        //       3,
        //       context,
        //       const Icon(Icons.error, color: Colors.red, size: 24.0));
        // } else {
        //   MessagesMixin().popUp(
        //       "Success",
        //       response[1],
        //       LoggedInWidget(mail: email, name: name, token: token),
        //       context,
        //       const Icon(Icons.check_circle_outline,
        //           color: Colors.green, size: 50.0));
        // }
      },
      child: const Text('Connect with OAuth'),
    );
  }
}
