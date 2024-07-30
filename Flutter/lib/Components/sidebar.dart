import 'package:app_area/Components/screens/personnal_applets/get_applets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app_area/Components/screens/google_sign_in.dart';
import 'package:app_area/Components/screens/home_page/logged_in.dart';
import 'package:app_area/Components/screens/settings_screen.dart';
import 'package:provider/provider.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:app_area/Components/screens/personnal_applets/action_reaction.dart';

/// # Fonctionnement de la classe SideBar
/// Cette classe permet de définir le menu latéral de l'application, avec dedans :
///   * Elle permet de naviguer entre les différentes pages de l'application => [LoggedInWidget], [ServicesScreen], [SettingsScreen], [ActionReactionScreen]
///   * Elle permet aussi de se déconnecter de l'application.
///   * Elle permet aussi de changer le thème de l'application. (dark mode / light mode)
///   * Elle permet d'avoir accès au profile de l'utilisateur.
///
/// La sidebar est composé de différentes ListTile qui permettent de faire les liens pour chaque page : 
/// ```dart
/// ListTile(
///           leading: const Icon(Icons.mobile_friendly),
///           title: const Text('Services'),
///           onTap: () {
///           Navigator.push(
///                 context,
///                 MaterialPageRoute(
///                   builder: (context) =>
///                       ServicesScreen(name: name, email: email),
///                 ),
///               );
///             },
///           ),
/// ```
class SideBar extends StatelessWidget {
  final String name;
  final String email;
  final String token;

  /// Le constructeur de la classe SideBar à besoin de deux paramètres : [name] et [email] qui sont les informations de l'utilisateur.
  const SideBar({Key? key, required this.name, required this.email, required this.token})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    /// Permet de récupérer les informations de l'utilisateur connecté avec le compte google.
    String? url = "https://cdn-icons-png.flaticon.com/512/1946/1946429.png";

    /// Permet de définir l'url de l'image de profil de l'utilisateur.
    if (user != null) {
      /// Si l'utilisateur est connecté avec son compte google, on récupére l'url de son image de profil.
      url = user.photoURL;
    }
    Color colorBack = Colors.white;
    Color colorDivider = Colors.black;
    Icon nightMode = const Icon(Icons.nightlight_round);
    if (AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark) {
      /// Permet de changer les couleurs de l'application selon le theme actuel.
      colorBack = Colors.black;
      colorDivider = Colors.white;
      nightMode = const Icon(Icons.wb_sunny);
    }
    return Container(
      width: 250,
      color: colorBack,
      child: Column(
        children: [
          UserAccountsDrawerHeader( /// Permet d'afficher le nom et l'email de l'utilisateur ainsi que son image de profil.
            accountName: Text(name), /// Permet d'afficher le nom de l'utilisateur.
            accountEmail: Text(email), /// Permet d'afficher l'email de l'utilisateur.
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              child: ClipOval(
                child: Image.network(
                  url!,
                  fit: BoxFit.cover,
                  width: 90,
                  height: 90,
                ),
              ),
            ),
            decoration: const BoxDecoration( /// Permet de définir la couleur de fond de l'en-tête.
              image: DecorationImage(
                image: NetworkImage(
                    "https://addons-media.operacdn.com/media/CACHE/images/themes/05/144705/1.0-rev1/images/0993404e-79e0-4052-923d-89236e7c102f/e4f4077f6d1f715a07786ff7692a8d1d.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            otherAccountsPictures: [
              IconButton(
                color: Colors.white,
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoggedInWidget(mail: email, name: name, token: token), /// Permet de naviguer vers la page home de l'utilisateur.
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.api),
            title: const Text('My Applets'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ActionReactionScreen(name: name, email: email, token: token, userapplets: GetApplet.getListOfAppletsFromBack(token),
                      ), /// Permet de naviguer vers la page action/reaction de l'utilisateur.
                ),
              );
            },
          ),
          Divider(color: colorDivider, height: 40, thickness: 1),
          SwitchListTile(
            title: const Text('Dark Mode'),
            value: AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark,
            onChanged: (bool value) {
              AdaptiveTheme.of(context).toggleThemeMode();
            }, /// Permet de changer le thème de l'application. (dark mode / light mode)
            secondary: Icon(nightMode.icon),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      SettingsScreen(name: name, email: email, token: token), /// Permet de naviguer vers la page de paramètres.
                ),
              );
            },
          ),
          Divider(color: colorDivider, height: 20, thickness: 1),
          Expanded( /// Permet de mettre le bouton de déconnexion en bas de la sidebar.
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () async {
                  final provider =
                      Provider.of<GoogleSignInProvider>(context, listen: false);
                  await provider.logout(); /// Permet de se déconnecter de l'application si le compte est connecté avec google.
                  Navigator.pushNamed(context, '/login'); /// Permet de se déconnecter de l'application si le compte est connecté avec un email et un mot de passe.
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
