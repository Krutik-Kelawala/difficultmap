import 'dart:convert';

import 'package:difficultmap/first20idpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

class urlpage extends StatefulWidget {
  @override
  _urlpageState createState() => _urlpageState();
}

class _urlpageState extends State<urlpage> {
  var urldatadecode;
  urlclassdala? viewwurl;
  bool loadviewscreen = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    originurldata();
  }

  originurldata() async {
    var url = Uri.parse('https://rickandmortyapi.com/api/location/1');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    urldatadecode = jsonDecode(response.body);
    setState(() {
      viewwurl = urlclassdala.fromJson(urldatadecode);
      loadviewscreen = true;
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
    return loadviewscreen
        ? Scaffold(
            appBar: AppBar(
              title: Text("${viewwurl!.name}"),
              centerTitle: true,
            ),
            body: WillPopScope(
              onWillPop: viewdetailpgback,
              child: Container(
                padding: EdgeInsets.all(thebody_height * 0.01),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          "Id : ${viewwurl!.id}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: thebody_height * 0.02),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            child: Text(
                              "Name : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: thebody_height * 0.02),
                            ),
                          ),
                          Container(
                            child: Text(
                              "${viewwurl!.name}",
                              style: TextStyle(fontSize: thebody_height * 0.02),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            child: Text(
                              "Dimension : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: thebody_height * 0.02),
                            ),
                          ),
                          Container(
                            child: Text(
                              "${viewwurl!.dimension}",
                              style: TextStyle(fontSize: thebody_height * 0.02),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                              child: FlatButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10))),
                                      context: context,
                                      builder: (context) {
                                        return Column(
                                          children: [
                                            SizedBox(
                                              height: thebody_height * 0.03,
                                            ),
                                            Divider(
                                              height: thebody_height * 0.03,
                                              color: Colors.grey,
                                              thickness: 5,
                                              endIndent: 180,
                                              indent: 180,
                                            ),
                                            Container(
                                              height: thebody_height * 0.5,
                                              child: ListView.builder(
                                                shrinkWrap: true,
                                                itemCount:
                                                    viewwurl!.residents!.length,
                                                itemBuilder: (context, index) {
                                                  return Container(
                                                    padding: EdgeInsets.only(
                                                        left: thebody_height *
                                                            0.01,
                                                        top: thebody_height *
                                                            0.01,
                                                        right: thebody_height *
                                                            0.01),
                                                    child: Center(
                                                      child: Text(
                                                        "${viewwurl!.residents![index]}",
                                                        style: TextStyle(
                                                            fontSize:
                                                                thebody_height *
                                                                    0.02,
                                                            color: Colors.blue),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: Text(
                                    "Residents",
                                    style: TextStyle(
                                        fontSize: thebody_height * 0.02,
                                        fontWeight: FontWeight.bold),
                                  ))),
                          Container(
                            child: Text(
                              "Click to open links",
                              style: TextStyle(
                                  fontSize: thebody_height * 0.02,
                                  color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            child: Text(
                              "Url : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: thebody_height * 0.02),
                            ),
                          ),
                          Container(
                            child: InkWell(
                              onTap: () {
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(
                                  builder: (context) {
                                    return urlpage();
                                  },
                                ));
                              },
                              child: Text(
                                "${viewwurl!.url}",
                                style: TextStyle(
                                    fontSize: thebody_height * 0.02,
                                    color: Colors.blue),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            child: Text(
                              "Created : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: thebody_height * 0.02),
                            ),
                          ),
                          Container(
                            child: Text(
                              "${viewwurl!.created}",
                              style: TextStyle(fontSize: thebody_height * 0.02),
                            ),
                          ),
                        ],
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
            ),
          );
  }

  Future<bool> viewdetailpgback() {
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) {
        return first20idpg();
      },
    ));
    return Future.value(true);
  }
}

class urlclassdala {
  int? id;
  String? name;
  String? type;
  String? dimension;
  List<String>? residents;
  String? url;
  String? created;

  urlclassdala(
      {this.id,
      this.name,
      this.type,
      this.dimension,
      this.residents,
      this.url,
      this.created});

  urlclassdala.fromJson(Map<String, dynamic> json) {
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
