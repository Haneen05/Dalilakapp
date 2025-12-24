import 'package:daleelakappx/provider.dart';
import 'package:daleelakappx/providers/language_provider.dart';
import 'package:daleelakappx/theme.dart';
import 'package:daleelakappx/widgets.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({super.key});

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  List<Placemark> _places = [];
  Placemark? _selectedPlace;
  bool _locationLoading = false;

  Future<void> fetchLocation() async {
    try {
      setState(() => _locationLoading = true);

      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        await Geolocator.openLocationSettings();
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.deniedForever) {
          return;
        }
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final places = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      setState(() {
        _places = places;
        if (places.isNotEmpty) {
          _selectedPlace = places.first;
        }
      });
    } finally {
      setState(() => _locationLoading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchLocation();
  }

  @override
  Widget build(BuildContext context) {
    final l18n = AppLocalizations.of(context)!;
    var user = DProvider.of(context).user;

    return DRow(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSpacing: DBox.lgSpace,
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundColor: const Color(0xffd9d9d9),
              child: user == null || user.name.isEmpty
                  ? const Icon(Icons.person_outline)
                  : Text(user.name.characters.first),
            ),
            const DBox.horizontalSpaceMd(),
            Skeletonizer(
              enabled: _locationLoading,
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  items: _places
                      .map((place) => DropdownMenuItem<Placemark>(
                            value: place,
                            child: Text(place.name ?? ""),
                          ))
                      .toList(),
                  value: _selectedPlace,
                  onChanged: (value) {
                    setState(() => _selectedPlace = value);
                  },
                ),
              ),
            )
          ],
        ),
        Row(
          children: [
            // if (user == null)
            //   Consumer<LanguageProvider>(
            //     builder: (context, languageProvider, child) {
            //       return PopupMenuButton<String>(
            //         icon: Icon(Icons.language, color: Colors.black),
            //         onSelected: (String value) {
            //           languageProvider.changeLanguage(value);
            //         },
            //         itemBuilder: (context) => [
            //           PopupMenuItem(value: 'en', child: Text('English')),
            //           PopupMenuItem(value: 'ar', child: Text('العربية')),
            //         ],
            //       );
            //     },
            //   ),
            TextButton(
              onPressed: () {
                if (user == null) {
                  Navigator.of(context).pushNamed('/account/login');
                } else {
                  Navigator.of(context).pushNamed('/account/profile');
                }
              },
              child: DRow(
                mainAxisSpacing: DBox.mdSpace,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (user != null)
                    Text(
                      "${l18n.welcome}, ${user.name.isNotEmpty ? user.name : user.phoneNumber}",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  DIcons.user,
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
