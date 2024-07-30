import 'package:flutter/material.dart';
import '../../sidebar.dart';
import './user_applets.dart';
import './get_applets.dart';
import './popUp_applet.dart';

/// La classe [ActionReaction] est la classe qui permet d'afficher les actions et réactions de l'application.
/// # Résumé du rôle de la classe [ActionReaction]
/// Cette classe permet d'afficher les actions et réactions de l'application.
/// Afin de le faire les actions et réactions sont stockées dans le serveur.
/// Les actions sont stockées dans le widget : [currentAction]
class ActionReactionScreen extends StatelessWidget {
  final String name;
  final String email;
  final String token;
  final Future<List<UserApplets>> userapplets;

  const ActionReactionScreen(
      {Key? key,
      required this.name,
      required this.email,
      required this.token,
      required this.userapplets})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Future<List<UserApplets>> userapplets =
    //     GetApplet.getListOfAppletsFromBack(token);
    return Scaffold(
      drawer: SideBar(name: name, email: email, token: token),
      appBar: AppBar(
        title: const Text('My applets'),
        centerTitle: true,
        flexibleSpace: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
          image: NetworkImage(
              "https://mooka.ie/img/sliderimages/slider-services-background.jpg"),
          fit: BoxFit.cover,
        ))),
      ),
      body: Container(
        color: Colors.blueGrey.shade900,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Text(
                    'These are all the applets that you have on your account',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white))),
            Expanded(
              child: FutureBuilder<List<UserApplets>>(
                future: userapplets,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            PopUpApplet().popUpUserApplet(snapshot.data![index],
                                context, name, email, token, userapplets);
                          },
                          child: Card(
                            color: snapshot.data![index].activate
                                ? Colors.green
                                : Colors.red,
                            child: Column(
                              children: [
                                Text(
                                  snapshot.data![index].activate
                                      ? "activated"
                                      : "deactivated",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                const SizedBox(height: 50),
                                Text(
                                  snapshot.data![index].description,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                const SizedBox(height: 50),
                                Text(
                                  "This applet was made on ${snapshot.data![index].date}",
                                  style: const TextStyle(color: Colors.white),
                                ),
                                const SizedBox(height: 50),
                              ],
                            ),
                          ),
                        );
                      },
                      // itemBuilder: (context, index) {
                      //   return ServicesCard(
                      //     service: snapshot.data![index],
                      //     onCardClick: () {
                      //       Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //           builder: (context) => ChosenServicePage(
                      //             chosenService: snapshot.data![index],
                      //           ),
                      //         ),
                      //       );
                      //     },
                      //   );
                      // },
                    );
                  } else if (snapshot.hasError) {
                    print("We have an error");
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
