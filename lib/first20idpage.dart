import 'dart:convert';
import 'dart:io';

import 'package:difficultmap/detail1to20viewidpage.dart';
import 'package:difficultmap/main.dart';
import 'package:difficultmap/twentyto40datapage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

class first20idpg extends StatefulWidget {
  @override
  _first20idpgState createState() => _first20idpgState();
}

class _first20idpgState extends State<first20idpg> {
  bool loadstatus = false;

  // List<Idviewlist> viewfirst20idlist = [];
  var resultdata;
  Idviewlist? allID;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getresultdata();
  }

  getresultdata() async {
    var url = Uri.parse('https://rickandmortyapi.com/api/character');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    resultdata = jsonDecode(response.body);
    setState(() {
      allID = Idviewlist.fromJson(resultdata);
      loadstatus = true;
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
    return loadstatus
        ? Scaffold(
            appBar: AppBar(
              title: Text("Result"),
              centerTitle: true,
            ),
            body: WillPopScope(
              onWillPop: mainbackpg,
              child: ListView.builder(
                itemCount: allID!.results!.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                          return fisrt20detailview(allID!.results, index);
                        },
                      ));
                    },
                    child: Container(
                      margin: EdgeInsets.all(thebody_height * 0.01),
                      decoration: BoxDecoration(
                          color: Color(0xFFE5C8C8),
                          border: Border.all(width: 1),
                          borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(10))),
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
                                  "${allID!.results![index].image}",
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    left: thebody_height * 0.02),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "ID : ${allID!.results![index].id}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                        "Name : ${allID!.results![index].name}"),
                                    Text(
                                        "Status : ${allID!.results![index].status}"),
                                    Text(
                                        "Species : ${allID!.results![index].species}")
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            floatingActionButton: FloatingActionButton.extended(
              label: Text("Next"),
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) {
                    return twenty21to4opg();
                  },
                ));
              },
            ),
          )
        : Center(
            child: SpinKitThreeBounce(
              color: Colors.white,
            ),
          );
  }

  Future<bool> mainbackpg() {
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) {
        return homepage();
      },
    ));
    return Future.value(true);
  }
}

class Idviewlist {
  Info? info;
  List<Results>? results;

  Idviewlist({this.info, this.results});

  Idviewlist.fromJson(Map<String, dynamic> json) {
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
