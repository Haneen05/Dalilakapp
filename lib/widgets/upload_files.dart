import 'dart:io';

import 'package:daleelakappx/theme.dart';
import 'package:daleelakappx/widgets.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadFilesWidget extends StatelessWidget {
  final ImagePicker _picker = ImagePicker();

  final Widget label;
  final Function(File image)? onImageSelected;
  final VoidCallback? onRemove;
  final ImageProvider? image;
  final int? size;
  final bool fluid;

  UploadFilesWidget({
    super.key,
    required this.label,
    required this.onImageSelected,
    this.onRemove,
    this.image,
    this.size,
    this.fluid = true,
  });

  @override
  Widget build(BuildContext context) {
    final image = this.image;
    final size = this.size;
    final sizeInMb =
        size != null ? (size / (1024 * 1024)).toStringAsFixed(2) : '';

    return LabelField(
      label: label,
      input: DColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSpacing: 10.0,
        children: [
          if (image == null)
            Builder(builder: (context) {
              final child = InkWell(
                onTap: pickImage,
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(
                    DBox.borderRadiusMd,
                  ),
                  color: const Color(0xff94a3b8),
                  padding: const EdgeInsets.all(24.0),
                  strokeWidth: 1.0,
                  dashPattern: const [6.0, 6.0],
                  child: const Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.cloud_upload_outlined),
                        Text.rich(TextSpan(children: [
                          TextSpan(
                            text: 'Choose',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(text: ' '),
                          TextSpan(text: 'your file(s)'),
                        ])),
                        Text(
                          'jpg, png, or svg',
                          style: TextStyle(
                            color: Color(0xff6d6d6d),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );

              if (fluid) return child;

              return IntrinsicWidth(child: child);
            }),
          if (image != null)
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xffe7e7e7)),
              ),
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                height: 64,
                child: DRow(
                  mainAxisSpacing: 16.0,
                  children: [
                    Image(
                      image: image,
                      fit: BoxFit.cover,
                      height: 64,
                      width: 64,
                    ),
                    Expanded(
                      child: DColumn(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSpacing: 6.0,
                        children: [
                          const Text(
                            'Photo',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          if (size != null) Text('$sizeInMb MB'),
                        ],
                      ),
                    ),
                    if (onRemove != null)
                      IconButton(
                        onPressed: onRemove,
                        icon: const Icon(Icons.cancel_outlined),
                      )
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> pickImage() async {
    var pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File file = File(pickedFile.path);
      onImageSelected?.call(file);
    }
  }
}
