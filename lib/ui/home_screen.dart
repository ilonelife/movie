import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movie/data/movie_api.dart';
import 'package:movie/model/movie.dart';

import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Movie> _movies = []; // Movie? _movies;
  List<Movie> _origin = []; // 검색 후 원래 데이터로 복구하기 위해서
  Timer? _debounce;

  final _api = MovieApi();
  final _textEditingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _showResult('');
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  Future<void> _showResult(String query) async {
    List<Movie> movies = await _api.fetchMovies(query);
    setState(() {
      _movies = movies;
      _origin = _movies;
    });
  }

  // 검색어 앱력 루틴 개선 함
  // 키 입력이 어느  시간 중단 되며 그때 검색하게 됨.
  // 키 앱력 시 마다 검색해서 서버 부하 주는 거 방지 효과
  void onQueryChanged(String query) {
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }

    _debounce = Timer(const Duration(milliseconds: 500), () {
      setState(() {
        _origin = _movies
            .where(
              (e) => e.title.contains(query),
            )
            .toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('영화 정보 검색기'),
        actions: [
          IconButton(
              onPressed: () {
                _showResult('');
                // _movies = _origin;
                // setState(() {});
              },
              icon: const Icon(Icons.restart_alt_outlined)),
        ],
      ),
      body: Column(
        children: [
          _buildTextField(),
          Expanded(
            child: _buildGridView(),
          ),
        ],
      ),
    );
  }

  TextField _buildTextField() {
    return TextField(
      onChanged: onQueryChanged,
      controller: _textEditingController,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.search),
        ),
      ),
      // controller: _textEditingController,
      // decoration: InputDecoration(
      //   suffix: IconButton(
      //     onPressed: () {
      //       _movies = _movies
      //           .where((e) => e.title.contains(_textEditingController.text))
      //           .toList();
      //       setState(() {});
      //     },
      //     icon: const Icon(Icons.search),
      //   ),
      //   hintText: '검색어를 입력하세요',
      // ),
    );
  }

  GridView _buildGridView() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 0,
        crossAxisSpacing: 5,
        childAspectRatio: 0.5,
      ),
      itemCount: _origin.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            GestureDetector(
              child: Hero(
                child: Image.network('https://image.tmdb.org/t/p/original' +
                    _origin[index].posterPath),
                tag: "movie",
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(
                      title: _origin[index].title,
                      overView: _origin[index].overView,
                      posterPath: _origin[index].posterPath,
                      backdropPath: _origin[index].backdropPath,
                      releaseDate: _origin[index].releaseDate,
                      voteAverage: _origin[index].voteAverage,
                      voteCount: _origin[index].voteCount,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              _origin[index].title,
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            ),
          ],
        );
      },
    );
  }
}
