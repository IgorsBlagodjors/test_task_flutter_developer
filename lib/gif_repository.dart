import 'package:test_task_flutter_developer/gifClass.dart';

abstract class GifRepository {
  Future<List<GifClass>> fetchCollection();
  Future<List<GifClass>> liveSearch(String query);
  Future<List<GifClass>> fetchMoreResults(String? query, int offset);
}
