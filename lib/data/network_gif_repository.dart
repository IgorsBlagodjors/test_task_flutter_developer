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
    return response;
  }
}
