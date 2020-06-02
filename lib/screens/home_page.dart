import 'package:flutter/material.dart';
import 'package:wallpaper_app_1_simple_example/model/images.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomrPage extends StatefulWidget {
  @override
  _HomrPageState createState() => _HomrPageState();
}

class _HomrPageState extends State<HomrPage> {
  List<Images> images = [];

  Future<List<Images>> _getData() async {
    final response = await http
        .get('https://api.pexels.com/v1/curated?per_page=15&page=1', headers: {
      'Authorization':
          '563492ad6f917000010000016dece1882a1f42d69c85b39eebf222b7'
    });
    if (response.statusCode == 200) {
        List parsed = jsonDecode(response.body);
        print("object=======================================");
        print(parsed);

        return parsed.map((img) => Images.fromJson(img)).toList();
      }
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WallPaper App"),
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.teal, Colors.purple])),
        child: FutureBuilder(
          future: _getData(),
          builder: (context, snapshot) {
            return GridView.builder(
             
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 3,
                mainAxisSpacing: 3,
                childAspectRatio: 0.5,
              ),
              itemBuilder: (context, index) {
                return Container(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed('ImagePage');
                    },
                    child: Container(
                      color: Colors.black,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              '${snapshot.data[index].url}'),
                        ),
                      ),
                    ),
                  ),
                );
                // Card(
                //   margin: EdgeInsets.all(10),
                //   child: Container(
                //     padding: EdgeInsets.all(10),
                //     child: Column(children: <Widget>[
                //       Text("${snapshot.data[index].departmentname}"),
                //       Text('${snapshot.data[index].employerName}'),
                //       Text("Employer Id: ${snapshot.data[index].employerId}"),
                //       Text("Salary: ${snapshot.data[index].employersalary}"),
                //     ]),
                //   ),
                // );
              },
            );
          },
        ),
      ),
    );
  }
}
