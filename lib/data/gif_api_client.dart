import 'package:dio/dio.dart';
import 'package:test_task_flutter_developer/data/api_key.dart';
import 'package:test_task_flutter_developer/data/gif_response.dart';

class GifApiClient {
  final Dio _dio;

  GifApiClient(this._dio);

  Future<List<DataItems>> getItemsApiClient(
      {String query = "Shaman King", int limit = 30, int offset = 0}) async {
    final queryParams = {
      'api_key': ApiKey.gifApiKey,
      'q': query,
      'limit': limit.toString(),
      'offset': offset,
    };
    final response =
        await _dio.get('/v1/gifs/search', queryParameters: queryParams);
    final fullResponse = FullResponse.fromJson(response.data);
     //print('QUERY TEST!!! $query');
     //print('COUNTER OFFSET TEST!!!!! $offset');
    return fullResponse.data;
  }
}
