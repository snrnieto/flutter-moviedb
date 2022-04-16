import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:tmdb/constants.dart';
import 'package:tmdb/controller/movieController.dart';
import '../constants.dart';

class Home extends StatelessWidget {
  final MovieController movieController = Get.put(MovieController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Icon(Icons.menu),
        actions: [
          IconButton(
            icon: Icon(Icons.search_outlined),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => MovieSearch()));
            },
          )
        ],
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      extendBodyBehindAppBar: true,
      body: Obx(
        () {
          return movieController.isLoading.value
              ? Center(child: CircularProgressIndicator())
              : Stack(
                  children: [
                    Container(
                      height: size.height,
                      width: size.width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              "$bgURL${movieController.selectedMovie.value.bgURL}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      height: size.height,
                      width: size.width,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: FractionalOffset.bottomCenter,
                            end: FractionalOffset.topCenter,
                            colors: [
                              Colors.black87,
                              Colors.black26,
                            ],
                            stops: [
                              0.4,
                              1.0
                            ]),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
                              width: size.width,
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          color: Colors.black87,
                                        ),
                                        child: Text(
                                          "TRENDING",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          color: Colors.black87,
                                        ),
                                        child: Text(
                                          "${movieController.selectedMovie.value.releaseYear}",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          color: Colors.amber,
                                        ),
                                        child: Text(
                                          "${movieController.selectedMovie.value.rating}",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: movieController
                                        .selectedMovie.value.category
                                        .map((e) => Text(
                                              e.category,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ))
                                        .toList(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: size.width / 2,
                            height: 2,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(100.0)),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              width: size.width,
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: GFButton(
                                      padding: EdgeInsets.all(10),
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      shape: GFButtonShape.standard,
                                      onPressed: () {
                                        Get.snackbar(
                                            'Opeing Trailer on YouTube', '');
                                        movieController.launchURL(
                                            movieController
                                                .selectedMovie.value.title);
                                      },
                                      text: "Watch Trailer",
                                      color: Colors.red,
                                    ),
                                  ),
                                  Expanded(
                                    child: CarouselSlider.builder(
                                      options: CarouselOptions(
                                        autoPlay: false,
                                        viewportFraction: 0.5,
                                        height: size.height,
                                        enlargeCenterPage: true,
                                        onPageChanged: (i, _) {
                                          movieController.selectedMovies(i);
                                        },
                                      ),
                                      itemCount:
                                          movieController.trendingMovies.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return InkWell(
                                          onTap: () {
                                            movieController.getMovieDetail(
                                                movieController
                                                    .selectedMovie.value.id);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        MovieDescription()));
                                          },
                                          child: Container(
                                            margin: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              color: Colors.amber,
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                    "$posterURL${movieController.trendingMovies[index].posterURL}"),
                                                fit: BoxFit.cover,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }
}




class MovieDescription extends StatelessWidget {
  final MovieController movieController = Get.put(MovieController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: Obx(
        () {
          return movieController.isLoading.value
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Container(
                    width: size.width,
                    child: Column(
                      children: [
                        Container(
                          height: size.height * 0.35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(50),
                            ),
                            image: DecorationImage(
                              image: NetworkImage(
                                  '$bgURL${movieController.movie.value.bgURL}'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          width: size.width,
                          padding: EdgeInsets.all(25),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                contentPadding: EdgeInsets.all(0),
                                title: Text(
                                    "${movieController.movie.value.title}"),
                                subtitle: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      '${movieController.movie.value.releaseYear}',
                                      // '15+',
                                      '${movieController.movie.value.runtime}'
                                    ]
                                        .map((e) => Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 0, 10, 0),
                                              child: Text('$e'),
                                            ))
                                        .toList()),
                                trailing: IconButton(
                                  icon: Icon(Icons.favorite),
                                  onPressed: () {},
                                ),
                              ),
                              Wrap(
                                children: movieController.movie.value.category
                                    .map((e) => Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 0, 10, 0),
                                          child: Chip(label: Text('$e')),
                                        ))
                                    .toList(),
                              ),
                              SizedBox(height: 18),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Overview',
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                      '${movieController.movie.value.overview}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2),
                                ],
                              ),
                              SizedBox(height: 18),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Cast & Reparto',
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                  SizedBox(height: 10),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      mainAxisSize: MainAxisSize.max,
                                      children: movieController.movie.value.cast
                                          .map((e) => Container(
                                                width: size.width / 4,
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    CircleAvatar(
                                                      backgroundImage: NetworkImage(
                                                          '$posterURL${e.profileURL}'),
                                                      radius: 40,
                                                    ),
                                                    SizedBox(height: 10),
                                                    Text(
                                                      '${e.name}',
                                                      maxLines: 2,
                                                      textAlign:
                                                          TextAlign.center,
                                                      overflow:
                                                          TextOverflow.clip,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText2,
                                                    ),
                                                    SizedBox(height: 8),
                                                    Text(
                                                      '${e.character}',
                                                      maxLines: 2,
                                                      textAlign:
                                                          TextAlign.center,
                                                      overflow:
                                                          TextOverflow.clip,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .caption,
                                                    ),
                                                  ],
                                                ),
                                              ))
                                          .toList(),
                                    ),
                                  ),
                                  Divider(),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      mainAxisSize: MainAxisSize.max,
                                      children: movieController.movie.value.Reparto
                                          .map((e) => Container(
                                                width: size.width / 4,
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    CircleAvatar(
                                                      backgroundImage: e.profileURL ==
                                                              null
                                                          ? NetworkImage(
                                                              'https://randomuser.me/api/portraits/lego/1.jpg')
                                                          : NetworkImage(
                                                              '$posterURL${e.profileURL}'),
                                                      radius: 40,
                                                    ),
                                                    SizedBox(height: 10),
                                                    Text(
                                                      '${e.name}',
                                                      maxLines: 2,
                                                      textAlign:
                                                          TextAlign.center,
                                                      overflow:
                                                          TextOverflow.clip,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText2,
                                                    ),
                                                    SizedBox(height: 8),
                                                    Text(
                                                      '${e.job}',
                                                      maxLines: 2,
                                                      textAlign:
                                                          TextAlign.center,
                                                      overflow:
                                                          TextOverflow.clip,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .caption,
                                                    ),
                                                  ],
                                                ),
                                              ))
                                          .toList(),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }
}



class MovieSearch extends StatefulWidget {
  @override
  _MovieSearchState createState() => _MovieSearchState();
}

class _MovieSearchState extends State<MovieSearch> {
  final MovieController movieController = Get.put(MovieController());
  TextEditingController searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  Icon actionIcon = Icon(Icons.search);
  searchMovie(String movieName) {
    movieController.getSearchedMovie(movieName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: TextField(
          autofocus: true,
          focusNode: _focusNode,
          controller: searchController,
          decoration: InputDecoration(hintText: "Search.."),
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.search,
          onEditingComplete: () => searchMovie(searchController.text),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              alignment: Alignment.centerRight,
              onPressed: () => searchMovie(searchController.text),
              icon: Icon(Icons.search),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Obx(() => movieController.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : movieController.searchedMovies.length == 0
                ? Center(
                    child: Text('No Movie Found'),
                  )
                : ListView.separated(
                    separatorBuilder: (_, __) => Divider(),
                    itemCount: movieController.searchedMovies.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white10,
                            ),
                            height: MediaQuery.of(context).size.height * 0.25,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 3.4,
                                ),
                                Expanded(
                                  child: ListTile(
                                    title: Text(
                                        "${movieController.searchedMovies[index].title}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5),
                                    subtitle: Wrap(
                                      children: movieController
                                          .searchedMovies[index].category
                                          .map((e) => Text('${e.category}  '))
                                          .toList(),
                                    ),
                                    trailing: Container(
                                      padding: EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        color: Colors.amber,
                                      ),
                                      child: Text(
                                        "${movieController.searchedMovies[index].rating}",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(10),
                            height: MediaQuery.of(context).size.height * 0.25,
                            width: MediaQuery.of(context).size.width / 3.5,
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              image: DecorationImage(
                                image: NetworkImage(
                                    "$posterURL${movieController.searchedMovies[index].posterURL}"),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ],
                      );
                    },
                  )),
      ),
    );
  }
}
