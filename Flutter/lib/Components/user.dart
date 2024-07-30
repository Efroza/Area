/// La classe [UserCred] permet de stocker les informations de l'utilisateur connecté.
/// # Informations :
/// * [name] : Identifiant de l'utilisateur.
/// * [email] : Email de l'utilisateur.
/// * [token] : Token de l'utilisateur.
class UserCred {
  String email;
  String name;
  String token;

  UserCred({
    required this.email,
    required this.name,
    required this.token,
  });
}
