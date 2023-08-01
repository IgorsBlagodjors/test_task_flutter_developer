import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:test_task_flutter_developer/presentation/bloc/gif_list_state.dart';
import 'package:test_task_flutter_developer/domain/gif_repository.dart';

class GifListCubit extends Cubit<GifListState> {
  final GifRepository _gifRepository;
  int _offset = 0;
  final logger = Logger();

  GifListCubit(this._gifRepository)
      : super(
          const GifListState(
            items: [],
            isLoading: false,
            isError: false,
          ),
        );

  Future<void> fetchCollection(String? query) async {
    emit(state.copyWith(isLoading: true));
    try {
      final items = await _gifRepository.fetchCollection(query, _offset);
      final allItems = _offset != 0 ? state.items + items : items;
      _offset += 30;
      emit(state.copyWith(items: allItems, isLoading: false));
    } on Exception catch (ex, stacktrace) {
      logger.e('Failed to load: ex $ex, stacktrace: $stacktrace');
      emit(state.copyWith(isError: true, isLoading: false));
    }
  }

  setOffset(int value) {
    _offset = value;
  }
}
