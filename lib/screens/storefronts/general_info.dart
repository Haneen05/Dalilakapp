import 'dart:async';
import 'dart:io';

import 'package:daleelakappx/models.dart';
import 'package:daleelakappx/widgets.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:daleelakappx/api.dart' as api;

class GeneralInformationCard extends StatefulWidget {
  const GeneralInformationCard({
    super.key,
  });

  @override
  State<GeneralInformationCard> createState() => GeneralInformationCardState();
}

class GeneralInformationCardState extends State<GeneralInformationCard> {
  var categories = Completer<List<Category>>().future;
  var subcategories = Completer<List<Subcategory>>().future;
  var input = GeneralInformationInput();
  var errors = GeneralInformationErrors();
  List<Category> cats = [];
  List<Subcategory> subCats = [];
  final FocusNode _nameFocusNode = FocusNode();


  @override
  void initState() {
    categories = api.categories.findMany();
    subcategories = api.subcategories.findMany();
    _nameFocusNode.addListener(() {
      if (!_nameFocusNode.hasFocus) {
        setState(() {
          input.name.text = capitalizeEachWord(input.name.text);
        });
      }
    });
    super.initState();
  }

  String capitalizeEachWord(String text) {
    return text
        .split(' ')
        .map((word) => word.isNotEmpty
        ? '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}'
        : '')
        .join(' ');
  }

  @override
  Widget build(BuildContext context) {
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
        padding: const EdgeInsets.all(22.0),
        child: DColumn(
          mainAxisSpacing: 25.0,
          children: [
            DRow(
              mainAxisSpacing: 12.0,
              children: [
                const Icon(Icons.store),
                Text(
                  'General Information',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            FutureBuilder(
              future: selectedImageSize,
              initialData: 0,
              builder: (context, snapshot) {
                return Skeletonizer(
                  enabled: snapshot.connectionState != ConnectionState.done,
                  child: UploadFilesWidget(
                    fluid: false,
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
            LabelField(
              label: Row(
                children: const [
                  Text('StoreFrontNameInEnglish'),
                  Text(' *', style: TextStyle(color: Colors.red)),
                ],
              ),
              input: TextField(
                decoration: InputDecoration(
                  hintText: 'Enter Name in English',
                  errorText: errors.name,
                ),
                controller: input.name,
                focusNode: _nameFocusNode,
              ),
            ),
            LabelField(
              label: const Text('StorefrontNameInArabic'),
              input: TextField(
                decoration:
                    const InputDecoration(hintText: 'Enter Name in Arabic'),
                controller: input.nameAr,
              ),
            ),
            LabelField(
              label: Row(
                children: const [
                  Text('SelectField'),
                  Text(' *', style: TextStyle(color: Colors.red)),
                ],
              ),
              input: DColumn(
                mainAxisSpacing: 13.0,
                children: [
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return FutureBuilder(
                        future: (categories, categoryId).wait,
                        initialData: (
                          Category.dummyData(),
                          null,
                        ),
                        builder: (context, snapshot) {
                          var (categories, categoryId) = snapshot.data!;
                          var category = categoryId != null
                              ? categories.firstWhere(
                                  (category) => category.id == categoryId)
                              : null;
                          return Skeletonizer(
                            enabled: snapshot.connectionState !=
                                ConnectionState.done,
                            child: DropdownMenu(
                              width: constraints.maxWidth,
                              hintText: 'Category',
                              controller: TextEditingController(
                                text: category?.name,
                              ),
                              onSelected: (selected) {
                                setState(() {
                                  input.categoryId = selected;
                                  input.subcategoryId = null;
                                });
                              },
                              dropdownMenuEntries: categories.map((category) {
                                return DropdownMenuEntry(
                                  value: category.id,
                                  label: category.name,
                                );
                              }).toList(),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return FutureBuilder(
                        future: subcategories,
                        initialData: Subcategory.dummyData(),
                        builder: (context, snapshot) {
                          return Skeletonizer(
                            enabled: snapshot.connectionState !=
                                ConnectionState.done,
                            child: DropdownMenu(
                                width: constraints.maxWidth,
                                hintText: 'Sub-Category',
                                errorText: errors.subcategoryId,
                                controller: TextEditingController(
                                    text: input.subcategoryId != null
                                        ? snapshot.data!
                                            .firstWhere((elem) =>
                                                elem.id == input.subcategoryId)
                                            .name
                                        : ''),
                                onSelected: (selected) {
                                  setState(() {
                                    if (selected != null) {
                                      input.subcategoryId = selected;
                                      errors.subcategoryId = null;
                                    }
                                  });
                                },
                                dropdownMenuEntries: snapshot.data!
                                    .where((sub) =>
                                        sub.categoryRef?.id == input.categoryId)
                                    .map((subcategory) {
                                  return DropdownMenuEntry(
                                    value: subcategory.id,
                                    label: subcategory.name,
                                  );
                                }).toList()),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
            LabelField(
              label: Row(
                children: const [
                  Text('StorefrontDescriptionInEnglish'),
                  Text(' *', style: TextStyle(color: Colors.red)),
                ],
              ),
              input: TextField(
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Description in English',
                  errorText: errors.description,
                ),
                controller: input.description,
                onChanged: (_) {
                  setState(() => errors.description = null);
                },
              ),
              helperText: Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(text: 'Character Remaining'),
                    const TextSpan(text: ' '),
                    TextSpan(
                      text: (255 - input.description.text.length).toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            LabelField(
              label: const Text('StoreFrontDescriptionInArabic'),
              input: TextField(
                maxLines: 5,
                decoration: const InputDecoration(
                  hintText: 'Description in Arabic',
                ),
                controller: input.descriptionAr,
              ),
              helperText: Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(text: 'Character Remaining'),
                    const TextSpan(text: ' '),
                    TextSpan(
                      text: (255 - input.descriptionAr.text.length).toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
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
          ],
        ),
      ),
    );
  }

  bool validate() {
    bool valid = true;
    if (input.name.text.trim().isEmpty) {
      setState(() => errors.name = 'Required');
      valid = false;
    }

    if (input.description.text.trim().isEmpty) {
      setState(() => errors.description = 'Required');
      valid = false;
    }

    if (input.description.text.length > 255) {
      setState(() => errors.description = 'Text too long');
      valid = false;
    }

    if (input.subcategoryId == null) {
      setState(() => errors.subcategoryId = 'Required');
      valid = false;
    }

    return valid;
  }

  void mapFrom(Storefront value) {
    setState(() {
      input.name.text = value.name;
      input.subcategoryId = value.subcategoryRef?.id;
      input.description.text = value.description;
      input.tags = value.tags;
      input.existingImage = value.image;
    });
  }

  Future<String?> get categoryId async {
    final subcategoryId = input.subcategoryId;
    if (subcategoryId == null) return input.categoryId;

    var subcategory = await api.subcategories.findOne(subcategoryId);

    final categoryRef = subcategory.categoryRef;
    if (categoryRef == null) {
      return input.categoryId = null;
    }

    return categoryRef.id;
  }
}

class GeneralInformationErrors {
  String? name;
  String? description;
  String? subcategoryId;
}

class GeneralInformationInput {
  TextEditingController name = TextEditingController(text: '');
  TextEditingController nameAr = TextEditingController(text: '');
  String? subcategoryId;
  String? categoryId;
  TextEditingController description = TextEditingController(text: '');
  TextEditingController descriptionAr = TextEditingController(text: '');
  List<String> tags = [];
  File? image;
  StorageImage? existingImage;
}
