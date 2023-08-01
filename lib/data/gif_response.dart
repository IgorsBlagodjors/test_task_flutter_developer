import 'package:json_annotation/json_annotation.dart';
import 'package:test_task_flutter_developer/domain/gif_class.dart';

part 'gif_response.g.dart';

@JsonSerializable(createToJson: false)
class FullResponse {
  List<DataItems> data;

  FullResponse({required this.data});

  List<GifClass> toModel() {
    return data
        .map(
          (dataItem) => GifClass(
            id: dataItem.id,
            gifUrl: dataItem.images.fixedHeightSmall.url,
            height: dataItem.images.fixedHeightSmall.height,
            width: dataItem.images.fixedHeightSmall.width,
          ),
        )
        .toList();
  }

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

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class ImagesItems {
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

  const FixedHeightSmallItems({
    required this.height,
    required this.width,
    required this.url,
  });

  factory FixedHeightSmallItems.fromJson(Map<String, dynamic> json) =>
      _$FixedHeightSmallItemsFromJson(json);
}
