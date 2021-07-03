import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  Model dataModel= Model("", "", "", "", "");
  
  getData() async{
    var response= await http.get(Uri.parse('http://website-bucket-12234.s3-website-us-east-1.amazonaws.com/api.json'));
    var jsonData= jsonDecode(response.body);

    setState(() {
      dataModel.headerTitle= jsonData['data']['title'];
      dataModel.coverImageUrl= jsonData['data']['coverUrl'];
      dataModel.imageComponentUrl= jsonData['data']['components'][0]['url'];
      dataModel.title2= jsonData['data']['components'][1]['title'];
      dataModel.description= jsonData['data']['components'][1]['desc'];
    });
  }

  var scrollController= ScrollController();
   var scrollHeight=0.0;

  @override
  void initState() {
    super.initState();
    getData();
    scrollController.addListener(onScroll);
  }

  onScroll(){
    setState(() {
      scrollHeight=scrollController.offset/9;
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Color(0XFFFADC3E),
          ),

          child: TextButton(
            child: Text("Click here", style: TextStyle(color: Colors.black),),
            onPressed: (){
              setState(() {
                scrollHeight=0;
              });
              showModalBottomSheet(context: context,isScrollControlled: true,backgroundColor: Colors.transparent,
                  builder: (_)=> Container(
                    height: MediaQuery.of(context).size.height*0.85,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50)
                          ),
                          width: 80,
                          height: 5,
                          margin: EdgeInsets.all(10),
                        ),
                        Container(
                            height: MediaQuery.of(context).size.height*0.85-25,
                            width: MediaQuery.of(context).size.width,
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                              child: Stack(
                                children: [
                                  Container(
                                    child: SingleChildScrollView(
                                      controller: scrollController,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(30),
                                        ),
                                        child: Column(
                                          children: [
                                            Stack(
                                              children: [
                                                Container(
                                                  height: MediaQuery.of(context).size.height*0.85-25,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: NetworkImage(dataModel.coverImageUrl),
                                                      fit: BoxFit.cover,
                                                    )
                                                  ),
                                                ),
                                                Positioned(
                                                    bottom: 0,
                                                    left: 0,
                                                    child: Container(
                                                      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                                                      child: Text(
                                                        dataModel.headerTitle,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 30
                                                        ),
                                                      ),
                                                    )
                                                ),
                                                Container(
                                                      margin: EdgeInsets.only(left: 35, top: 35),
                                                      padding: EdgeInsets.all(2),
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                          borderRadius: BorderRadius.circular(30)
                                                        ),
                                                        child: Icon(Icons.format_quote_rounded, color: Colors.black, size: 17,)
                                                    ),
                                              ],
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                                              color:Color(0XFFFDF7D3),
                                              width: double.maxFinite,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${dataModel.title2}\n",
                                                    style: TextStyle(
                                                      color: Colors.grey[600],
                                                      fontSize: 17
                                                    ),
                                                  ),
                                                  Text(
                                                    dataModel.description,
                                                    textAlign: TextAlign.justify,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 17,
                                                        fontWeight: FontWeight.w300,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),

                                            Container(
                                              width: double.maxFinite,
                                              height: MediaQuery.of(context).size.height*0.5,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: NetworkImage(dataModel.imageComponentUrl),
                                                  fit: BoxFit.cover
                                                )
                                              ),
                                            ),

                                            Container(
                                              decoration: BoxDecoration(
                                                color:Color(0XFFFDF7D3),
                                                borderRadius:BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
                                              ),
                                              width: double.maxFinite,
                                              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),

                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Icon(Icons.location_on,),
                                                      Text(
                                                        "Location\n",
                                                        style: TextStyle(
                                                            color: Colors.grey[600],
                                                            fontSize: 17
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                    "   Lorem Ipsum\n",
                                                    textAlign: TextAlign.justify,
                                                    style: TextStyle(
                                                      color: Colors.grey[900],
                                                      fontSize: 17,
                                                      fontWeight: FontWeight.w300,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),

                                              Container(
                                                margin: EdgeInsets.symmetric(vertical: 20),
                                                width: MediaQuery.of(context).size.width*0.8,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(50),
                                                  color: Color(0XFFFADC3E),

                                                ),

                                                child: TextButton(
                                                  child: Text("Edit", style: TextStyle(color: Colors.black),),
                                                  onPressed: (){},
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),

                                  //Custom Scroll Indicator
                                  Positioned(
                                      top: 40,
                                      right: 40,
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: MediaQuery.of(context).size.height/8.35+30,
                                            width: 6,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(50),
                                              color: Colors.grey[500],
                                            ),
                                          ),
                                          Positioned(
                                            top: 0,
                                            child:Column(
                                              children: [
                                                AnimatedBuilder(
                                                  animation: scrollController,
                                                  builder: (context, child){
                                                    return Transform.scale(
                                                        scale: 1,
                                                      child: Container(
                                                        height: scrollHeight,
                                                        width: 1,
                                                      ),
                                                    );
                                                  },
                                                ),
                                                Container(
                                                      height: 30,
                                                      width: 6,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(50),
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                  )
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  )
              );
            },
          ),
        ),
      ),
    );
  }
}

class Model{
  String headerTitle;
  String coverImageUrl;
  String title2;
  String description;
  String imageComponentUrl;


  Model(this.headerTitle, this.coverImageUrl, this.title2, this.description, this.imageComponentUrl);
}
