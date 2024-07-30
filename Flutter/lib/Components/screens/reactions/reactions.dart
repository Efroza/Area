import 'dart:ui';
import '../home_page/services.dart';

/// Dans ce fichier se trouver la classe [Reactions] qui descend de la classe [Service] et qui permet de stocker les différentes Reactions liés à un service donné.
/// # Paramètres de la classe [Reactions]
/// * [name] = Nom de la réaction.
/// * [imageUrl] = Lien vers une image stockée dans le serveur
/// * [id] = Identifiant de la réaction.
/// * [description] = Description de la réaction.
/// * [inscription] = Booléen qui permet de savoir si l'utilisateur peut utiliser la réaction ou non.
/// * [mandatory] = Liste des actions obligatoires pour utiliser la réaction.
/// * [responses] = Liste des réponses de l'utilisateur aux actions obligatoires.
/// * [idservice] = Identifiant du service auquel la réaction est lié.
class Reactions extends Service {
  int idservice;
  List mandatory;
  List responses;

  Reactions({
    String name = '',
    String imageUrl = '',
    int id = 0,
    String description = '',
    bool inscription = false,
    required this.idservice,
    required this.mandatory,
    required this.responses,
  }) : super(
          id: id,
          name: name,
          imageUrl: imageUrl,
          description: description,
          inscription: inscription,
        );
}
