import 'package:get/get.dart';
import 'package:movie_test/models/cast.dart';
import 'package:movie_test/models/movie.dart';

import '../network/api.dart';

class SearchController extends GetxController {
  RxList<Movie> movieList = <Movie>[].obs;
  var isSearching = true.obs;
  var didSearched = true.obs;

  getSearchMovie(query) {
    API().getSearchMovies(query).then((value) {
      movieList.value = value;
      isSearching(false);
    });
  }

  resetMovie() {
    movieList.value = [];
  }

  functionSearch() {
    isSearching(false);
    didSearched(false);
  }

  sucessSearch() {
    isSearching(true);
    didSearched(true);
  }
}
