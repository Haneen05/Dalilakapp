import 'package:daleelakappx/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AdminSearchBox extends StatelessWidget {
  const AdminSearchBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l18 = AppLocalizations.of(context)!;
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: l18.searchForSubCategory,
              fillColor: Color(0xfff8fafc),
              filled: true,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            ),
          ),
        ),
        // const DBox.horizontalSpaceXl(),
        // IconButton.filled(
        //   style: IconButton.styleFrom(
        //     backgroundColor: const Color(0xff020617),
        //     padding: const EdgeInsets.all(DBox.lgSpace),
        //     shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(
        //         DBox.borderRadiusSm,
        //       ),
        //     ),
        //   ),
        //   icon: const Icon(
        //     Icons.display_settings_outlined,
        //     color: Colors.white,
        //   ),
        //   onPressed: () {},
        // ),
      ],
    );
  }
}
