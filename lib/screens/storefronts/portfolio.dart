import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;

class PortfolioImagesInput extends StatefulWidget {
  final List<String>? preloadedImages;

  const PortfolioImagesInput({super.key, this.preloadedImages});

  @override
  State<PortfolioImagesInput> createState() => PortfolioImagesInputState();
}

class PortfolioImagesInputState extends State<PortfolioImagesInput> {
  final List<XFile?> _images = [];
  bool isUploading = false;

  @override
  void initState() {
    super.initState();
    if (widget.preloadedImages != null) {
      for (var url in widget.preloadedImages!) {
        _images.add(XFile(url));
      }
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _images.add(image);
      });
    }
  }

  Future<List<String>> uploadImages() async {
    List<String> downloadUrls = [];
    for (var image in _images) {
      if (image != null && !image.path.startsWith('http')) {
        var extension = path.extension(image.path);
        var timestamp = DateTime.now().millisecondsSinceEpoch.toString();
        var filePath = 'storefronts/portfolio/$timestamp$extension';

        var metadata = SettableMetadata(
          contentType: 'image/${extension.replaceFirst('.', '')}',
        );

        var uploadTask = FirebaseStorage.instance
            .ref()
            .child(filePath)
            .putFile(File(image.path), metadata);
        var snapshot = await uploadTask.whenComplete(() {});
        var downloadUrl = await snapshot.ref.getDownloadURL();

        downloadUrls.add(downloadUrl);
      } else if (image != null) {
        downloadUrls.add(image.path);
      }
    }
    return downloadUrls;
  }

  void _removeImage(XFile image) {
    setState(() {
      _images.remove(image);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.file_copy_outlined),
                SizedBox(width: 8),
                Text(
                  'Portfolio',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ],
            ),
            const SizedBox(height: 4),
            const Text(
              'Select and upload the files of your choice',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  border: Border.all(style: BorderStyle.solid, width: 1),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.cloud_upload, size: 40),
                    SizedBox(height: 8),
                    Text('ChooseYourFile(s)'),
                    Text('Jpg,Png,OrSvg', style: TextStyle(fontSize: 12)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Column(
              children: _images.map((image) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black45),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: image!.path.startsWith('http')
                              ? Image.network(
                                  image.path,
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                )
                              : Image.file(
                                  File(image.path),
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Photo ${_images.indexOf(image) + 1}',
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                                overflow: TextOverflow.ellipsis,
                              ),
                              if (!image.path.startsWith('http'))
                                Text(
                                  '${(File(image.path).lengthSync() / (1024 * 1024)).toStringAsFixed(1)} MB',
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.black54),
                                ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.highlight_off_outlined,
                              color: Colors.black54),
                          onPressed: () => _removeImage(image),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  List<XFile?> get images => _images;
}
