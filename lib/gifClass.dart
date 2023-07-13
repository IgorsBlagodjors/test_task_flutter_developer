import 'package:equatable/equatable.dart';

class GifClass extends Equatable {
  final String id;
  final String gifUrl;
  final String height;
  final String width;

  const GifClass(
      {required this.id,
      required this.gifUrl,
      required this.height,
      required this.width});

  @override
  List<Object?> get props => [id, gifUrl, height, width];
}
