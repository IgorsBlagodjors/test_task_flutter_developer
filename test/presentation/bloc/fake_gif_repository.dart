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
  Future<List<GifClass>> fetchCollection() async {
    return [gif];
  }

  @override
  Future<List<GifClass>> fetchMoreGifs(String? query, int offset) async {
    if ( query == null ){
      throw Exception('Exception test');
    }else {
      return [gif];
    }
  }

  @override
  Future<List<GifClass>> liveSearch(String query) async {
    return [gif];
  }
}
