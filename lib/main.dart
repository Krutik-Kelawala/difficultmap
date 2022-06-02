import 'dart:convert';

import 'package:difficultmap/first20idpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: homepage(),
  ));
}

class homepage extends StatefulWidget {
  @override
  _homepageState createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  myfirstinfodata? infodataview;
  bool loading_status = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getfirstpagedata();
  }

  getfirstpagedata() async {
    var url = Uri.parse('https://rickandmortyapi.com/api/character');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    var firstpageviewdata = jsonDecode(response.body);

    setState(() {
      infodataview = myfirstinfodata.fromJson(firstpageviewdata);
      loading_status = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    double theheight = MediaQuery.of(context).size.height;
    double thewidth = MediaQuery.of(context).size.width;
    double thestatusbar = MediaQuery.of(context).padding.top;
    double thenavigatorbar = MediaQuery.of(context).padding.bottom;
    double theappbar = kToolbarHeight;
    double thebody_height =
        theheight - thestatusbar - theappbar - thenavigatorbar;

    return loading_status
        ? Scaffold(
            appBar: AppBar(
              title: Text("Homepage"),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: thebody_height * 0.5,
                    width: double.infinity,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.greenAccent,
                              offset: Offset(3, 4),
                              blurRadius: 5,
                              blurStyle: BlurStyle.inner,
                              spreadRadius: 2)
                        ],
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(width: 1),
                        gradient: LinearGradient(colors: [
                          Colors.orangeAccent,
                          Colors.yellowAccent
                        ])),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Count : ${infodataview!.info!.count}",
                          style: TextStyle(fontSize: thebody_height * 0.05),
                        ),
                        SizedBox(
                          height: thebody_height * 0.05,
                        ),
                        Divider(
                          height: 5,
                          thickness: 3,
                          endIndent: 30,
                          indent: 30,
                        ),
                        SizedBox(
                          height: thebody_height * 0.05,
                        ),
                        Text(
                          "Pages : ${infodataview!.info!.pages}",
                          style: TextStyle(fontSize: thebody_height * 0.05),
                        )
                      ],
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) {
                            return first20idpg();
                          },
                        ));
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 5,
                          shadowColor: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: Text("Start now")),
                ],
              ),
            ),
          )
        : Center(
            child: SpinKitChasingDots(
              color: Colors.white,
              size: 50,
            ),
          );
  }
}

class myfirstinfodata {
  Info? info;
  List<Results>? results;

  myfirstinfodata({this.info, this.results});

  myfirstinfodata.fromJson(Map<String, dynamic> json) {
    info = json['info'] != null ? new Info.fromJson(json['info']) : null;
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.info != null) {
      data['info'] = this.info!.toJson();
    }
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Info {
  int? count;
  int? pages;
  String? next;
  Null? prev;

  Info({this.count, this.pages, this.next, this.prev});

  Info.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    pages = json['pages'];
    next = json['next'];
    prev = json['prev'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['pages'] = this.pages;
    data['next'] = this.next;
    data['prev'] = this.prev;
    return data;
  }
}

class Results {
  int? id;
  String? name;
  String? status;
  String? species;
  String? type;
  String? gender;
  Origin? origin;
  Origin? location;
  String? image;
  List<String>? episode;
  String? url;
  String? created;

  Results(
      {this.id,
      this.name,
      this.status,
      this.species,
      this.type,
      this.gender,
      this.origin,
      this.location,
      this.image,
      this.episode,
      this.url,
      this.created});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    species = json['species'];
    type = json['type'];
    gender = json['gender'];
    origin =
        json['origin'] != null ? new Origin.fromJson(json['origin']) : null;
    location =
        json['location'] != null ? new Origin.fromJson(json['location']) : null;
    image = json['image'];
    episode = json['episode'].cast<String>();
    url = json['url'];
    created = json['created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['status'] = this.status;
    data['species'] = this.species;
    data['type'] = this.type;
    data['gender'] = this.gender;
    if (this.origin != null) {
      data['origin'] = this.origin!.toJson();
    }
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['image'] = this.image;
    data['episode'] = this.episode;
    data['url'] = this.url;
    data['created'] = this.created;
    return data;
  }
}

class Origin {
  String? name;
  String? url;

  Origin({this.name, this.url});

  Origin.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['url'] = this.url;
    return data;
  }
}
