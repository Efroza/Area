import 'package:another_flushbar/flushbar.dart';
import 'package:app_area/Components/screens/creation_applets/applets.dart';
import 'package:app_area/Components/screens/home_page/logged_in.dart';
import 'package:app_area/Components/screens/services/servicepage.dart';
import 'package:flutter/material.dart';
import 'package:app_area/Components/screens/creation_applets/send_applet.dart';

/// # Résumé de la classe [MessagesMixin]
/// La classe [MessagesMixin] permet d'afficher des messages customiser.
/// Elle affiche soit des messages en haut de l'écran [messageTopOfScreen], soit des messages en bas de l'écran [messageBottomOfScreen].
/// Les messages sont affichés avec la librairie [another_flushbar](https://pub.dev/packages/another_flushbar).
/// Chaque message a besoin de :
///   * [context] : le contexte de l'écran où le message doit être affiché.
///   * [message] : le message à afficher.
///   * [title] : le titre du message.
///   * [duration] : la durée pendant laquelle le message doit être affiché.
///   * [icon] : l'icone à afficher avec le message.
///
/// Cette classe permet aussi d'afficher des popUp [popUp].
/// Les popUp ont besoin de :
///   * [context] : le contexte de l'écran où le message doit être affiché.
///   * [title] : le titre du message.
///   * [message] : le message à afficher.
///   * [linkPage] : la page vers laquelle l'utilisateur doit être redirigé une fois que la popup est fermée.
///   * [icon] : l'icone à afficher avec le message.
class MessagesMixin {
  final List _mandatory = [];
  final formKey = GlobalKey<FormState>();
  String _description = '';

  Future messageTopOfScreen(title, message, duration, context, icon) {
    /// Affiche un message en haut de l'écran.
    return Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      title: title,
      message: message,
      icon: icon,
      duration: Duration(seconds: duration),
    ).show(context);
  }

  Future messageBottomOfScreen(title, message, duration, context, icon) {
    /// Affiche un message en bas de l'écran.
    return Flushbar(
      flushbarPosition: FlushbarPosition.BOTTOM,
      title: title,
      message: message,
      icon: icon,
      duration: Duration(seconds: duration),
    ).show(context);
  }

  Future popUp(title, message, linkPage, context, icon) {
    /// Affiche un popUp.
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            /// Popup
            icon: icon,
            title: Text(title),
            content: Text(message),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => linkPage,
                    ),
                  );
                },
              ),
            ],
          );
        });
  }

  Future popUpWithoutLink(title, message, context, icon) {
    /// Affiche un popUp.
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            /// Popup
            icon: icon,
            title: Text(title),
            content: Text(message),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  Future popUpAction(linkPage, context, action, applet) {
    /// Affiche un popUp avec une action.
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            /// Popup
            title: Text(action.name,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            content: Text(action.description),
            actionsAlignment: MainAxisAlignment.end,
            actions: <Widget>[
              Form(
                key: formKey,
                child: Column(
                  children: [
                    for (var mandatory in action.mandatory)
                      showMandatory(mandatory),
                  ],
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                TextButton(
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Color.fromARGB(255, 243, 85, 106)),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                ClipOval(
                  child: Image.network(
                    'http://10.0.2.2:8080/${action.imageUrl}',
                    width: 70,
                    height: 70,
                    scale: 1.0,
                    fit: BoxFit.cover,
                  ),
                ),
                TextButton(
                  child: const Text(
                    'Add to applet',
                    style: TextStyle(color: Color.fromARGB(255, 243, 85, 106)),
                  ),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      action.responses = _mandatory;
                      applet.subServices = action;
                      Navigator.of(context).pop();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => linkPage,
                          ));
                    }
                  },
                ),
              ])
            ],
          );
        });
  }

  Future popUpReaction(context, reaction, applet) {
    /// Affiche une popUp selon une réaction.
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            /// Popup
            title: Text(reaction.name,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            content: Text(reaction.description),
            actionsAlignment: MainAxisAlignment.center,
            actions: <Widget>[
              Form(
                key: formKey,
                child: Column(
                  children: [
                    for (var mandatory in reaction.mandatory)
                      showMandatory(mandatory),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    child: const Text(
                      'Cancel',
                      style:
                          TextStyle(color: Color.fromARGB(255, 243, 85, 106)),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  ClipOval(
                    child: Image.network(
                      'http://10.0.2.2:8080/${reaction.imageUrl}',
                      width: 70,
                      height: 70,
                      scale: 1.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                  TextButton(
                      child: const Text(
                        'Add to applet',
                        style:
                            TextStyle(color: Color.fromARGB(255, 243, 85, 106)),
                      ),
                      onPressed: () {
                        if (applet.reactions.contains(reaction)) {
                          Navigator.of(context).pop();
                          MessagesMixin().messageTopOfScreen(
                              "Error",
                              "${reaction.name} is already in your applet",
                              3,
                              context,
                              const Icon(Icons.error, color: Colors.red));
                        } else {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            reaction.responses = _mandatory;
                            applet.reactions.add(reaction);
                            Navigator.of(context).pop();
                            messageTopOfScreen(
                                'Success',
                                '${reaction.name} successfully added to applet',
                                3,
                                context,
                                const Icon(Icons.check_circle,
                                    color: Colors.green));
                          }
                        }
                      }),
                ],
              ),
            ],
          );
        });
  }

  Widget showMandatory(name) {
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
        _mandatory.add([name, value!]);
      },
    );
  }

  Future popUpShowApplet(context, applet, usercreds) {
    /// Affiche une popUp avec les informations d'un applet.
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            /// Popup
            title: const Text("Applet's informations",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      descriptionApplet(applet.description),
                    ],
                  ),
                ),
                const Text("Actions :",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                appletActions(context, applet.subServices, applet, usercreds),
                const Text("Reactions :",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                for (var reaction in applet.reactions)
                  appletReactions(context, reaction, applet),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextButton(
                      child: const Text(
                        'Cancel',
                        style:
                            TextStyle(color: Color.fromARGB(255, 243, 85, 106)),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                        child: const Text(
                          'Create Applet',
                          style: TextStyle(
                              color: Color.fromARGB(255, 243, 85, 106)),
                        ),
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            applet.description = _description;
                            var response = await SendApplet.sendAppletServeur(
                                usercreds.token, applet);
                            if (response == 'error') {
                              // ignore: use_build_context_synchronously
                              errorApplet(context);
                            } else {
                              // ignore: use_build_context_synchronously
                              successApplet(context, usercreds);
                            }
                          }
                        })
                  ],
                )
              ],
            ),
          );
        });
  }

  errorApplet(context) {
    Navigator.of(context).pop();
    messageTopOfScreen('Error', 'Error while creating applet', 3, context,
        const Icon(Icons.error, color: Colors.red));
  }

  successApplet(context, usercreds) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoggedInWidget(
            mail: usercreds.email,
            name: usercreds.name,
            token: usercreds.token),
      ),
    );
    messageTopOfScreen(
        'Success',
        "Applet created with success see My applets page",
        3,
        context,
        const Icon(Icons.check_circle, color: Colors.green));
  }

  Widget descriptionApplet(description) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Description',
        hintText: description,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a valid description';
        }
        return null;
      },
      onSaved: (value) {
        _description = value!;
      },
    );
  }

  Widget appletActions(context, action, applet, userCreds) {
    /// Affiche les informations de l'action
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(" - ${action.name}"),
        IconButton(
          icon: const Icon(Icons.info_outline,
              color: Color.fromARGB(255, 243, 85, 106)),
          onPressed: () {
            infosAction(context, action, applet, userCreds);
            // print("info ${action.name}");
          },
        ),
      ],
    );
  }

  Widget appletReactions(context, reaction, applet) {
    /// Affiche les informations d'une réaction.
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(" - ${reaction.name}"),
        IconButton(
          icon: const Icon(Icons.info_outline,
              color: Color.fromARGB(255, 243, 85, 106)),
          onPressed: () {
            infosReaction(context, reaction, applet);
          },
        ),
      ],
    );
  }

  Future infosAction(context, action, applet, userCreds) {
    /// Affiche les informations d'une action.
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            /// Popup
            title: Text(action.name,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            content: Text(action.description),
            actionsAlignment: MainAxisAlignment.center,
            actions: <Widget>[
              for (var responses in action.responses)
                infosMandatory(responses[0], responses[1]),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <
                  Widget>[
                TextButton(
                  child: const Text(
                    'Go Back',
                    style: TextStyle(color: Color.fromARGB(255, 243, 85, 106)),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text(
                    'Remove from Applet',
                    style: TextStyle(color: Color.fromARGB(255, 243, 85, 106)),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChosenServicePage(
                                chosenService: applet.service,
                                userCreds: userCreds)));
                    messageTopOfScreen(
                        'Success',
                        '${action.name} successfully removed from applet',
                        3,
                        context,
                        const Icon(Icons.check_circle, color: Colors.green));
                  },
                )
              ])
            ],
          );
        });
  }

  Future infosReaction(context, reaction, applet) {
    /// Affiche les informations d'une réaction.
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            /// Popup
            title: Text(reaction.name,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            content: Text(reaction.description),
            actionsAlignment: MainAxisAlignment.center,
            actions: <Widget>[
              for (var responses in reaction.responses)
                infosMandatory(responses[0], responses[1]),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <
                  Widget>[
                TextButton(
                  child: const Text(
                    'Go Back',
                    style: TextStyle(color: Color.fromARGB(255, 243, 85, 106)),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text(
                    'Remove from Applet',
                    style: TextStyle(color: Color.fromARGB(255, 243, 85, 106)),
                  ),
                  onPressed: () {
                    applet.reactions.remove(reaction);
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    messageTopOfScreen(
                        'Success',
                        '${reaction.name} successfully removed from applet',
                        3,
                        context,
                        const Icon(Icons.check_circle, color: Colors.green));
                  },
                )
              ]),
            ],
          );
        });
  }

  Widget infosMandatory(name, value) {
    /// Affiche les informations obligatoires d'une action ou d'une réaction.
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      textBaseline: TextBaseline.alphabetic,
      children: <Widget>[
        Text(" - $name : "),
        Text(value),
      ],
    );
  }
}
