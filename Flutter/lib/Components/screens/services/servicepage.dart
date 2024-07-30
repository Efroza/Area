import 'package:flutter/material.dart';
import '../home_page/services.dart';
import '../reactions/reactionpage.dart';
import '../../mixins/messages_mixin.dart';
import '../creation_applets/applets.dart';
import '../../user.dart';

/// Dans ce fichier se trouve la class [ChosenServicePage] qui va permettre d'afficher les actions disponibles pour un service donné.
/// # Parametres de la classe [ChosenServicePage]
/// * [chosenService] : Service choisi.
/// * [userCreds] : Informations de l'utilisateur.
/// 
/// # Fonctionnement de la classe [ChosenServicePage]
/// Cette classe va permettre d'afficher les actions disponibles pour un service donné.
/// Elle va aussi permettre de commencer la création d'un applet en lui donnant une action.
class ChosenServicePage extends StatelessWidget {
  Service chosenService;
  UserCred userCreds;

  ChosenServicePage({super.key, required this.chosenService, required this.userCreds});

  @override
  Widget build(BuildContext context) {
    Applet applet = Applet(
        description: '',
        service: chosenService,
        subServices: chosenService.subServices[0],
        reactions: []);
    return Scaffold(
        appBar: AppBar(
          title: Text('${chosenService.name} actions page'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                SizedBox(width: 10),
                Text(
                    'Here are all the actions that you can do with this service',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white)),
              ],
            ),
            const SizedBox(height: 30),
            Expanded(
                child: GridView.count(
              crossAxisCount: 3,
              children:
                  List.generate(chosenService.subServices.length, (index) {
                return GestureDetector(
                    // applet.subServices.add(chosenService.subServices[index]);
                    onTap: () {
                      MessagesMixin().popUpAction(
                        ReactionPage(
                            subService: chosenService.subServices[index],
                            reactions: chosenService.reactions,
                            applet: applet,
                            userCreds: userCreds),
                        context,
                        chosenService.subServices[index],
                        applet,
                      );
                    },
                    child: Column(
                      children: [
                        ClipOval(
                          child: Image.network(
                            'http://10.0.2.2:8080/${chosenService.imageUrl}',
                            fit: BoxFit.cover,
                            width: 100,
                            height: 100,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          chosenService.subServices[index].name,
                        ),
                      ],
                    ));
              }),
            ))
          ],
        ));
  }
}
