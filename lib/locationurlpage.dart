import 'dart:convert';

import 'package:difficultmap/first20idpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

class locationpage extends StatefulWidget {
  @override
  _locationpageState createState() => _locationpageState();
}

class _locationpageState extends State<locationpage> {
  var locationdata;
  locationmy? lurl;
  bool screestatusload = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getloctionurl();
  }

  getloctionurl() async {
    var url = Uri.parse('https://rickandmortyapi.com/api/location/3');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    locationdata = jsonDecode(response.body);
    setState(() {
      lurl = locationmy.fromJson(locationdata);
      screestatusload = true;
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
    return screestatusload
        ? Scaffold(
            appBar: AppBar(
              title: Text("${lurl!.name}"),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: WillPopScope(
                onWillPop: mainpgback,
                child: Container(
                  padding: EdgeInsets.all(thebody_height * 0.01),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            child: Text(
                              "ID : ",
                              style: TextStyle(
                                  fontSize: thebody_height * 0.02,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            child: Text(
                              "${lurl!.id}",
                              style: TextStyle(
                                  fontSize: thebody_height * 0.02,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            child: Text(
                              "Name : ",
                              style: TextStyle(
                                  fontSize: thebody_height * 0.02,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            child: Text(
                              "${lurl!.name}",
                              style: TextStyle(
                                fontSize: thebody_height * 0.02,
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            child: Text(
                              "Type : ",
                              style: TextStyle(
                                  fontSize: thebody_height * 0.02,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            child: Text(
                              "${lurl!.type}",
                              style: TextStyle(
                                fontSize: thebody_height * 0.02,
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            child: Text(
                              "Dimension : ",
                              style: TextStyle(
                                  fontSize: thebody_height * 0.02,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            child: Text(
                              "${lurl!.dimension}",
                              style: TextStyle(
                                fontSize: thebody_height * 0.02,
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            child: Text(
                              "Url : ",
                              style: TextStyle(
                                  fontSize: thebody_height * 0.02,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            child: InkWell(
                              onTap: () {
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(
                                  builder: (context) {
                                    return locationpage();
                                  },
                                ));
                              },
                              child: Text(
                                "${lurl!.url}",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: thebody_height * 0.02,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            child: Text(
                              "Created : ",
                              style: TextStyle(
                                  fontSize: thebody_height * 0.02,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            child: Text(
                              "${lurl!.created}",
                              style: TextStyle(
                                fontSize: thebody_height * 0.02,
                              ),
                            ),
                          )
                        ],
                      ),
                      Container(
                        child: Text(
                          "Residents : ",
                          style: TextStyle(
                              fontSize: thebody_height * 0.02,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        height: thebody_height,
                        child: ListView.builder(
                          itemCount: lurl!.residents!.length,
                          itemBuilder: (context, index) {
                            return Container(
                              // height: thebody_height * 0.5,
                              // width: double.infinity,
                              padding: EdgeInsets.all(thebody_height * 0.01),
                              child: Center(
                                child: Text(
                                  "\n${lurl!.residents![index]}",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: thebody_height * 0.02),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        : Center(
            child: SpinKitThreeBounce(
            color: Colors.white,
          ));
  }

  Future<bool> mainpgback() {
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) {
        return first20idpg();
      },
    ));
    return Future.value(true);
  }
}

class locationmy {
  int? id;
  String? name;
  String? type;
  String? dimension;
  List<String>? residents;
  String? url;
  String? created;

  locationmy(
      {this.id,
      this.name,
      this.type,
      this.dimension,
      this.residents,
      this.url,
      this.created});

  locationmy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    dimension = json['dimension'];
    residents = json['residents'].cast<String>();
    url = json['url'];
    created = json['created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    data['dimension'] = this.dimension;
    data['residents'] = this.residents;
    data['url'] = this.url;
    data['created'] = this.created;
    return data;
  }
}
