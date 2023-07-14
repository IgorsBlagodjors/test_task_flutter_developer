import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task_flutter_developer/gif_list_cubit.dart';
import 'package:test_task_flutter_developer/gif_list_state.dart';

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

class _GifHomePageState extends State<GifHomePage> {
  late final GifListCubit _cubit;

  late TextEditingController _textEditingController;
  late ScrollController _scrollController;
  int counter = 30;

  bool _isLoadingMoreGifs = false;
  ScrollPosition? _previousScrollPosition;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _cubit = context.read();
    _cubit.loadItems();
  }

/*  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }*/

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GifListCubit, GifListState>(builder: (context, state) {
      Widget child;
      if (state.isLoading) {
        child = const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state.isError) {
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
                Image.network(
                  data[index].gifUrl,
                  height: double.parse(data[index].height),
                  width: double.parse(data[index].width),
                ),
              ],
            );
          },
          itemCount: data.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 1.0,
            mainAxisSpacing: 1.0,
          ),
          primary: false,
        );
      }
      return Scaffold(
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
                controller: _textEditingController,
                onFieldSubmitted: (query) {
                  setState(() {
                    //_startSearchDebounceTimer(query);
                    _cubit.liveSearch(query);
                    _textEditingController.clear();
                  });
                },
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  hintText: 'Live search...',
                  hintStyle: const TextStyle(
                    color: Colors.black,
                  ),
                  contentPadding: const EdgeInsets.only(
                    left: 48.0,
                    top: 19.5,
                    right: 147.0,
                    bottom: 19.5,
                  ),
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(
                      left: 15.0,
                      top: 18.97,
                      right: 0.0,
                      bottom: 19.03,
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
      );
    });
  }

/*void _startSearchDebounceTimer(String query) {
    _liveSearchTimer?.cancel();
    _liveSearchTimer = Timer(const Duration(milliseconds: 300), () {
      setState(() {
        _gifFuture = _gifRepository.liveSearch(query);
      });
    });
  }*/
  void _scrollListener() {
    double maxScrollExtent = _scrollController.position.maxScrollExtent;
    double currentScrollExtent = _scrollController.position.pixels;
    double remainingScrollExtent = maxScrollExtent - currentScrollExtent;
    double pixelRemainder = 200.0;
    print('CURRENT POSITION${_scrollController.position}');
    print('MAX POSITION${_scrollController.position.maxScrollExtent}');

    if (remainingScrollExtent < pixelRemainder && !_isLoadingMoreGifs) {
      _previousScrollPosition = _scrollController.position;
      _loadMoreGifs();
    }
  }

  void _loadMoreGifs() {
    if (!_isLoadingMoreGifs) {
      setState(() {
        _isLoadingMoreGifs = true;
      });

      _cubit.loadMoreItems(counter).then((_) {
        counter += 30;
        setState(() {
          _isLoadingMoreGifs = false;
        });
        _scrollController.jumpTo(_previousScrollPosition?.pixels ?? 0.0);
      });
    }
  }
/*void _loadMoreResults() async {
    setState(() {
      _isLoadingMoreGifs = true;
    });
    final additionalResults = await _gifRepository.fetchMoreResults(counter);
    counter += 30;

    final currentResults = await _gifFuture;
    setState(() {
      _gifFuture = Future.value(currentResults + additionalResults);
      _isLoadingMoreGifs = false;
    });

    if (_scrollController.hasClients) {
      SchedulerBinding.instance?.addPostFrameCallback((_) {
        _scrollController.jumpTo(_previousScrollPosition?.pixels ?? 0.0);
      });
    }
  }*/
}
