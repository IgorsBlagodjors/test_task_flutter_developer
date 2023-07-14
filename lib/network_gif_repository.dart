import 'package:test_task_flutter_developer/gifClass.dart';
import 'package:test_task_flutter_developer/gif_api_client.dart';
import 'package:test_task_flutter_developer/gif_repository.dart';

class NetworkGifRepository implements GifRepository {
  final GifApiClient _gifApiClient;

  NetworkGifRepository(this._gifApiClient);

  @override
  Future<List<GifClass>> fetchCollection() async {
    final response = await _gifApiClient.getItemsApiClient();
    final gif = response.map((e) => GifClass(
        id: e.id,
        gifUrl: e.images.fixed_height_small.url,
        height: e.images.fixed_height_small.height,
        width: e.images.fixed_height_small.width));
    return gif.toList();
  }

  @override
  Future<List<GifClass>> liveSearch(String query) async {
    final response = await _gifApiClient.getItemsApiClient(query: query);
    final gif = response.map((e) => GifClass(
        id: e.id,
        gifUrl: e.images.fixed_height_small.url,
        height: e.images.fixed_height_small.height,
        width: e.images.fixed_height_small.width));
    return gif.toList();
  }

  @override
  Future<List<GifClass>> fetchMoreResults(int offset) async {
    final response = await _gifApiClient.getItemsApiClient(offset: offset);
    final gif = response.map((e) => GifClass(
        id: e.id,
        gifUrl: e.images.fixed_height_small.url,
        height: e.images.fixed_height_small.height,
        width: e.images.fixed_height_small.width));
    return gif.toList();
  }
}
