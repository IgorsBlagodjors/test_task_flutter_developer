import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task_flutter_developer/gifClass.dart';
import 'package:test_task_flutter_developer/gif_repository.dart';

class GifHomePage extends StatefulWidget {
  const GifHomePage({super.key});

  @override
  State<GifHomePage> createState() => _GifHomePageState();
}

class _GifHomePageState extends State<GifHomePage> {
  late final GifRepository _gifRepository;
  late Future<List<GifClass>> _gifFuture;
  Timer? _liveSearchTimer;
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _gifRepository = context.read();
    _gifFuture = _gifRepository.fetchCollection();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _liveSearchTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  _startSearchDebounceTimer(query);
                  _clearTextField();
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
              child: FutureBuilder<List<GifClass>>(
                future: _gifFuture,
                builder: (context, snapshot) {
                  final connectionState = snapshot.connectionState;
                  if (connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final gifs = snapshot.data ?? [];
                  return Center(
                    child: GridView.builder(
                      itemBuilder: (_, index) {
                        return Column(
                          children: [
                            Image.network(
                              gifs[index].gifUrl,
                              height: double.parse(gifs[index].height),
                              width: double.parse(gifs[index].width),
                            ),
                          ],
                        );
                      },
                      itemCount: gifs.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 1.0,
                        mainAxisSpacing: 1.0,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _startSearchDebounceTimer(String query) {
    _liveSearchTimer?.cancel();
    _liveSearchTimer = Timer(const Duration(milliseconds: 300), () {
      setState(() {
        _gifFuture = _gifRepository.liveSearch(query);
      });
    });
  }

  void _clearTextField() {
    _textEditingController.clear();
  }
}
