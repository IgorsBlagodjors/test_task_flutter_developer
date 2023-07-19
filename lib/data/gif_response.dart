import 'package:json_annotation/json_annotation.dart';

part 'gif_response.g.dart';

@JsonSerializable(createToJson: false)
class FullResponse {
  List<DataItems> data;

  FullResponse({required this.data});

  factory FullResponse.fromJson(Map<String, dynamic> json) =>
      _$FullResponseFromJson(json);
}

@JsonSerializable(createToJson: false)
class DataItems {
  final String id;
  final ImagesItems images;

  const DataItems({required this.id, required this.images});

  factory DataItems.fromJson(Map<String, dynamic> json) =>
      _$DataItemsFromJson(json);
}

@JsonSerializable(createToJson: false)
class ImagesItems {
  @JsonKey(name: 'fixed_height_small')
  final FixedHeightSmallItems fixedHeightSmall;

  const ImagesItems({required this.fixedHeightSmall});

  factory ImagesItems.fromJson(Map<String, dynamic> json) =>
      _$ImagesItemsFromJson(json);
}

@JsonSerializable(createToJson: false)
class FixedHeightSmallItems {
  final String height;
  final String width;
  final String url;

  const FixedHeightSmallItems(
      {required this.height, required this.width, required this.url});

  factory FixedHeightSmallItems.fromJson(Map<String, dynamic> json) =>
      _$FixedHeightSmallItemsFromJson(json);
}
