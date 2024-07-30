import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:app_area/Components/mixins/messages_mixin.dart';
import 'package:app_area/Components/screens/home_page/utils.dart';

/// Dans ce fichier se trouve la class [Oauth] qui va permettre de gérer l'authentification par OAuth.
/// # Parametres de la classe [Oauth]
/// * [url] : Url de l'authentification.
/// * [redirect] : Url de redirection.
/// * [name] : Nom du service.
/// * [token] : token de l'utilisateur.
class Oauth extends StatelessWidget {
  const Oauth(this.url, this.redirect, this.name, this.token, this.save, {Key? key})
      : super(key: key);

  final String url;
  final String redirect;
  final String name;
  final String token;
  final String save;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
        navigationDelegate: (_) => NavigationDecision.navigate,
        onPageFinished: (String urlEnd) async {
          if (urlEnd.startsWith(redirect)) {
            Uri.dataFromString(urlEnd).queryParameters['code'].toString();
            print(
                Uri.dataFromString(urlEnd).queryParameters['code'].toString());
            Navigator.pop(context);
            Navigator.pop(context);
            var response = await UtilsPost().postOauthService(token, save,
                Uri.dataFromString(urlEnd).queryParameters['code'].toString(),
                Uri.dataFromString(urlEnd).queryParameters['state'].toString());
            // ignore: use_build_context_synchronously
            checkResponse(response, name, context);
          }
        },
      ),
    );
  }

  checkResponse(response, name, context) {
    if (response[0] == "error") {
      MessagesMixin().popUpWithoutLink(
          'Error',
          'Error while connecting to $name, please try again',
          context,
          const Icon(Icons.error, color: Colors.red, size: 50));
    } else {
      MessagesMixin().popUpWithoutLink(
          'Success',
          'Successfully connected to $name, you can now use the service',
          context,
          const Icon(Icons.check_circle_outline,
              color: Colors.green, size: 50));
    }
  }
}
