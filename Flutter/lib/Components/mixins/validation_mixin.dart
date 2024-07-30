/// Dans ce fichier ce trouve la classe [ValidationMixin] qui contient les fonctions de validation des champs de texte.
/// # Résumé de la classe [ValidationMixin]
/// La classe [ValidationMixin] contient les fonctions de validation des champs de texte :
///   * [validateEmail] : permet de vérifier que l'email entré par l'utilisateur est correct.
///   * [validatePassword] : permet de vérifier que le mot de passe entré par l'utilisateur est correct.
///   * [validateName] : permet de vérifier que le nom entré par l'utilisateur est correct.
///   * [validateBirthday] : permet de vérifier que la date de naissance entrée par l'utilisateur est correcte.

class ValidationMixin {
  String? validateEmail(value) { /// Fonction [validateEmail] qui permet de vérifier que l'email entré par l'utilisateur est correct.
    if (!value.contains('@') || !value.contains('.')) { /// Si l'email ne contient pas de '@' ou de '.', alors l'email est incorrect.
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePassword(value) { /// Fonction [validatePassword] qui permet de vérifier que le mot de passe entré par l'utilisateur est correct.
    if (value.length < 4) { /// Si le mot de passe contient moins de 4 caractères, alors le mot de passe est incorrect.
      return 'Password must be at least 4 characters';
    }
    return null;
  }

  String? validateName(value) { /// Fonction [validateName] qui permet de vérifier que le nom entré par l'utilisateur est correct.
    final RegExp nameRegExp = RegExp('[a-zA-Z]');
    String returnValue = '';

    value.isEmpty
        ? returnValue = 'Name is required'
        : (nameRegExp.hasMatch(value)
            ? null
            : returnValue = 'Enter a valid name');
    /// Si le nom est vide ou encore si il contient autre chose que des lettres, alors le nom est incorrect.
    if (returnValue != '') { /// Si le nom est incorrect, alors on retourne le message d'erreur.
      return returnValue;
    }
    return null;
  }

  String? validateBirthday(value) { /// Fonction [validateBirthday] qui permet de vérifier que la date de naissance entrée par l'utilisateur est correcte.
    if (value == null || value.isEmpty) { /// Si la date de naissance est vide, alors la date de naissance est incorrecte.
      return 'Please enter your birthday';
    } 
    DateTime birthDate = DateTime.parse(value);
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;

    if (DateTime.parse(value).isAfter(DateTime.now())) {
      return 'Please enter a valid birthday';
    }
    if (month2 > month1) { /// Si le mois de naissance est supérieur au mois actuel, alors l'âge est incorrect.
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    if (age < 18) { /// Si l'âge est inférieur à 18 ans, alors l'âge est incorrect.
      return 'You must be 18 years old to create an account';
    }
    return null;
  }
}
