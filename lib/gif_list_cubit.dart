import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task_flutter_developer/gifClass.dart';
import 'package:test_task_flutter_developer/gif_list_state.dart';
import 'package:test_task_flutter_developer/gif_repository.dart';

class GifListCubit extends Cubit<GifListState> {
  final GifRepository _gifRepository;
  List<GifClass> _currentItems = [];

  GifListCubit(this._gifRepository)
      : super(
          const GifListState(
            items: [],
            isLoading: false,
            isError: false,
          ),
        );

  Future<void> loadItems() async {
    emit(state.copyWith(isLoading: true));
    try {
      final items = await _gifRepository.fetchCollection();
      _currentItems = items;
      emit(state.copyWith(items: items, isLoading: false));
    } on Exception catch (ex, stacktrace) {
      // ignore: avoid_print
      print('Failed to load: ex $ex, stacktrace: $stacktrace');
      emit(state.copyWith(isError: true, isLoading: false));
    }
  }

  Future<void> liveSearch(String query) async {
    emit(state.copyWith(isLoading: true));
    await Future.delayed(const Duration(microseconds: 300));
    try {
      final items = await _gifRepository.liveSearch(query);
      emit(state.copyWith(items: items, isLoading: false));
    } on Exception catch (ex, stacktrace) {
      print('Failed to load: ex $ex, stacktrace: $stacktrace');
      emit(state.copyWith(isError: true, isLoading: false));
    }
  }

  Future<void> loadMoreItems(int query) async {
    emit(state.copyWith(isLoading: true));
    try {
      final items = await _gifRepository.fetchMoreResults(query);
      _currentItems.addAll(items);
      emit(state.copyWith(items: _currentItems, isLoading: false));
    } on Exception catch (ex, stacktrace) {
      print('Failed to load: ex $ex, stacktrace: $stacktrace');
      emit(state.copyWith(isError: true, isLoading: false));
    }
  }
}
