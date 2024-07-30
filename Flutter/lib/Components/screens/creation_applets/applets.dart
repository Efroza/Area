import '../services/subservices.dart';
import '../reactions/reactions.dart';
import '../home_page/services.dart';

/// Dans ce fichier se trouve [Applet] qui permet de stocker les applets.
/// # Paramètres de la classe [Applet]
/// * [description] : Description de l'applet.
/// * [service] : Service de l'applet.
/// * [subServices] : Action de l'applet.
/// * [reactions] : Réaction de l'applet.
class Applet {
  String description;
  Service service;
  SubService subServices;
  List<Reactions> reactions;

  Applet({
    required this.description,
    required this.service,
    required this.subServices,
    required this.reactions,
  });
}
