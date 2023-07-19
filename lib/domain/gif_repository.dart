import 'package:test_task_flutter_developer/domain/gif_class.dart';

abstract class GifRepository {
  Future<List<GifClass>> fetchCollection();
  Future<List<GifClass>> liveSearch(String query);
  Future<List<GifClass>> fetchMoreGifs(String? query, int offset);
}
