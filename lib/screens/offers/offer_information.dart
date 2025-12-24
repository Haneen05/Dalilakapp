import 'dart:io';

import 'package:daleelakappx/models.dart';
import 'package:daleelakappx/theme.dart';
import 'package:daleelakappx/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';

class OfferInformationCard extends StatefulWidget {
  const OfferInformationCard({
    super.key,
  });

  @override
  State<OfferInformationCard> createState() => OfferInformationCardState();
}

class OfferInformationCardState extends State<OfferInformationCard> {
  var input = OfferInformationInput();
  var errors = OfferInformationErrors();

  @override
  Widget build(BuildContext context) {
    final expiryDate = input.expiryDate;
    final inputImage = input.image;
    final existingImage = input.existingImage;

    final ImageProvider? selectedImageSrc = inputImage != null
        ? FileImage(inputImage)
        : existingImage != null
            ? NetworkImage(existingImage.url)
            : null;

    final Future<int> selectedImageSize = inputImage != null
        ? inputImage.length()
        : existingImage != null
            ? Future.value(existingImage.size)
            : Future.value(0);

    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(DBox.xlSpace),
        child: Column(
          children: [
            const Row(
              children: [
                Icon(Icons.discount_outlined),
                DBox.horizontalSpaceMd(),
                Text(
                  'Offer Information',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: DBox.fontLg,
                  ),
                ),
              ],
            ),
            const DBox.verticalSpace2Xl(),
            StaggeredGrid.count(
              crossAxisCount: 1,
              mainAxisSpacing: DBox.xlSpace,
              children: [
                LabelField(
                  label: const Text('OfferNameInEnglish'),
                  input: TextField(
                    decoration: InputDecoration(
                      errorText: errors.name,
                    ),
                    controller: input.name,
                    onChanged: (_) {
                      setState(() => errors.name = null);
                    },
                  ),
                ),
                LabelField(
                  label: const Text('OfferNameInArabic'),
                  input: TextField(
                    controller: input.nameAr,
                  ),
                ),
                LabelField(
                  label: const Text('OfferLink'),
                  input: TextField(
                    decoration: InputDecoration(
                        errorText: errors.url, hintText: 'https://example.com'),
                    controller: input.url,
                    onChanged: (_) {
                      setState(() => errors.url = null);
                    },
                  ),
                ),
                LabelField(
                  label: const Text('Keywords'),
                  input: TagsEditor(
                    onChanged: (tags) {
                      setState(() => input.tags = tags);
                    },
                  ),
                ),
                LabelField(
                  label: const Text('ExpiryDate'),
                  input: TextField(
                    readOnly: true,
                    controller: TextEditingController(
                      text: expiryDate != null
                          ? DateFormat('dd/MM/yyyy').format(expiryDate)
                          : '',
                    ),
                    onTap: () async {
                      var selectedDate = await showDatePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );
                      if (selectedDate != null) {
                        setState(() => input.expiryDate = selectedDate);
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'DD/MM/YYYY',
                      errorText: errors.expiryDate,
                    ),
                  ),
                ),
                FutureBuilder(
                  future: selectedImageSize,
                  initialData: 0,
                  builder: (context, snapshot) {
                    return Skeletonizer(
                      enabled: snapshot.connectionState != ConnectionState.done,
                      child: UploadFilesWidget(
                        label: const Text(
                            'Select and upload the files of your choice'),
                        onImageSelected: (image) {
                          setState(() => input.image = image);
                        },
                        image: selectedImageSrc,
                        size: snapshot.data!,
                        onRemove: () {
                          setState(() {
                            input.existingImage = null;
                            input.image = null;
                          });
                        },
                      ),
                    );
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void mapFrom(Offer value) {
    setState(() {
      input.name.text = value.name;
      input.url.text = value.url;
      input.tags = value.tags;
      input.expiryDate = value.expiryDate;
      input.existingImage = value.image;
    });
  }

  bool validate() {
    bool isValid = true;

    if (input.name.text.trim().isEmpty) {
      setState(() => errors.name = 'Required');
      isValid = false;
    }

    if (input.url.text.trim().isEmpty) {
      setState(() => errors.url = 'Required');
      isValid = false;
    }

    if (!_isValidUrl(input.url.text)) {
      setState(() => errors.url = 'Must be a URL');
      isValid = false;
    }

    if (input.expiryDate == null) {
      setState(() => errors.expiryDate = 'Required');
      isValid = false;
    }

    return isValid;
  }

  bool _isValidUrl(String url) {
    const urlPattern = r'^(https?:\/\/)'; // Matches 'http://' or 'https://'
    final regex = RegExp(urlPattern, caseSensitive: false);

    return regex.hasMatch(url);
  }
}

class OfferInformationInput {
  File? image; // To store the selected image
  StorageImage? existingImage;
  TextEditingController name = TextEditingController(text: '');
  TextEditingController nameAr = TextEditingController(text: '');
  TextEditingController url = TextEditingController(text: '');
  List<String> tags = [];
  DateTime? expiryDate;
}

class OfferInformationErrors {
  String? name;
  String? url;
  String? expiryDate;
}
