import 'package:test_task_flutter_developer/domain/gif_class.dart';
import 'package:test_task_flutter_developer/data/gif_api_client.dart';
import 'package:test_task_flutter_developer/domain/gif_repository.dart';

class NetworkGifRepository implements GifRepository {
  final GifApiClient _gifApiClient;

  NetworkGifRepository(this._gifApiClient);

  @override
  Future<List<GifClass>> fetchCollection(String? query, int offset) async {
    bool isQueryEmpty = query == null;
    final response = isQueryEmpty
        ? await _gifApiClient.getItemsApiClient(offset: offset)
        : await _gifApiClient.getItemsApiClient(query: query, offset: offset);
    final gif = response.map(
      (e) => GifClass(
        id: e.id,
        gifUrl: e.images.fixedHeightSmall.url,
        height: e.images.fixedHeightSmall.height,
        width: e.images.fixedHeightSmall.width,
      ),
    );
    return gif.toList();
  }

  @override
  Future<List<GifClass>> liveSearch(String query) async {
    final response = await _gifApiClient.getItemsApiClient(query: query);
    final gif = response.map(
      (e) => GifClass(
        id: e.id,
        gifUrl: e.images.fixedHeightSmall.url,
        height: e.images.fixedHeightSmall.height,
        width: e.images.fixedHeightSmall.width,
      ),
    );
    return gif.toList();
  }

  @override
  Future<List<GifClass>> fetchMoreGifs(String? query, int offset) async {
    bool isQueryEmpty = query == null;
    final response = isQueryEmpty
        ? await _gifApiClient.getItemsApiClient(offset: offset)
        : await _gifApiClient.getItemsApiClient(query: query, offset: offset);
    final gif = response.map(
      (e) => GifClass(
        id: e.id,
        gifUrl: e.images.fixedHeightSmall.url,
        height: e.images.fixedHeightSmall.height,
        width: e.images.fixedHeightSmall.width,
      ),
    );
    return gif.toList();
  }
}
