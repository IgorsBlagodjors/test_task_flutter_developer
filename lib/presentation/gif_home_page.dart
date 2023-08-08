import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task_flutter_developer/presentation/bloc/gif_list_cubit.dart';
import 'package:test_task_flutter_developer/presentation/bloc/gif_list_state.dart';

class GifHomePage extends StatefulWidget {
  const GifHomePage({Key? key}) : super(key: key);

  @override
  State<GifHomePage> createState() => _GifHomePageState();

  static Widget withCubit() => BlocProvider(
        create: (context) => GifListCubit(
          context.read(),
        ),
        child: const GifHomePage(),
      );
}

class CustomScrollPhysics extends ClampingScrollPhysics {
  final double scrollingSpeed;

  const CustomScrollPhysics({this.scrollingSpeed = 1.0});

  @override
  double applyPhysicsToUserOffset(ScrollMetrics position, double offset) {
    return offset * scrollingSpeed;
  }
}

class CustomScrollBehavior extends ScrollBehavior {
  final double scrollingSpeed;

  const CustomScrollBehavior({this.scrollingSpeed = 1.0});

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return CustomScrollPhysics(scrollingSpeed: scrollingSpeed);
  }
}

class _GifHomePageState extends State<GifHomePage> {
  late final GifListCubit _cubit;
  late final ScrollController _scrollController;
  bool _isLoadingMoreGifs = false;
  String? _queryFromLiveSearch;
  Timer? _searchTimer;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _cubit = BlocProvider.of<GifListCubit>(context);
    _cubit.fetchCollection(_queryFromLiveSearch);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return BlocBuilder<GifListCubit, GifListState>(
      builder: (context, state) {
        Widget child;
        if (state.isError) {
          child = const Center(
            child: Text('Failure error'),
          );
        } else {
          final data = state.items;
          child = GridView.builder(
            controller: _scrollController,
            itemBuilder: (_, index) {
              return Column(
                children: [
                  CachedNetworkImage(
                    height: data[index].parsedHeight,
                    width: data[index].parsedWidth,
                    imageUrl: data[index].gifUrl,
                    placeholder: (context, url) => const Center(
                      child: SizedBox(
                        height: 15,
                        width: 15,
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.green),
                          strokeWidth: 5,
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => const Center(
                      child: Text('Gif loading failed'),
                    ),
                  ),
                ],
              );
            },
            itemCount: data.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
            ),
          );
        }
        return ScrollConfiguration(
          behavior: const CustomScrollBehavior(scrollingSpeed: 0.5),
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  TextFormField(
                    onChanged: (query) {
                      _searchTimer?.cancel();
                      _cubit.setOffset(0);
                      _searchTimer = Timer(
                        const Duration(milliseconds: 300),
                        () {
                          _queryFromLiveSearch = query;
                          _cubit.fetchCollection(query);
                          _scrollController.jumpTo(0.0);
                        },
                      );
                    },
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      hintText: 'Live search...',
                      hintStyle: const TextStyle(
                        color: Colors.black,
                      ),
                      contentPadding: const EdgeInsets.only(
                        left: 48,
                        top: 20,
                        right: 147,
                        bottom: 20,
                      ),
                      prefixIcon: const Padding(
                        padding: EdgeInsets.only(
                          left: 15,
                          top: 19,
                          bottom: 19,
                        ),
                        child: Icon(Icons.search),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Expanded(
                    child: Center(child: child),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _scrollListener() {
    if (_scrollController.position.pixels > 0.0) {
      FocusScope.of(context).unfocus();
    }
    double maxScrollExtent = _scrollController.position.maxScrollExtent;
    double currentScrollExtent = _scrollController.position.pixels;
    double remainingScrollExtent = maxScrollExtent - currentScrollExtent;
    double pixelRemainder = 300;

    if (remainingScrollExtent < pixelRemainder && !_isLoadingMoreGifs) {
      _loadMoreGifs();
    }
  }

  void _loadMoreGifs() {
    _isLoadingMoreGifs = true;
    _cubit.fetchCollection(_queryFromLiveSearch).then((_) {
      _isLoadingMoreGifs = false;
    });
  }
}
