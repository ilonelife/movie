import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movie/model/movie.dart';
import 'package:movie/ui/home_view_model.dart';
import 'package:provider/provider.dart';

import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Timer? _debounce;

//  final _api = MovieApi();
  final _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      // 아주 잠깐 딜레이
      // 여기부터는 context 가 null 아님
      _showResult('');
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  Future<void> _showResult(String query) async {
    context.read<HomeViewModel>().fetchMovies(query);
  }

  // 검색어 앱력 루틴 개선 함
  // 키 입력이 어느  시간 중단 되며 그때 검색하게 됨.
  // 키 앱력 시 마다 검색해서 서버 부하 주는 거 방지 효과
  void onQueryChanged(String query) {
    context.read<HomeViewModel>().searchWithQuery(query);
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();
    final movies = viewModel.movies;
    return Scaffold(
      appBar: AppBar(
        title: const Text('영화 정보 검색기'),
      ),
      body: Column(
        children: [
          _buildTextField(),
          Expanded(
            child: _buildGridView(movies),
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
        hintText: '검색어를 입력하세요',
      ),
    );
  }

  GridView _buildGridView(List<Movie> movies) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 0,
        crossAxisSpacing: 5,
        childAspectRatio: 0.5,
      ),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            GestureDetector(
              child: Hero(
                child: Image.network('https://image.tmdb.org/t/p/original' +
                    movies[index].posterPath),
                tag: "movie",
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(
                      title: movies[index].title,
                      overView: movies[index].overView,
                      posterPath: movies[index].posterPath,
                      backdropPath: movies[index].backdropPath,
                      releaseDate: movies[index].releaseDate,
                      voteAverage: movies[index].voteAverage,
                      voteCount: movies[index].voteCount,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              movies[index].title,
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            ),
          ],
        );
      },
    );
  }
}
