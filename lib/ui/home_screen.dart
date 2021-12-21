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
  List<Movie> _movies = [];

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
    });
  }

  @override
  Widget build(BuildContext context) {
    const String _img_path = 'https://image.tmdb.org/t/p/original';
    return Scaffold(
      appBar: AppBar(
        title: const Text('영화 정보 검색기'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _textEditingController,
            decoration: InputDecoration(
              suffix: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search),
              ),
              hintText: '검색어를 입력하세요',
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 0,
                crossAxisSpacing: 5,
                childAspectRatio: 0.5,
              ),
              itemCount: _movies.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    GestureDetector(
                      child:
                          Image.network(_img_path + _movies[index].posterPath),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailScreen(
                              title: _movies[index].title,
                              overView: _movies[index].overView,
                              posterPath: _movies[index].posterPath,
                              backdropPath: _movies[index].backdropPath,
                              releaseDate: _movies[index].releaseDate,
                              voteAverage: _movies[index].voteAverage,
                              voteCount: _movies[index].voteCount,
                            ),
                          ),
                        );
                      },
                    ),
                    // Image.network(_img_path + _movies[index].posterPath),
                    Text(_movies[index].title),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
