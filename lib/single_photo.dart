import 'package:flutter/material.dart';
import 'package:wallpaper_app_1_simple_example/models/image_model.dart';

class SinglePhoto extends StatefulWidget {
  final Photo photo;

  const SinglePhoto({Key key, this.photo}) : super(key: key);

  @override
  _SinglePhotoState createState() => _SinglePhotoState();
}

class _SinglePhotoState extends State<SinglePhoto> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.arrow_downward), onPressed: null),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration( 
              color: Colors.green,
              image: DecorationImage(
                fit: BoxFit.cover,
                image:
                NetworkImage('${widget.photo.src.portrait}',),
              ),
            ),
            
          ),
        ],
      ),
    );
  }
}

// void _saveNetworkImage() async {
//   String path = ('${photo.src.portrait}');
//   GallerySaver.saveImage(path).then((bool success) {});
// }
