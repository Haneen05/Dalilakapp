import 'dart:ui';

import 'package:daleelakappx/theme.dart';
import 'package:flutter/material.dart';

class AboutUsWidget extends StatelessWidget {
  static const titleStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: DBox.fontLg,
  );

  static TextSpan aboutUsText = TextSpan(
    children: [
      TextSpan(
        text: 'About Us',
        style: titleStyle,
      ),
      TextSpan(text: '\n\n'),
      TextSpan(
          text:
              'Dalilak is a trusted local connection platform that facilitates efficient interactions between consumers and nearby businesses. Offering accurate and verified business information, Dalilak stands out from traditional search engines by ensuring up-to-date details and a user-friendly experience.')
    ],
  );

  static TextSpan missionText = TextSpan(
    children: [
      TextSpan(
        text: 'Mission',
        style: titleStyle,
      ),
      TextSpan(text: '\n\n'),
      TextSpan(
          text:
              'Connecting consumers with local businesses and services efficiently, by providing a user-friendly experience and empowering both consumers and businesses.'),
    ],
  );

  static TextSpan visionText = TextSpan(
    children: [
      TextSpan(
        text: 'Vision',
        style: titleStyle,
      ),
      TextSpan(text: '\n\n'),
      TextSpan(
          text:
              'We bridge the gap between consumers and local businesses by providing:\n'),
      TextSpan(
        children: [
          TextSpan(
            children: [
              TextSpan(
                text: '• Trusted and verified information: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                  text:
                      'Dalilak ensures  accurate and up-to-date business details, unlike user-generated content on search engines.'),
              TextSpan(text: '\n'),
            ],
          ),
          TextSpan(
            children: [
              TextSpan(
                text: '• Convenience and ease of use: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                  text:
                      'Our categorized directory and user-friendly interface make finding what you need effortless.'),
              TextSpan(text: '\n'),
            ],
          ),
          TextSpan(
            children: [
              TextSpan(
                text: '• Increased visibility and credibility: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                  text:
                      'A Dalilak listing positions your business as a trusted and established entity among local consumers.'),
              TextSpan(text: '\n'),
            ],
          ),
        ],
      )
    ],
  );
  static TextSpan valueText = TextSpan(
    children: [
      TextSpan(
        text: 'Value',
        style: titleStyle,
      ),
      TextSpan(text: '\n\n'),
      TextSpan(
          text:
              'The Trusted Bridge in a Digital Age\nWhile online search engines offer a vast amount of information, Dalilak goes beyond just listings. We bridge the gap between consumers and local businesses. We envision a future where:\n'),
      TextSpan(
        children: [
          TextSpan(
            children: [
              TextSpan(
                text: '• ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                  text:
                      'Effortless Search: Our intuitive app empowers users to find exactly what they need with a clean interface, clear categories, and powerful search functions.'),
              TextSpan(text: '\n'),
            ],
          ),
          TextSpan(
            children: [
              TextSpan(
                text: '• ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                  text:
                      'Informed Decisions: User reviews, ratings, and photos will illuminate the best businesses, allowing users to choose with confidence.'),
              TextSpan(text: '\n'),
            ],
          ),
          TextSpan(
            children: [
              TextSpan(
                text: '• ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                  text:
                      'Hyper-local Focus: Location-based services and personalized recommendations ensure users discover relevant businesses nearby.'),
              TextSpan(text: '\n'),
            ],
          ),
          TextSpan(
            children: [
              TextSpan(
                text: '• ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                  text:
                      'Engaged Community: Push notifications keep users informed of deals, promotions, and new listings, fostering a vibrant user base.'),
              TextSpan(text: '\n'),
            ],
          ),
        ],
      )
    ],
  );

  const AboutUsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: SizedBox.expand(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            padding: const EdgeInsets.fromLTRB(20.0, 62.0, 20.0, 30.0),
            color: Colors.white.withOpacity(0.5),
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 135,
                      child: Image.asset(
                        'assets/icon.jpg',
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.close_rounded,
                        color: Color(0xff292929),
                        size: 18.0,
                      ),
                      style: IconButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size.square(26.0),
                        shape: const CircleBorder(
                          side: BorderSide(
                            width: 2.0,
                            color: Color(0xff292929),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          aboutUsText,
                          TextSpan(text: '\n\n'),
                          AboutUsWidget.missionText,
                          TextSpan(text: '\n\n'),
                          visionText,
                          TextSpan(text: '\n\n'),
                          valueText,
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
