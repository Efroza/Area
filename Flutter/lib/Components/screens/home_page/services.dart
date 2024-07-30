import 'dart:ui';

import '../services/subservices.dart';
import '../reactions/reactions.dart';

/// Dans ce fichier se trouve la classe [Service] qui permet de stocker chaque service disponible sur l'application.
/// # Paramètres de la classe [Service]
/// * [id] : Identifiant du service.
/// * [name] : Nom du service.
/// * [imageUrl] : Image du service.
/// * [description] : Description du service.
/// * [inscription] : Booléen qui permet de savoir si l'utilisateur est inscrit au service ou non.
/// * [subServices] : Liste des actions disponibles pour le service.
/// * [reactions] : Liste des reactions disponibles pour le service.
/// * [infos] : Liste des infos du service.
/// * [isActivate] : Booléen qui permet de savoir si le service est activé ou non.
class Service {
  int id;
  String name;
  String description;
  bool inscription;
  String imageUrl;
  List<SubService> subServices;
  List<Reactions> reactions;
  List infos;
  bool isActivate;

  Service({
    required this.id,
    required this.name,
    required this.description,
    required this.inscription,
    required this.imageUrl,
    this.isActivate = false,
    this.infos = const [],
    this.subServices = const [],
    this.reactions = const [],
  });
}
