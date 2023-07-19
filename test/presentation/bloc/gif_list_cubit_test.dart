import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_task_flutter_developer/domain/gif_class.dart';
import 'package:test_task_flutter_developer/presentation/bloc/gif_list_cubit.dart';
import 'package:test_task_flutter_developer/presentation/bloc/gif_list_state.dart';

import 'fake_gif_repository.dart';

void main() {
  late GifListCubit cubit;
  late FakeGifRepository fakeGifRepository;

  setUp(() {
    fakeGifRepository = FakeGifRepository();
    cubit = GifListCubit(fakeGifRepository);
  });

  group('List of items tests', () {
    blocTest(
      'is empty when cubit is created',
      build: () => cubit,
      verify: (cubit) {
        expect(cubit.state.items, isEmpty);
        expect(cubit.state.isError, false);
        expect(cubit.state.isLoading, false);
      },
    );

    group('List of items tests', () {
      blocTest(
        'is not empty when loadItems is called',
        build: () => cubit,
        verify: (cubit) {
          expect(cubit.state.items, isEmpty);
          expect(cubit.state.isError, false);
          expect(cubit.state.isLoading, false);
        },
      );
    });
    blocTest(
      'Load Gift When App Starts',
      build: () => cubit,
      act: (cubit) => cubit.fetchCollection(),
      expect: () => [
        const GifListState(
          items: [],
          isLoading: true,
          isError: false,
        ),
        const GifListState(
          items: [
            GifClass(
              id: 'afg',
              gifUrl: 'Unknown',
              height: '300',
              width: '100',
            ),
          ],
          isLoading: false,
          isError: false,
        ),
      ],
    );
    blocTest(
      'Load More Gifs Test',
      build: () => cubit,
      act: (cubit) => cubit.fetchMoreGifs('empty', 12),
      expect: () => [
        const GifListState(
          items: [],
          isLoading: true,
          isError: false,
        ),
        const GifListState(
          items: [
            GifClass(
              id: 'afg',
              gifUrl: 'Unknown',
              height: '300',
              width: '100',
            ),
          ],
          isLoading: false,
          isError: false,
        ),
      ],
    );
    blocTest(
      'Live Search Test',
      build: () => cubit,
      act: (cubit) => cubit.liveSearch('empty'),
      expect: () => [
        const GifListState(
          items: [],
          isLoading: true,
          isError: false,
        ),
        const GifListState(
          items: [
            GifClass(
              id: 'afg',
              gifUrl: 'Unknown',
              height: '300',
              width: '100',
            ),
          ],
          isLoading: false,
          isError: false,
        ),
      ],
    );
    group('Load More Gifs Test', () {
      blocTest(
        'Fetching Test',
        build: () => cubit,
        act: (cubit) => cubit.fetchMoreGifs('Test', 12),
        expect: () => [
          const GifListState(
            items: [],
            isLoading: true,
            isError: false,
          ),
          const GifListState(
            items: [
              GifClass(
                id: 'afg',
                gifUrl: 'Unknown',
                height: '300',
                width: '100',
              ),
            ],
            isLoading: false,
            isError: false,
          ),
        ],
      );
      blocTest('Exception Test',
          build: () => cubit,
          act: (cubit) => cubit.fetchMoreGifs(null, 12),
          verify: (cubit) {
            expect(cubit.state.items, isEmpty);
          });
    });
  });
}
