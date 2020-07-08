import 'dart:convert';
import 'package:flutter/material.dart';
//import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app_1_simple_example/models/image_model.dart';
import 'package:wallpaper_app_1_simple_example/single_photo.dart';

class DataSearch extends SearchDelegate<String> {
  List<Photo> photos = [];

  Future<List<Photo>> _getData() async {
    final response = await http.get(
        'https://api.pexels.com/v1/search/?page=1&per_page=1000&query=$query',
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

  final options = [
    'Cars',
    'Bikes',
    'Nature',
    'Sports',
    'Graduate ',
    'University',
    'College',
    'School',
    'Party',
    'Student',
    'Education',
    'Study',
    'Graduation Party ',
    'Wedding ',
    'Diploma ',
    'Graduation Cap',
    'Students ',
    'Celebration',
    'Family',
    'Business',
    'Work',
    'Success',
    'Books',
    'Travel',
    'Baby',
    'Graduation Hat',
    'High School ',
    'Friends',
    'Graduation Ceremony',
    'Learning',
    'Graduation Caps',
    'Office',
    'Money',
    'People',
    'Work From Home ',
    'Office ',
    'Desk ',
    'Living Room ',
    'Home ',
    'Laptop ',
    'Business ',
    'Remote Work ',
    'Working From Home ',
    'Home Office Background ',
    'Work ',
    'Computer ',
    'Bedroom ',
    'Wall ',
    'Room ',
    'Video Call ',
    'Technology ',
    'Kitchen ',
    'Working ',
    'Work At Home ',
    'Interior Design ',
    'Window ',
    'Office Desk',
    'Family',
    'Social Media',
    'Home Desk',
    'Background',
    'Work Home',
    'Coffee',
    'Freelancer',
    'Wine ',
    'Bar ',
    'Alcohol ',
    'Party ',
    'Craft Beer ',
    'Drink ',
    'Cocktail',
    'Food ',
    'Brewery ',
    'Coffee',
    'Cheers ',
    'Beer Bottle ',
    'Drinks ',
    'Pub ',
    'Drinking ',
    'Bear ',
    'Pizza ',
    'Whiskey ',
    'Wood ',
    'Restaurant ',
    'Beer Glass ',
    'Burger',
    'Friends ',
    'Beach ',
    'Cocktails ',
    'Christmas ',
    'Beers ',
    'Business ',
    'Whisky ',
    'Beer Friends',
    'Video Conference '
        'Laptop'
        'Video Chat '
        'Phone'
        'Computer '
        'Selfie'
        'Work From Home '
        'Home Office '
        'Meeting '
        'Phone Call '
        'Business'
        'Video Calling'
        'Working From Home '
        'Remote Work '
        'Conference Call '
        'Call '
        'Laptop Call '
        'Office'
        'Technology '
        'Video Meeting '
        'Portrait '
        'Smartphone '
        'Social Media'
        'Tablet '
        'Video '
        'Conference '
        'Online '
        'Texting '
        'Family '
        'Headset'
  ];
  final recentOptions = [
    'bike',
    'nature',
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    // actions for app bar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // leading icon on left of the app bar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // show some result on the lest of the app bar
    return FutureBuilder(
      future: _getData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return GridView.builder(
            itemCount: snapshot.data.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 0.4,
              mainAxisSpacing: 0.4,
              childAspectRatio: 0.60,
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
        }
        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Make Sure You have Internet Connection',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // shoe when someone searces for somethimg
    final suggestionList = query.isEmpty
        ? recentOptions
        : options.where((p) => p.startsWith(query)).toList();
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return buildResults(context);
            },
          ),
        ),
        leading: Icon(Icons.history),
        title: RichText(
          text: TextSpan(
            text: suggestionList[index].substring(0, query.length),
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            children: [
              TextSpan(
                text: suggestionList[index].substring(query.length),
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
      itemCount: suggestionList.length,
    );
  }
}
