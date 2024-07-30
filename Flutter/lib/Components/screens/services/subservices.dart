import 'dart:ui';
import '../home_page/services.dart';

/// Dans ce fichier se trouve la classe [SubService] qui va permettre de stocker les différentes actions disponibles pour un service donné.
/// Elle descend de la class [Service].
/// # Paramètres de la classe [SubService]
/// * [id] : Identifiant de l'action.
/// * [name] : Nom de l'action.
/// * [description] : Description de l'action.
/// * [imageUrl] : Image de l'action.
class SubService extends Service {
  List mandatory;
  List responses;

  SubService({
    String name = '',
    String imageUrl = '',
    int id = 0,
    String description = '',
    bool inscription = false,
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
