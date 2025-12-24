import 'dart:async';
import 'dart:math';

import 'package:daleelakappx/theme.dart';
import 'package:daleelakappx/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OtpInputWidget extends StatefulWidget {
  final int otpLength;
  final Duration expiresIn;
  final Function(String otp)? onFilled;
  final BoxConstraints constraints;

  const OtpInputWidget({
    super.key,
    required this.onFilled,
    this.otpLength = 4,
    this.expiresIn = const Duration(minutes: 1),
    required this.constraints,
  });

  @override
  State<OtpInputWidget> createState() => OtpInputWidgetState();
}

class OtpInputWidgetState extends State<OtpInputWidget> {
  static const oneSec = Duration(seconds: 1);

  late final List<FocusNode> focusNodes;
  late final List<TextEditingController> controllers;
  late Timer timer;

  late Duration remaining;

  @override
  void initState() {
    var len = widget.otpLength;
    focusNodes = List.generate(len, (_) => FocusNode());
    controllers = List.generate(len, (_) => TextEditingController());
    remaining = widget.expiresIn;
    timer = Timer.periodic(oneSec, (timer) {
      if (remaining == Duration.zero) {
        timer.cancel();
      } else {
        setState(() => remaining = remaining - oneSec);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void resetTimer() {
    if (timer.isActive) {
      timer.cancel();
    }
    remaining = widget.expiresIn;
    timer = Timer.periodic(oneSec, (timer) {
      if (remaining == Duration.zero) {
        timer.cancel();
      } else {
        setState(() => remaining = remaining - oneSec);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: min(widget.constraints.maxWidth, 56.0 * 6),
          ),
          child: DRow(
            mainAxisSize: MainAxisSize.min,
            mainAxisSpacing: DBox.mdSpace,
            children: List.generate(widget.otpLength, (index) {
              return Expanded(
                child: TextField(
                  textAlign: TextAlign.center,
                  focusNode: focusNodes[index],
                  keyboardType: TextInputType.number,
                  controller: controllers[index],
                  onChanged: (text) {
                    if (text.length > 1) {
                      text = controllers[index].text =
                          text.substring(text.length - 1);
                    }
                    if (text.length == 1) {
                      if (index + 1 < widget.otpLength) {
                        focusNodes[index + 1].requestFocus();
                      } else {
                        widget.onFilled?.call(controllers
                            .map((controller) => controller.text)
                            .join());
                        WidgetsBinding.instance.focusManager.primaryFocus
                            ?.unfocus();
                      }
                    } else if (index - 1 >= 0) {
                      focusNodes[index - 1].requestFocus();
                    }
                  },
                ),
              );
            }),
          ),
        ),
        const DBox.verticalSpaceMd(),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(text: AppLocalizations.of(context)!.codeExpiresIn),
              TextSpan(
                text: '${remaining.inSeconds}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
            style: const TextStyle(
              color: Color(0xff828282),
            ),
          ),
        )
      ],
    );
  }
}
