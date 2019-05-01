import 'package:flutter/material.dart';
import 'video.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'video_player_class.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Video video;

  Future<Video> _loadVideo() async {
    var url = await http
        .get("http://159.89.162.108/apis/profile/00-0C-F1-56-98-AD/videos/");

    final jsonResponse = json.decode(url.body);
    video = Video.fromJson(jsonResponse);

    return video;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: FutureBuilder(
            future: _loadVideo(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return ListView.builder(
                  itemCount: video.data.length,
//                  separatorBuilder: (BuildContext context, int index) =>
//                      Divider(height: 1),
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      elevation: 3.0,
                      child: ListTile(
                        subtitle: Text(video.data[index].videoLink),
                        title: Text(video.data[index].videoName),
                        onTap: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => VideoApp(
                                      video.data[index].videoName,
                                      "http://" +
                                          video.data[index].videoLink)));
                        },
                      ),
                    );
                  },
                );
              } else {
                return CircularProgressIndicator();
              }
            }
          ),
      ),
    );
  }
}
