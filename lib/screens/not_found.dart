import 'package:daleelakappx/widgets.dart';
import 'package:flutter/material.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: DColumn(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSpacing: 16,
          children: [
            DRow(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSpacing: 10.0,
              children: [
                Text(
                  'Apologies',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const Icon(
                  Icons.sentiment_dissatisfied,
                  size: 48.0,
                )
              ],
            ),
            Text(
              'We couldn\'t find the screen you\'re looking for\n We tried the following URL: ',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            SelectableText(
              '${ModalRoute.of(context)!.settings.name}',
              style: const TextStyle(
                color: Color(0xffff6f61),
                fontWeight: FontWeight.bold,
              ),
            ),
            DButton.outlined(
              onPressed: () {
                Navigator.of(context).pop();
              },
              foregroundColor: Colors.black,
              child: const Text(
                'Back',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
