import 'dart:convert';

import 'package:difficultmap/first20idpage.dart';
import 'package:difficultmap/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

class twenty21to4opg extends StatefulWidget {
  @override
  _twenty21to4opgState createState() => _twenty21to4opgState();
}

class _twenty21to4opgState extends State<twenty21to4opg> {
  bool loadding = false;
  var pagedataaa;
  nextpgdata? showdata;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get21todataa();
  }

  get21todataa() async {
    var url = Uri.parse('https://rickandmortyapi.com/api/character?page=2');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    pagedataaa = jsonDecode(response.body);
    setState(() {
      showdata = nextpgdata.fromJson(pagedataaa);
      loadding = true;
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
    return loadding
        ? Scaffold(
            appBar: AppBar(
              title: Text("Result"),
              centerTitle: true,
            ),
            body: WillPopScope(
              onWillPop: firstmaininfopage,
              child: ListView.builder(
                itemCount: showdata!.results!.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(thebody_height * 0.01),
                    decoration: BoxDecoration(
                        color: Color(0xFFE5C8C8),
                        border: Border.all(width: 1),
                        borderRadius:
                            BorderRadius.horizontal(left: Radius.circular(10))),
                    height: thebody_height * 0.2,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(thebody_height * 0.01),
                              height: thebody_height * 0.15,
                              width: thewidth * 0.3,
                              child: Image.network(
                                "${showdata!.results![index].image}",
                                fit: BoxFit.contain,
                              ),
                            ),
                            Container(
                              padding:
                                  EdgeInsets.only(left: thebody_height * 0.02),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "ID : ${showdata!.results![index].id}",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                      "Name : ${showdata!.results![index].name}"),
                                  Text(
                                      "Status : ${showdata!.results![index].status}"),
                                  Text(
                                      "Species : ${showdata!.results![index].species}")
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            floatingActionButton: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton.extended(
                  tooltip: "Previous page",
                  label: Text("Prev"),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return first20idpg();
                      },
                    ));
                  },
                ),
                SizedBox(
                  width: thewidth * 0.4,
                ),
                FloatingActionButton.extended(
                  label: Text("Next"),
                  tooltip: "Next Page",
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  onPressed: () {
                    // Navigator.pushReplacement(context, MaterialPageRoute(
                    //   builder: (context) {
                    //     return twenty21to4opg();
                    //   },
                    // ));
                  },
                ),
              ],
            ),
          )
        : Center(
            child: SpinKitThreeBounce(
              color: Colors.white,
            ),
          );
  }

  Future<bool> firstmaininfopage() {
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) {
        return homepage();
      },
    ));
    return Future.value(true);
  }
}

class nextpgdata {
  Info? info;
  List<Results>? results;

  nextpgdata({this.info, this.results});

  nextpgdata.fromJson(Map<String, dynamic> json) {
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
  String? prev;

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
