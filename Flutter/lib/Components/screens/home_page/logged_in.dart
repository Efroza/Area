import 'package:app_area/Components/screens/reactions/reactionpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../creation_applets/applets.dart';
import '../google_sign_in.dart';
import 'package:provider/provider.dart';
import '../../sidebar.dart';
import 'services.dart';
import 'utils.dart';
import 'servicescard.dart';
import '../services/servicepage.dart';
import '../services/subservices.dart';
import './connexion_service.dart';
import '../../user.dart';
/// Dans ce fichier ce trouve la classe [LoggedInWidget] qui est la page d'accueil de l'application une fois connecté.
/// # Résumé du rôle de la classe [LoggedInWidget]
/// Cette classe permet d'afficher la page d'accueil de l'application une fois connecté.

class LoggedInWidget extends StatelessWidget {
  final String mail;
  final String name;
  final String token;

  /// Le constructeur de la classe [LoggedInWidget] permet de récupérer le nom et l'email de l'utilisateur connecté.
  const LoggedInWidget(
      {Key? key, required this.mail, required this.name, required this.token})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserCred user = UserCred(email: mail, name: name, token: token);
    Future<List<Service>> services = Utils.getMockedCategories(token);
    return Scaffold(
      drawer: SideBar(name: name, email: mail, token: token),

      /// Affichage du menu latéral de l'application.
      appBar: AppBar(
        title: Text('Welcome to your Area !'),
        centerTitle: true,
        flexibleSpace: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
          image: NetworkImage(
              "https://i.pinimg.com/736x/f2/9c/e3/f29ce3155c540b090e91fe4156557177.jpg"),

          /// Image de fond de l'appBar de la page
          fit: BoxFit.cover,
        ))),
      ),
      body: Container(
        // alignment: Alignment.center,
        color: Colors.blueGrey.shade900,
        // alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Text('These are all the services that you can use',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white))),
            Expanded(
              child: FutureBuilder<List<Service>>(
                future: services,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return ServicesCard(
                          service: snapshot.data![index],
                          onCardClick: () {
                            if (snapshot.data![index].inscription == true &&
                                snapshot.data![index].isActivate == false) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ConnectService(
                                          service: snapshot.data![index],
                                          token: token,
                                          imageUrl:
                                              snapshot.data![index].imageUrl,
                                          name: name,
                                          email: mail)));
                            } else {
                              if (snapshot
                                  .data![index].subServices.isNotEmpty) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChosenServicePage(
                                      chosenService: snapshot.data![index],
                                      userCreds: user,
                                    ),
                                  ),
                                );
                              } else {
                                SubService subService = SubService(
                                    name: snapshot.data![index].name,
                                    id: snapshot.data![index].id,
                                    mandatory: [],
                                    responses: []);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ReactionPage(
                                              subService: subService,
                                              reactions: snapshot
                                                  .data![index].reactions,
                                              applet: Applet(
                                                description: '',
                                                service: snapshot.data![index],
                                                subServices: subService,
                                                reactions: [],
                                              ), userCreds: user,
                                            )));
                              }
                            }
                          },
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return const CircularProgressIndicator();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
