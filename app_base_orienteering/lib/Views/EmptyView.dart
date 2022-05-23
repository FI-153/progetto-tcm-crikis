import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyView extends StatelessWidget {
  EmptyView(this.message, {Key? key}) : super(key: key);
  String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/79572-empty-state.json',
                repeat: false, fit: BoxFit.fill),
            const Text(
              'Ops... I cannot find this...',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
            ),
            Text(
              message,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black54),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
