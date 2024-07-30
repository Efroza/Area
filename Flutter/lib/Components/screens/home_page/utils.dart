import 'dart:convert';

import 'services.dart';
import 'package:http/http.dart' as http;

import '../services/subservices.dart';
import '../reactions/reactions.dart';

/// Dans ce fichier se trouve la classe [Utils] qui retourn la liste des services actuellement disponible.
/// # Résumé du rôle de la classe [Utils]
/// Cette classe permet de retourner la liste des services actuellement disponible. Cette liste est utilisé pour afficher les services disponibles dans la page d'accueil de l'application une fois connecté.
/// Elle est composé de plusieurs fonctions :
///  * [getMandatoryReactions] : Cette fonction permet de retourner la liste des obligations pour chaque réactions.
///  * [getMandatoryActions] : Cette fonction permet de retourner la liste des obligations pour chaque actions.
///  * [getReactions] : Cette fonction permet de retourner la liste des réactions.
///  * [getActions] : Cette fonction permet de retourner la liste des actions.
///  * [getInfoService] : Cette fonction permet de retourner la liste des infos pour chaque service.
/// 
class Utils {
  static Future<List> getMandatoryReactions(id) async {
    var url = Uri.parse('http://10.0.2.2:8080/applet/reaction/mandatory/$id');
    var response = await http.get(url);
    List mandatory = [];

    if (response.statusCode != 200) {
      return mandatory;
    }
    var data = jsonDecode(response.body);
    for (var i = 0; i < data.length; i++) {
      mandatory.add(data[i]['name']);
    }
    return mandatory;
  }

  static Future<List> getMandatoryActions(id) async {
    var url = Uri.parse('http://10.0.2.2:8080/applet/action/mandatory/$id');
    var response = await http.get(url);
    List mandatory = [];

    if (response.statusCode != 200) {
      return mandatory;
    }
    var data = jsonDecode(response.body);
    for (var i = 0; i < data.length; i++) {
      mandatory.add(data[i]['name']);
    }
    return mandatory;
  }

  static Future<List<Reactions>> getReactions(token, imageUrl) async {
    var url = Uri.parse('http://10.0.2.2:8080/applet/reaction');
    var response = await http.get(url, headers: {
      'Authorization': '$token',
    });
    var reactions = <Reactions>[];
    if (response.statusCode != 200) {
      print("Reactions : ${response.statusCode}");
      return reactions;
    }
    var data = jsonDecode(response.body);
    for (var reaction in data) {
      reactions.add(Reactions(
        id: reaction['id'],
        name: reaction['name'],
        description: reaction['description'],
        idservice: reaction['id_service'],
        imageUrl: imageUrl,
        inscription: false,
        mandatory: await getMandatoryReactions(reaction['id']),
        responses: [],
      ));
    }
    return reactions;
  }

  static Future<List<SubService>> getActions(token, id, imageUrl) async {
    var url = Uri.parse('http://10.0.2.2:8080/applet/action/service/$id');
    var response = await http.get(url, headers: {
      'Authorization': token,
    });
    var subservices = <SubService>[];
    if (response.statusCode != 200) {
      print("Actions : ${response.statusCode}");
      return subservices;
    }
    var data = jsonDecode((response).body);
    for (var subservice in data) {
      subservices.add(
        SubService(
          id: subservice['id'],
          name: subservice['name'],
          description: subservice['description'],
          imageUrl: imageUrl,
          inscription: false,
          mandatory: await getMandatoryActions(subservice['id']),
          responses: [],
        ),
      );
    }
    return subservices;
  }

  static Future<List<dynamic>> getInfoService(name) async {
    var url = Uri.parse('http://10.0.2.2:8080/service/useInfo/$name');
    List info = [];
    var response = await http.get(url);
    if (response.statusCode != 200) {
      print("Info : ${response.statusCode}");
      return info;
    }
    var data = jsonDecode(response.body);
    info.add("${data['email']}");
    info.add("${data['password']}");
    info.add("${data['token']}");
    info.add("${data['extra']}");
    return info;
  }

  static Future<bool> getActivateService(token, name) async {
    var url =
        Uri.parse('http://10.0.2.2:8080/service/account/issubscribe/$name');
    var response = await http.get(url, headers: {
      'Authorization': token,
    });
    bool activate = false;
    if (response.statusCode != 200) {
      print("Activate : ${response.statusCode}");
      return false;
    }
    var data = jsonDecode(response.body);
    activate = data['subscribe'];
    return activate;
  }

  static Future<List> getServicesFromBack() async {
    var response = await http.get(Uri.parse("http://10.0.2.2:8080/service/"));
    var data = jsonDecode(response.body);
    return data;
  }

  static Future<List<Service>> getMockedCategories(token) async {
    var services = <Service>[];
    var data = await getServicesFromBack();

    for (var element in data) {
      services = [
        ...services,
        Service(
          id: element['id'],
          name: element['name'],
          inscription: element['inscription'],
          description: element['description'],
          imageUrl: element['image'],
          subServices: await getActions(token, element['id'], element['image']),
          reactions: await getReactions(token, element['image']),
          infos: await getInfoService(element['name']),
          isActivate: await getActivateService(token, element['name']),
        )
      ];
    }
    for (var service in services) {
      for (var reactions in service.reactions) {
        if (reactions.idservice != service.id) {
          for (var otherservices in services) {
            if (otherservices.id == reactions.idservice) {
              reactions.imageUrl = otherservices.imageUrl;
            }
          }
        }
      }
    }
    return services;
  }

  Future<List<String>> getOauthUrl(name) async {
    var url = Uri.parse('http://10.0.2.2:8080/service/oauth2/eligible/$name');
    var response = await http.get(url);
    var data = jsonDecode(response.body);

    if (response.statusCode != 200) {
      print("Oauth : ${response.statusCode}");
      return ["error", "error"];
    }
    print("here $data");
    if (data["success"] == true) {
      return [data["url"], data["redirect"], data["save"]];
    } else {
      return ["error", "error"];
    }
  }
}

class UtilsPost {
  Future<List> postConnexionService(nameService, listInfo, tokenUser) async {
    var url = Uri.parse('http://10.0.2.2:8080/service/account/$nameService');
    var response = await http.post(url,
        headers: {
          'Authorization': tokenUser,
        },
        body: jsonEncode({
          "email": listInfo[0],
          "password": listInfo[1],
          "token": listInfo[2],
          "extra": listInfo[3],
        }));
    if (response.statusCode != 200) {
      print("Connexion : ${response.statusCode}");
      return ["error", "Error connection, try again"];
    }
    var data = jsonDecode(response.body);
    if (data['success'] == false) {
      return ["error", data['message']];
    }
    return ["success", data['message']];
  }

  Future<List> postOauthService(tokenUser, url, code, state) async {
    var newUrl = Uri.parse(url.replaceAll('127.0.0.1', '10.0.2.2'));
    var response = await http.post(
      newUrl,
      headers: {
        'Authorization': tokenUser,
      },
      body: jsonEncode({
        "code": code,
        "state": state,
      }
      )
    );
    if (response.statusCode != 200) {
      print("Oauth : ${response.statusCode}");
      return ["error", "Error connection, try again"];
    }
    var data = jsonDecode(response.body);
    if (data['success'] == "Success connect to databases") {
      return ["success", "Successfully connected to the service"];
    }
    return ["error", "Not connected to the service"];
  }
}
