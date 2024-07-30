import 'package:flutter/material.dart';
import 'services.dart';

/// Dans ce fichier se trouve la class [ServicesCard] qui permet de créer une card pour chaque service.
/// Elle descend de la class [StatelessWidget].
/// # Paramètres de la class [ServicesCard]
/// * [service] : Service qui sera affiché dans la card.
/// * [onCardClick] : Fonction qui sera appelée lorsque l'utilisateur appuiera sur la card.
class ServicesCard extends StatelessWidget {
  Service service;
  Function onCardClick;

  ServicesCard({Key? key, required this.service, required this.onCardClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onCardClick();
      },
      child: Container(
          margin: EdgeInsets.all(20),
          height: 180,
          child: Stack(
            children: [
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                      'http://10.0.2.2:8080/${service.imageUrl}',
                      fit: BoxFit.cover),
                ),
              ),
              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(.6),
                          Colors.black.withOpacity(.1),
                        ],
                      ),
                    ),
                  )),
            ],
          )),
    );
  }
}
