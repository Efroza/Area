import '../services/subservices.dart';
import 'package:flutter/material.dart';
import 'reactions.dart';
import '../../mixins/messages_mixin.dart';
import '../creation_applets/applets.dart';
import '../../user.dart';

/// Dans ce fichier se trouve la class [ReactionPage] qui va permettre d'afficher chaque réactions disponibles pour un service.
/// # Parametres de la classe [ReactionPage]
/// * [subService] : Action choisie.
/// * [reactions] : Liste des réactions disponibles pour un service.
/// * [applet] : Applet en cours de création.
/// * [userCreds] : Informations de l'utilisateur.
/// 
/// # Fonctionnement de la classe [ReactionPage]
/// Cette classe va permettre d'afficher les réactions disponibles pour un service donné.
/// Elle va aussi permettre de continuer la création d'un applet en lui donnant une/des réactions.
/// Ce qui permettra à la fin de valider la création d'un applet.
// ignore: must_be_immutable
class ReactionPage extends StatelessWidget {
  SubService subService;
  List<Reactions> reactions;
  Applet applet;
  UserCred userCreds;

  ReactionPage(
      {super.key,
      required this.subService,
      required this.reactions,
      required this.applet,
      required this.userCreds});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(subService.name),
          centerTitle: true,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: const Color.fromARGB(255, 243, 85, 106),
          onPressed: () {
            if (applet.reactions.isEmpty) {
              MessagesMixin().messageTopOfScreen(
                  "Error",
                  "You need to have at least 1 reaction",
                  3,
                  context,
                  const Icon(Icons.error, color: Colors.red));
            } else {
              MessagesMixin().popUpShowApplet(context, applet, userCreds);
              // Navigator.pop(context, applet);
            }
          },
          label: const Text('See current Applet'),
          icon: const Icon(Icons.check),
        ),
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        body: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                SizedBox(width: 10),
                Text(
                    'Here are all the reactions that you can do with this service',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white)),
              ],
            ),
            const SizedBox(height: 30),
            Expanded(
                child: GridView.count(
              crossAxisCount: 3,
              children: List.generate(reactions.length, (index) {
                return GestureDetector(
                    onTap: () {
                      MessagesMixin()
                          .popUpReaction(context, reactions[index], applet);
                    },
                    child: Column(
                      children: [
                        ClipRRect(
                          child: Image.network(
                            'http://10.0.2.2:8080/${reactions[index].imageUrl}',
                            fit: BoxFit.cover,
                            width: 100,
                            height: 100,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(reactions[index].name,
                            style: const TextStyle(fontSize: 12)),
                      ],
                    ));
              }),
            ))
          ],
        ));
  }
}
