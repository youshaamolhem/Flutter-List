import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:galerry_trying/jsonServices.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:galerry_trying/screens/detailScreen.dart';
import 'package:google_fonts/google_fonts.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen[600],
        title: Text(
          'Choose your favorite image :)',
          style: TextStyle(
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
      body: FutureBuilder<List<Photo>>(
        future: fetchPhotos(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? PhotosList(photos: snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class PhotosList extends StatelessWidget {
  final List<Photo> photos;

  PhotosList({Key key, this.photos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: photos.length,
      itemBuilder: (context, index) {
        String _url = photos[index].thumbnailUrl;
        String authorName = photos[index].name;

        return Container(
            height: 150,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withAlpha(100), blurRadius: 10.0),
                ]),
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '$authorName',
                        style: GoogleFonts.dancingScript(shadows: [
                          BoxShadow(color: Colors.black45, blurRadius: 4.0),
                        ], fontSize: 18.0),
                        maxLines: 2,
                      ),
                      GestureDetector(
                        child: Hero(
                          tag: 'imageHero$index',
                          child: CachedNetworkImage(
                            imageUrl: _url,
                            imageBuilder: (context, imageProvider) => Container(
                              width: 120.0,
                              height: 120.0,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withAlpha(100),
                                      blurRadius: 20.0),
                                ],
                                borderRadius: BorderRadius.circular(10.0),
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover),
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return DetailScreen(
                              imageurl: _url,
                              indexx: index,
                            );
                          }));
                        },
                      )
                    ])));
      },
    );
  }
}
