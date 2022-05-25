// ignore_for_file: file_names

import 'package:Orienteering/Utilities/custumTheming.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyFavoriteView extends StatelessWidget {
  const EmptyFavoriteView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/69369-cute-crying-lottie-animation.json',
                repeat: false,
                width: MediaQuery.of(context).size.width * 0.60,
                fit: BoxFit.fill),
            const Text(
              'There are no favorite races...',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
            ),
            const Text(
              'Why not adding some?',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: orienteeringRed),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
