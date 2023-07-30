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

  Future<void> fetchCollection(String? query, int offset) async {
    emit(state.copyWith(isLoading: true));
    await Future.delayed(const Duration(milliseconds: 300));
    try {
      final items = await _gifRepository.fetchCollection(query, offset);
      offset != 0 ? _currentItems.addAll(items) : _currentItems = items;
      emit(state.copyWith(items: _currentItems, isLoading: false));
    } on Exception catch (ex, stacktrace) {
      logger.e('Failed to load: ex $ex, stacktrace: $stacktrace');
      emit(state.copyWith(isError: true, isLoading: false));
    }
  }
}
