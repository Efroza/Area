import 'dart:convert';

import 'package:app_area/Components/screens/personnal_applets/action_reaction.dart';
import 'package:flutter/material.dart';
import './user_applets.dart';
import 'package:http/http.dart' as http;

/// Dans ce fichier se trouve la classe [PopUpApplet] qui permet de créer une popup avec la description de l'applet.
/// # Résumé du rôle de la classe [PopUpApplet]
/// Cette classe permet de créer une popup avec la description de l'applet. Cette popup est affiché lorsque l'utilisateur clique sur une applet dans la page [UserApplets].
/// Cette classe est divisée en 2 fonctions :
/// - [popUpUserApplet] : Cette fonction permet de créer la popup avec la description de l'applet.
/// - [activateApplet] : Cette fonction permet d'activer ou de désactiver l'applet. Cette fonction appelle le serveur pour modifier l'état de l'applet.
class PopUpApplet {
  Future popUpUserApplet(userApplet, context, name, email, token, applets) {
    print(userApplet.activate);
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(userApplet.description),
            content: Text(userApplet.date),
            actions: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.black,
                  ),
                  child: const Text('Close'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                userApplet.activate
                    ? TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.red,
                        ),
                        child: const Text('Deactivate'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )
                    : TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.green,
                        ),
                        onPressed: () async {
                          await activateApplet(userApplet);
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pop();
                          // ignore: use_build_context_synchronously
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ActionReactionScreen(
                                        name: name,
                                        email: email,
                                        token: token,
                                        userapplets: applets,
                                      )),
                              (route) => false);
                        },
                        child: const Text('Activate'),
                      ),
              ]),
            ],
          );
        });
  }

  Future<String> activateApplet(userApplet) async {
    var url = Uri.parse('http://10.0.2.2:8080/applet/activate');
    print(userApplet.id);
    var response = await http.post(url,
        body: jsonEncode({
          'applet_id': userApplet.id,
        }));
    if (response.statusCode != 200) {
      print("Activate : ${response.statusCode}");
      var data = jsonDecode(response.body);
      print(data);
      return "Error";
    }
    userApplet.activate = true;
    var data = jsonDecode(response.body);
    print(data);
    return "Success";
  }
}
