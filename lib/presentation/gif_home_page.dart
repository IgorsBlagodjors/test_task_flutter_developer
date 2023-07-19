import 'package:flutter/material.dart';
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

class _GifHomePageState extends State<GifHomePage> {
  late final GifListCubit _cubit;
  late TextEditingController _textEditingController;
  late ScrollController _scrollController;
  int offset = 30;
  bool _isLoadingMoreGifs = false;
  String? _queryFromLiveSearch;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _cubit = BlocProvider.of<GifListCubit>(context);
    _cubit.fetchCollection();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    _textEditingController.dispose();
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GifListCubit, GifListState>(builder: (context, state) {
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
                Image.network(
                  data[index].gifUrl,
                  height: double.parse(data[index].height),
                  width: double.parse(data[index].width),
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return const Center(
                      child: SizedBox(
                        height: 15,
                        width: 15,
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.green),
                          strokeWidth: 5,
                        ),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Text('Image loading failed'),
                    );
                  },
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
          // primary: false,
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
                    _queryFromLiveSearch = query;
                    _cubit.liveSearch(query);
                    _textEditingController.clear();
                    _scrollController.jumpTo(0.0);
                  });
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
      );
    });
  }

  void _scrollListener() {
    double maxScrollExtent = _scrollController.position.maxScrollExtent;
    double currentScrollExtent = _scrollController.position.pixels;
    double remainingScrollExtent = maxScrollExtent - currentScrollExtent;
    double pixelRemainder = 300;
    // print('CURRENT POSITION${_scrollController.position}');
    // print('MAX POSITION${_scrollController.position.maxScrollExtent}');

    if (remainingScrollExtent < pixelRemainder && !_isLoadingMoreGifs) {
      _loadMoreGifs();
    }
  }

  void _loadMoreGifs() {
    setState(() {
      _isLoadingMoreGifs = true;
    });
    _cubit.fetchMoreGifs(_queryFromLiveSearch, offset).then((_) {
      offset += 30;
      setState(() {
        _isLoadingMoreGifs = false;
      });
    });
  }
}
