import 'dart:convert';
import 'package:http/http.dart' as http;

/// Dans ce fichier se trouve [SendApplet] qui permet d'envoyer les applets une fois validé au serveur via l'url : http://10.0.2.2:8080/applet/applet/
class SendApplet {
  static Future<String> sendAppletServeur(token, applet) async {
    var url = Uri.parse('http://10.0.2.2:8080/applet/applet/');
    var body_action = {
      'id': applet.subServices.id,
    };
    for (int i = 0; applet.subServices.mandatory.length > i; i++) {
      body_action[applet.subServices.mandatory[i]] =
          applet.subServices.responses[i][1];
    }
    var body_reaction = [];
    for (int j = 0; applet.reactions.length > j; j++) {
      for (int i = 0; applet.reactions[j].mandatory.length > i; i++) {
        body_reaction.add({
          'id': applet.reactions[j].id,
          applet.reactions[j].mandatory[i]: applet.reactions[j].responses[i][1]
        });
      }
    }
    var body = [body_action, body_reaction];
    var response = await http.post(url,
        headers: {
          'Authorization': token,
        },
        body: jsonEncode({
          'action': body_action,
          'reaction': body_reaction,
        }));
    if (response.statusCode != 200) {
      print("Applet : ${response.statusCode}");
      var data = jsonDecode(response.body);
      print(data);
      return "error";
    }
    var data = jsonDecode(response.body);
    print("Applet : ${data}");
    return 'success';
  }
}
