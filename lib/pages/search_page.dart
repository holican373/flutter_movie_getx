import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_test/controllers/search_controller.dart';
import 'package:movie_test/models/movie.dart';

import '../components/items/movie_item.dart';
import '../network/api.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  // List<Movie>? movieList;
  // bool isSearching = false;
  // bool didSearched = false;
  final SearchController c = Get.put(SearchController());

  @override
  void initState() {
    super.initState();
    c.functionSearch();
    c.resetMovie();
  }

  searchMovie(query) {
    c.sucessSearch();
    c.getSearchMovie(query);
  }

  Widget _movieSearchList() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: const Text("Movies")),
          Container(
            padding: const EdgeInsets.all(5.0),
            child: GridView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  childAspectRatio: 0.48,
                ),
                itemCount: c.movieList.length,
                itemBuilder: (_, index) {
                  Movie movie = c.movieList[index];
                  return MovieItem(tag: "search", movie: movie);
                }),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: TextField(
          style: const TextStyle(color: Colors.white),
          textInputAction: TextInputAction.search,
          decoration: const InputDecoration(
            hintStyle: TextStyle(color: Colors.white),
            hintText: "Search",
          ),
          onSubmitted: (value) {
            searchMovie(value);
          },
        )),
        body: Obx(() {
          return SingleChildScrollView(
            child: Column(
              children: [
                c.movieList.isEmpty
                    ? c.isSearching.value
                        ? const Center(child: CircularProgressIndicator())
                        : Container()
                    : _movieSearchList(),
              ],
            ),
          );
        }));
  }
}
