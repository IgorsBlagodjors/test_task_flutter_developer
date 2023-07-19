import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:test_task_flutter_developer/domain/gif_class.dart';
import 'package:test_task_flutter_developer/presentation/bloc/gif_list_state.dart';
import 'package:test_task_flutter_developer/domain/gif_repository.dart';

class GifListCubit extends Cubit<GifListState> {
  final GifRepository _gifRepository;
  List<GifClass> _currentItems = [];
  final logger = Logger();

  GifListCubit(this._gifRepository)
      : super(
          const GifListState(
            items: [],
            isLoading: false,
            isError: false,
          ),
        );

  Future<void> fetchCollection() async {
    emit(state.copyWith(isLoading: true));
    try {
      final items = await _gifRepository.fetchCollection();
      _currentItems = items;
      emit(state.copyWith(items: items, isLoading: false));
    } on Exception catch (ex, stacktrace) {
      logger.e('Failed to load: ex $ex, stacktrace: $stacktrace');
      emit(state.copyWith(isError: true, isLoading: false));
    }
  }

  Future<void> liveSearch(String query) async {
    emit(state.copyWith(isLoading: true));
    await Future.delayed(const Duration(milliseconds: 300));
    try {
      final items = await _gifRepository.liveSearch(query);
      _currentItems = items;
      emit(state.copyWith(items: items, isLoading: false));
    } on Exception catch (ex, stacktrace) {
      logger.e('Failed to load: ex $ex, stacktrace: $stacktrace');
      emit(state.copyWith(isError: true, isLoading: false));
    }
  }

  Future<void> fetchMoreGifs(String? query, int offset) async {
    emit(state.copyWith(isLoading: true));
    try {
      final items = await _gifRepository.fetchMoreGifs(query, offset);
      _currentItems.addAll(items);
      emit(state.copyWith(items: _currentItems, isLoading: false));
    } on Exception catch (ex, stacktrace) {
      logger.e('Failed to load: ex $ex, stacktrace: $stacktrace');
      emit(state.copyWith(isError: true, isLoading: false));
    }
  }
}
