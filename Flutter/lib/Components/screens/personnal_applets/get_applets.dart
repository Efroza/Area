import 'dart:convert';

import './user_applets.dart';
import 'package:http/http.dart' as http;

/// Dans ce fichier se trouve la classe [GetApplet] qui permet de récupérer les applets de l'utilisateur auprès du serveur.
/// # Résumé du rôle de la classe [GetApplet]
/// Cette classe permet de récupérer les applets de l'utilisateur auprès du serveur. Elle permet de récupérer les applets de l'utilisateur et de les stocker dans une liste.
/// 
/// # Paramètres de la classe [GetApplet]
/// * [token] : Token de l'utilisateur.
/// * [url] : Url du serveur => http://10.0.2.2:8080/applet/applet
class GetApplet {
  static Future<List> getApplets(token) async {
    var response = await http
        .get(Uri.parse("http://10.0.2.2:8080/applet/applet"), headers: {
      'Authorization': token,
    });
    var data = jsonDecode(response.body);
    return data;
  }

  static Future<List<UserApplets>> getListOfAppletsFromBack(token) async {
    var userapplets = <UserApplets>[];
    var data = await getApplets(token);

    for (var element in data) {
      userapplets = [
        ...userapplets,
        UserApplets(
          id: element['id'],
          date: element['date'],
          activate: element['activate'],
          description: element['description'],
        )
      ];
    }
    return userapplets;
  }
}
