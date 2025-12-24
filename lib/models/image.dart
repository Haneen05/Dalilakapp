import 'package:json_annotation/json_annotation.dart';

part 'image.g.dart';

@JsonSerializable(explicitToJson: true)
class StorageImage {
  final String path;
  final String url;
  final int size;

  StorageImage({
    required this.path,
    required this.url,
    required this.size,
  });

  Map<String, dynamic> toJson() => _$StorageImageToJson(this);

  factory StorageImage.fromJson(Map<String, dynamic> json) => _$StorageImageFromJson(json);
}
