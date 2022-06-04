import 'dart:convert';

import 'package:difficultmap/first20idpage.dart';
import 'package:difficultmap/locationurlpage.dart';
import 'package:difficultmap/originurlpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

class fisrt20detailview extends StatefulWidget {
  List<Results>? results;
  int index;

  fisrt20detailview(this.results, this.index);

  @override
  _fisrt20detailviewState createState() => _fisrt20detailviewState();
}

class _fisrt20detailviewState extends State<fisrt20detailview> {
  // detailscreen? screen;
  bool loadestatus = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getalldata();
  }

  getalldata() async {
    // var url = Uri.parse(widget.results.toString());
    // var response = await http.get(url);
    // print('Response status: ${response.statusCode}');
    // print('Response body: ${response.body}');

    for (int i = 0; i < widget.results!.length; i++) {
      print("${widget.results![i].status}");
    }
    setState(() {
      loadestatus = true;
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
    return loadestatus
        ? Scaffold(
            appBar: AppBar(
              title: Text("${widget.results![widget.index].name}"),
              centerTitle: true,
            ),
            body: WillPopScope(
              onWillPop: beforepg,
              child: SingleChildScrollView(
                  child: Container(
                      padding: EdgeInsets.all(thebody_height * 0.01),
                      // margin: EdgeInsets.all(10),
                      height: thebody_height,
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              height: thebody_height * 0.5,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  border: Border.all(width: 1),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          "${widget.results![widget.index].image}"),
                                      fit: BoxFit.fill)),
                            ),
                          ),
                          SizedBox(
                            height: thebody_height * 0.05,
                          ),
                          RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: "Id : ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: thebody_height * 0.02,
                                    color: Colors.black)),
                            TextSpan(
                                text: "${widget.results![widget.index].id}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: thebody_height * 0.02,
                                    color: Colors.black)),
                            TextSpan(
                                text: "\nName : ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: thebody_height * 0.02,
                                    color: Colors.black)),
                            TextSpan(
                                text: "${widget.results![widget.index].name}",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: thebody_height * 0.02,
                                )),
                            TextSpan(
                                text: "\nStatus : ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: thebody_height * 0.02,
                                    color: Colors.black)),
                            TextSpan(
                                text: "${widget.results![widget.index].status}",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: thebody_height * 0.02,
                                )),
                            TextSpan(
                                text: "\nSpecies : ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: thebody_height * 0.02,
                                    color: Colors.black)),
                            TextSpan(
                                text:
                                    "${widget.results![widget.index].species}",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: thebody_height * 0.02,
                                )),
                            TextSpan(
                                text: "\nType : ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: thebody_height * 0.02,
                                    color: Colors.black)),
                            TextSpan(
                                text: "${widget.results![widget.index].type}",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: thebody_height * 0.02,
                                )),
                            TextSpan(
                                text: "\nGender : ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: thebody_height * 0.02,
                                    color: Colors.black)),
                            TextSpan(
                                text: "${widget.results![widget.index].gender}",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: thebody_height * 0.02,
                                )),
                          ])),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  "Origin : ",
                                  style: TextStyle(
                                      fontSize: thebody_height * 0.02,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    child: Text(
                                      "\t\tName : ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: thebody_height * 0.02),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "${widget.results![widget.index].origin!.name}",
                                      style: TextStyle(
                                          fontSize: thebody_height * 0.02),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    child: Text(
                                      "\t\tUrl : ",
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
                                        "${widget.results![widget.index].origin!.url}",
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: thebody_height * 0.02),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Container(
                                child: Text(
                                  "Location : ",
                                  style: TextStyle(
                                      fontSize: thebody_height * 0.02,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    child: Text(
                                      "\t\tName : ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: thebody_height * 0.02),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "${widget.results![widget.index].location!.name}",
                                      style: TextStyle(
                                          fontSize: thebody_height * 0.02),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    child: Text(
                                      "\t\tUrl : ",
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
                                            return locationpage();
                                          },
                                        ));
                                      },
                                      child: Text(
                                        "${widget.results![widget.index].location!.url}",
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: thebody_height * 0.02),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    child: Text(
                                      "Episode : ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: thebody_height * 0.02),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      showModalBottomSheet(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(20),
                                                topLeft: Radius.circular(20))),
                                        context: context,
                                        builder: (context) {
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                height: thebody_height * 0.01,
                                              ),
                                              Divider(
                                                height: thebody_height * 0.01,
                                                thickness: 5,
                                                endIndent: 180,
                                                color: Colors.grey,
                                                indent: 180,
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(
                                                    thebody_height * 0.01),
                                                height: thebody_height * 0.6,
                                                width: double.infinity,
                                                child: ListView.builder(
                                                  shrinkWrap: true,
                                                  itemCount: widget
                                                      .results![widget.index]
                                                      .episode!
                                                      .length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Container(
                                                      padding: EdgeInsets.all(
                                                          thebody_height *
                                                              0.01),
                                                      child: Center(
                                                        child: Text(
                                                          "${widget.results![widget.index].episode![index]}",
                                                          style: TextStyle(
                                                              fontSize:
                                                                  thebody_height *
                                                                      0.02,
                                                              color:
                                                                  Colors.blue),
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
                                    child: Container(
                                      child: Text(
                                        "Tap to see all episode link",
                                        style: TextStyle(
                                            fontSize: thebody_height * 0.02,
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold),
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
                                          fontWeight: FontWeight.bold,
                                          fontSize: thebody_height * 0.02),
                                    ),
                                  ),
                                  Container(
                                    child: InkWell(
                                      onTap: () {},
                                      child: Text(
                                        "${widget.results![widget.index].url}",
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: thebody_height * 0.02),
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
                                      "${widget.results![widget.index].created}",
                                      style: TextStyle(
                                          fontSize: thebody_height * 0.02),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ))),
            ))
        : Center(
            child: SpinKitThreeBounce(
            color: Colors.white,
          ));
  }

  Future<bool> beforepg() {
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) {
        return first20idpg();
      },
    ));
    return Future.value(true);
  }
}
