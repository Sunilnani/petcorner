import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pet_corner/models/single_pet_model.dart';

class PetProfile extends StatefulWidget {
  PetProfile({this.petname});
  final  String petname ;
  @override
  _PetProfileState createState() => _PetProfileState();
}

class _PetProfileState extends State<PetProfile> {
  SinglePet listTodos = SinglePet();
  bool fetching = true;
  void getHttp() async {
    setState(() {
      fetching = true;
    });
    try {
      Response response =
      await Dio().get("https://networkintern.herokuapp.com/api/animal?name=${widget.petname}");
      setState(() {
        listTodos = singlePetFromJson(jsonEncode(response.data)) ;
        fetching = false;
        print(response);
      });
    } catch (e) {
      setState(() {
        fetching = false;
      });
      print(e);
    }
  }

  @override
  void initState() {
    getHttp();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    if (fetching) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    if (listTodos.image.length == 0) {
      return Center(
        child: Text("No Data"),
      );
    }
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 25),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 23, vertical: 29),
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
                image: DecorationImage(
                    image: NetworkImage("https://source.unsplash.com/1000x1000/?cat,Lilly"),fit: BoxFit.cover
                ),
                color: Colors.red,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Image.asset("images/back.png",height: 18,),
                      ),
                      Container(
                        child: Image.asset("images/circleimage.png",height: 26,),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(listTodos.title,
                        style: TextStyle(
                            color: Color(0xFF3D015B),
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Image.asset("images/location.png",height: 22,),
                          SizedBox(width: 5,),
                          Text("${listTodos.distance} Miles",style: TextStyle(color: Color(0xFFADADAD),fontSize: 12),)
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(listTodos.subTitle, style: TextStyle(color: Color(0xFF222222), fontSize: 16, fontWeight: FontWeight.w500),),
                  SizedBox(
                    height: 8,
                  ),
                  Text(listTodos.gender, style: TextStyle(color: Color(0xFF5A5A5A), fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(
                          border:
                          Border.all(color: Color(0xFFCCCCCC), width: 1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text("Age: ${listTodos.months} Months", style: TextStyle(color: Color(0xFF222222), fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),

                      Container(
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xFFCCCCCC), width: 1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text("Length: ${listTodos.length} feet",style: TextStyle(color: Color(0xFF222222), fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),

                      Container(
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(
                          border:
                          Border.all(color: Color(0xFFCCCCCC), width: 1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text("Color: ${listTodos.color}", style: TextStyle(color: Color(0xFF222222), fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 19,
                  ),
                  Text("Description", style: TextStyle(color: Color(0xFF222222), fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 11,
                  ),
                  Text(listTodos.description,
                    style: TextStyle(
                        color: Color(0xFF5A5A5A),
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 35,
            ),
            Container(
              width: 200,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Color(0xFF3D015B),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 6),
                      blurRadius: 12,
                      color: Color(0x4D3D015B),
                    )
                  ]),
              child: Center(
                child: Text(
                  "ADOPT",
                  style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}