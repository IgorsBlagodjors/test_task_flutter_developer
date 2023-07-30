import 'package:test_task_flutter_developer/domain/gif_class.dart';

abstract class GifRepository {
  Future<List<GifClass>> fetchCollection(String? query, int offset);
}
