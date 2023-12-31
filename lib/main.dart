import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task_flutter_developer/data/gif_api_client.dart';
import 'package:test_task_flutter_developer/presentation/gif_home_page.dart';
import 'package:test_task_flutter_developer/domain/gif_repository.dart';
import 'package:test_task_flutter_developer/data/network_gif_repository.dart';

void main() {
  final dio = Dio(
    BaseOptions(baseUrl: 'https://api.giphy.com'),
  );
  dio.interceptors.add(
    LogInterceptor(
      responseBody: true,
      requestBody: true,
      requestHeader: true,
      responseHeader: true,
      request: true,
    ),
  );
  final gifApiClient = GifApiClient(dio);
  final networkGifRepository = NetworkGifRepository(gifApiClient);
  final networkRepositoryProvider = RepositoryProvider<GifRepository>(
    create: (context) => networkGifRepository,
  );
  runApp(
    MultiRepositoryProvider(
      providers: [
        networkRepositoryProvider,
      ],
      child: MaterialApp(
        home: GifHomePage.withCubit(),
      ),
    ),
  );
}
