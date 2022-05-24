// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/lf30_editor_1ofhptov.json',
                repeat: true,
                width: MediaQuery.of(context).size.width * 0.40,
                fit: BoxFit.fill),
          ],
        ),
      ),
    );
  }
}
