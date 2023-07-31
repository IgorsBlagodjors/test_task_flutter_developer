// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gif_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FullResponse _$FullResponseFromJson(Map<String, dynamic> json) => FullResponse(
      data: (json['data'] as List<dynamic>)
          .map((e) => DataItems.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

DataItems _$DataItemsFromJson(Map<String, dynamic> json) => DataItems(
      id: json['id'] as String,
      images: ImagesItems.fromJson(json['images'] as Map<String, dynamic>),
    );

ImagesItems _$ImagesItemsFromJson(Map<String, dynamic> json) => ImagesItems(
      fixedHeightSmall: FixedHeightSmallItems.fromJson(
          json['fixed_height_small'] as Map<String, dynamic>),
    );

FixedHeightSmallItems _$FixedHeightSmallItemsFromJson(
        Map<String, dynamic> json) =>
    FixedHeightSmallItems(
      height: json['height'] as String,
      width: json['width'] as String,
      url: json['url'] as String,
    );
