import 'package:test_task_flutter_developer/domain/gif_class.dart';
import 'package:test_task_flutter_developer/domain/gif_repository.dart';

const gif = GifClass(
  id: 'afg',
  gifUrl: 'Unknown',
  height: '300',
  width: '100',
);

class FakeGifRepository implements GifRepository {
  @override
  Future<List<GifClass>> fetchCollection(String? query, int?  offset) async {
    return [gif];
  }
}
