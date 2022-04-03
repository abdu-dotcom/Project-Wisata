import 'package:flutter/material.dart';
import 'package:project_wisata/model/tourism_place.dart';

class DetailScreen extends StatelessWidget {
  final TourismPlace place;

  DetailScreen({required this.place});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth > 800) {
        return DetailWebPage(
          place: place,
        );
      } else {
        return DetailMobilePage(place: place);
      }
    });
  }
}

class DetailWebPage extends StatefulWidget {
  final TourismPlace place;

  DetailWebPage({required this.place});

  @override
  State<DetailWebPage> createState() => _DetailWebPageState();
}

class _DetailWebPageState extends State<DetailWebPage> {
  final _scrollController = ScrollController();

  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 64,
        ),
        child: Center(
          child: Container(
            width: 1200,
            child: Column(
              children: [
                Text(
                  'Wisata Bandung',
                  style: TextStyle(
                    fontSize: 32,
                    fontFamily: 'Staatliches',
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          ClipRRect(
                            child: Image.asset(
                              widget.place.imageAsset,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Scrollbar(
                            controller: _scrollController,
                            // isAlwaysShown: true,
                            child: Container(
                              height: 150,
                              padding: EdgeInsets.only(bottom: 16.0),
                              child: ListView(
                                controller: _scrollController,
                                scrollDirection: Axis.horizontal,
                                children: widget.place.imageUrls.map((url) {
                                  return Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: Image.network(url)),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 32),
                    Expanded(
                      child: Card(
                        child: Container(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  widget.place.name,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontFamily: 'staatleches',
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: <Widget>[
                                      Icon(Icons.calendar_today),
                                      SizedBox(width: 8.0),
                                      Text(
                                        widget.place.openDays,
                                      ),
                                    ],
                                  ),
                                  FavoriteButton(),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(Icons.access_time),
                                  SizedBox(width: 8.0),
                                  Text(
                                    widget.place.openTime,
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(Icons.monetization_on),
                                  SizedBox(width: 8.0),
                                  Text(
                                    widget.place.ticketPrice,
                                  ),
                                ],
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16.0),
                                child: Text(
                                  widget.place.description,
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontFamily: 'Oxygen',
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DetailMobilePage extends StatelessWidget {
  final TourismPlace place;

  DetailMobilePage({required this.place});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Image.asset(place.imageAsset),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.grey,
                          child: IconButton(
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        FavoriteButton(),
                      ],
                    ),
                  ],
                ),
                Container(
                    margin: const EdgeInsets.only(top: 16.0),
                    child: Text(
                      place.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Oxygen'),
                    )),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          const Icon(Icons.calendar_today),
                          const SizedBox(height: 8.0),
                          Text(place.openDays)
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          const Icon(Icons.timelapse),
                          const SizedBox(
                            height: 8.0,
                          ),
                          Text(place.openTime)
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          const Icon(Icons.money),
                          const SizedBox(height: 8.0),
                          Text(place.ticketPrice),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 24.0, right: 24.0),
                  child: Text(
                    place.description,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ),
                SizedBox(
                  height: 200,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16.0),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: place.imageUrls.map((url) {
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16.0),
                            child: Image.network(url),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FavoriteButton extends StatefulWidget {
  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
      onPressed: () {
        setState(() {
          isFavorite = !isFavorite;
        });
      },
    );
  }
}
