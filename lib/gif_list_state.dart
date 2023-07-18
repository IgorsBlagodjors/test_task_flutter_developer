import 'package:equatable/equatable.dart';
import 'package:test_task_flutter_developer/gifClass.dart';

class GifListState extends Equatable {
  final List<GifClass> items;
  final bool isLoading;
  final bool isError;

  const GifListState({
    required this.items,
    required this.isLoading,
    required this.isError,
  });

  GifListState copyWith({
    List<GifClass>? items,
    bool? isLoading,
    bool? isError,
  }) =>
      GifListState(
        items: items ?? this.items,
        isLoading: isLoading ?? this.isLoading,
        isError: isError ?? this.isError,
      );

  @override
  List<Object?> get props => [
        items,
        isLoading,
        isError,
      ];
}
