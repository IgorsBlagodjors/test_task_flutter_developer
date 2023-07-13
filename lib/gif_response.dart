import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'gif_response.g.dart';

@JsonSerializable(createToJson: false)
class FullResponse extends Equatable {
  List<DataItems> data;

  FullResponse({required this.data});

  factory FullResponse.fromJson(Map<String, dynamic> json) =>
      _$FullResponseFromJson(json);

  @override
  List<Object?> get props => [data];
}

@JsonSerializable(createToJson: false)
class DataItems extends Equatable {
  final String id;
  final ImagesItems images;

  const DataItems({required this.id, required this.images});

  factory DataItems.fromJson(Map<String, dynamic> json) =>
      _$DataItemsFromJson(json);

  @override
  List<Object?> get props => [id];
}

@JsonSerializable(createToJson: false)
class ImagesItems {
  final FixedHeightSmallItems fixed_height_small;

  const ImagesItems({required this.fixed_height_small});

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
