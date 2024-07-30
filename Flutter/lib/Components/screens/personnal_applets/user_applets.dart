
/// Dans ce fichier se trouve la class [UserApplets] qui permet de stocker les différents applets de l'utilisateur.
/// # Paramètres de la classe [UserApplets]
/// * [id] : Identifiant de l'applet.
/// * [date] : Date de création de l'applet.
/// * [description] : Description donnée à l'applet lors de sa création.
/// * [activate] : Boolean qui permet de savoir si l'applet est activé ou non.
class UserApplets{
  int id;
  String date;
  String description;
  bool activate;

  UserApplets ({
    required this.id,
    required this.date,
    required this.description,
    required this.activate,
  });
}