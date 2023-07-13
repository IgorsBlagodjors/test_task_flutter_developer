import 'package:dio/dio.dart';
import 'package:test_task_flutter_developer/gif_response.dart';

class GifApiClient {
  final Dio _dio;
  final String _key = 'cUtGLps8396VZLLDeJO3017XvJ4RCfpk';

  GifApiClient(this._dio);

  Future<List<DataItems>> getItemsApiClient(
      {String query = "Shaman King"}) async {
    var queryParam = '?api_key=$_key&q=$query&limit=50';
    final response = await _dio.get('/v1/gifs/search$queryParam');
    final fullResponse = FullResponse.fromJson(response.data);
    print('RESPONSE TEST!!!!! $fullResponse');
    return fullResponse.data;
  }
}
