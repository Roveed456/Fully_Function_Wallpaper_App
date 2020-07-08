import 'dart:convert';
import 'package:flutter/material.dart';
//import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app_1_simple_example/models/data_search.dart';
import 'package:wallpaper_app_1_simple_example/models/image_model.dart';
import 'single_photo.dart';

class PhotosHome extends StatefulWidget {
  //final Photo photo;

  @override
  _PhotosHomeState createState() => _PhotosHomeState();
}

class _PhotosHomeState extends State<PhotosHome> {
  int _counterone = 1;

  void _nestpage() {
    setState(
      () {
        _counterone++;
      },
    );
  }

  void _backpage() {
    setState(
      () {
        _counterone--;
      },
    );
  }

  List<Photo> photos = [];

  Future<List<Photo>> _getData() async {
    final response = await http.get(
        'https://api.pexels.com/v1/search/?page=$_counterone&per_page=1000&query=Photography Topics',
        headers: {
          'Authorization':
              '563492ad6f917000010000016dece1882a1f42d69c85b39eebf222b7'
        });

    if (response.statusCode == 200) {
      var parsed = jsonDecode(response.body);

      photos =
          (parsed['photos'] as List).map((img) => Photo.fromJson(img)).toList();
    }
    print(photos);
    return photos;
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //bottomSheet: Scaffold(),
      backgroundColor: Colors.teal[100],
      bottomNavigationBar: BottomAppBar(color: Colors.blueGrey,
        child: Row(       
          children: <Widget>[
            RaisedButton(
                shape: CircleBorder(),
                color: Colors.transparent,
                onPressed: _backpage,
                child: Icon(Icons.keyboard_arrow_left)),
            RaisedButton(
                shape: CircleBorder(),
                color: Colors.transparent,
                onPressed: _nestpage,
                child: Icon(Icons.keyboard_arrow_right)),
            SizedBox(
              width: 20,
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: DataSearch());
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("Choice WallPaper"),
        actions: <Widget>[],
      ),
      body: FutureBuilder(
        future: _getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return  GridView.builder(
                itemCount: snapshot.data.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 0.4,
                  mainAxisSpacing: 0.4,childAspectRatio: 0.60,
                ),
                itemBuilder: (BuildContext context, int index) => InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SinglePhoto(photo: snapshot.data[index]);
                    },
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(                    
                    color: Colors.green,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        '${snapshot.data[index].src.tiny}',
                      ),
                    ),
                  ),
                 
                ),
              ),
                );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}



