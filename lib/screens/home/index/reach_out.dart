import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daleelakappx/models/message.dart';
import 'package:daleelakappx/screens/home/index/about_us.dart';
import 'package:daleelakappx/theme.dart';
import 'package:daleelakappx/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:daleelakappx/api.dart' as api;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class ReachOutWidget extends StatefulWidget {
  const ReachOutWidget({super.key});

  @override
  State<ReachOutWidget> createState() => _ReachOutWidgetState();
}

class _ReachOutWidgetState extends State<ReachOutWidget> {
  bool editing = true;
  bool loading = false;

  final name = TextEditingController();
  final email = TextEditingController();
  final message = TextEditingController();

  String? nameError;
  String? emailError;
  String? messageError;

  @override
  Widget build(BuildContext context) {
    final l18n = AppLocalizations.of(context)!;
    var themeData = Theme.of(context);
    return Theme(
      data: themeData.copyWith(
        textTheme: themeData.textTheme.apply(
          bodyColor: Colors.white,
        ),
        inputDecorationTheme: themeData.inputDecorationTheme.copyWith(
          hintStyle: TextStyle(
            color: Colors.white.withOpacity(0.5),
          ),
        ),
      ),
      child: Card(
        color: Colors.black,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(25.0),
          ),
        ),
        child: Stack(
          children: [
            if (editing)
              Padding(
                padding: const EdgeInsets.all(DBox.xlSpace),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 20.0),
                      child: Text(
                        l18n.reachOut,
                        style: const TextStyle(
                          fontSize: 32.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const DBox.verticalSpaceXl(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('+961 76 166 056'),
                        DBox.verticalSpaceMd(),
                        Text('info@dalilak-lb.com'),
                        DBox.verticalSpaceMd(),
                        InkWell(
                          onTap: () async {
                            Uri nativeUrl = Uri.parse(
                                "https://www.instagram.com/dalilak.lb.app?igsh=N3lwd2djMG14MGJq");
                            if (await canLaunchUrl(nativeUrl)) {
                              await launchUrl(nativeUrl);
                            } else if (await canLaunchUrl(nativeUrl)) {
                              await launchUrl(nativeUrl);
                            } else {
                              print("can't open Instagram");
                            }
                          },
                          child: Row(
                            children: [
                              FaIcon(
                                FontAwesomeIcons.instagram,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text('dalilak'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const DBox.verticalSpaceXl(),
                    DColumn(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSpacing: DBox.xlSpace,
                      children: [
                        Text(
                          l18n.dropLine,
                          style: const TextStyle(
                            fontSize: DBox.fontXl,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextField(
                          controller: name,
                          decoration: InputDecoration(
                            labelText: l18n.name,
                            errorText: nameError,
                          ),
                          onChanged: (_) {
                            setState(() => nameError = null);
                          },
                        ),
                        TextField(
                          controller: email,
                          decoration: InputDecoration(
                            labelText: l18n.email,
                            errorText: emailError,
                          ),
                          onChanged: (_) {
                            setState(() => emailError = null);
                          },
                        ),
                        TextField(
                          controller: message,
                          decoration: InputDecoration(
                            labelText: l18n.message,
                            errorText: messageError,
                          ),
                          onChanged: (_) {
                            setState(() => messageError = null);
                          },
                          maxLines: 5,
                        ),
                        if (loading)
                          const CircularProgressIndicator()
                        else
                          FilledButton(
                            onPressed: () async {
                              if (!validate()) {
                                return;
                              }

                              setState(() => loading = true);
                              try {
                                await api.messages.add(MessageInput(
                                  name: name.text.trim(),
                                  email: email.text.trim(),
                                  message: message.text.trim(),
                                  createdAt: DateTime.now(),
                                ));
                                // await sendEmail(message.text.trim());

                                // reset fields
                                name.text = '';
                                email.text = '';
                                message.text = '';

                                setState(() => editing = false);
                              } finally {
                                setState(() => loading = false);
                              }
                            },
                            child: Text(l18n.send),
                          ),
                      ],
                    )
                  ],
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 4 * DBox.xlSpace,
                  horizontal: 1.5 * DBox.xlSpace,
                ),
                child: DColumn(
                  mainAxisSpacing: 2 * DBox.xlSpace,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      CupertinoIcons.checkmark_circle,
                      color: Colors.white,
                      size: 64.0,
                    ),
                    Text(
                      'Your Message has been Submitted successfully',
                      style: themeData.textTheme.displayMedium!.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    DButton.filled(
                      onPressed: () {
                        setState(() => editing = true);
                      },
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      child: const Text(
                        'Done',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            Align(
              alignment: AlignmentDirectional.topEnd,
              child: Padding(
                padding: const EdgeInsets.all(DBox.smSpace),
                child: IconButton(
                  onPressed: () {
                    showGeneralDialog(
                      context: context,
                      barrierColor: const Color(0xfffefbec).withOpacity(0.5),
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return const AboutUsWidget();
                      },
                    );
                  },
                  icon: const Icon(Icons.info_outline),
                  color: Colors.black,
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: const CircleBorder(),
                    minimumSize: const Size.square(12),
                    padding: EdgeInsets.zero,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  bool validate() {
    bool isValid = true;
    if (name.text.trim().isEmpty) {
      setState(() => nameError = 'Required');
      isValid = false;
    }

    if (email.text.trim().isEmpty) {
      emailError = 'Required';
      isValid = false;
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
        .hasMatch(email.text.trim())) {
      setState(() => emailError = 'Must be a valid email address');
      isValid = false;
    }
    if (message.text.trim().isEmpty) {
      setState(() => messageError = 'Required');
      isValid = false;
    }

    return isValid;
  }

  // Future<void> sendEmail(String message) async {
  //   FirebaseFirestore.instance.collection('mail').add({
  //     'to': 'dalilak.app@gmail.com',
  //     'message': {'subject': 'Dalilak Reach Out', 'text': message}
  //   });
  // }
}
