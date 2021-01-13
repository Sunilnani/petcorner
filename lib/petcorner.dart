import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pet_corner/models/animals_model.dart';
import 'package:flutter_pet_corner/pet_profile.dart';
class PetCorner extends StatefulWidget {
  @override
  _PetCornerState createState() => _PetCornerState();
}

class _PetCornerState extends State<PetCorner> {
  String indx;
  Petanimals listanimals = Petanimals();
  Datum petcategory = Datum();
  bool _fetching = true;
  void getHttp() async {
    setState(() {
      _fetching = true;
    });
    try {
      Response response =
      await Dio().get("https://networkintern.herokuapp.com/api/animals");
      setState(() {
        listanimals = petanimalsFromJson(jsonEncode(response.data));
        _fetching = false;
        petcategory= listanimals.data[0];
      });
      print(response);
    } catch (e) {
      setState(() {
        _fetching = false;
      });
      print(e);
    }
  }
  int pressedButtonNo ;
  @override
  void initState() {
    getHttp();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("images/home_bg.png"), fit: BoxFit.cover)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset("images/menubar.png",height: 18,),
                        Image.asset("images/circleimage.png",height: 26,)
                      ],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      children: [
                        Text("Hello,",style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.w300),),
                        SizedBox(width: 3,),
                        Text("Anastasia",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 22),)
                      ],
                    ),
                    SizedBox(height: 10,),
                    Text("Welcome to Pet Corner",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 22),),
                    SizedBox(height: 20,),
                    Container(
                      height: 40,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Color(0xFFFFFFFF),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x38000000),
                              //spreadRadius: 1,
                              blurRadius: 6,
                              offset: Offset(0, 3),
                            )
                          ]),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 14,
                          ),
                          Image(
                            image: AssetImage("images/search.png"),
                            height: 20,
                            width: 20,
                          ),
                          SizedBox(
                            width: 14,
                          ),
                          Text(
                            "Search pet",
                            style: TextStyle(
                                color: Color(0xFFADADAD),
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 500,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30)),
                    color: Color(0xFFFFFFFF),
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal:20),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20,),
                          Text("Pet Category",style: TextStyle(color: Color(0xFF222222),fontSize: 22,fontWeight: FontWeight.w500),),
                          SizedBox(height: 10,),
                          Container(
                            color: Colors.white,
                            height: 50,
                            child:listanimals.data == null ?
                            Container(

                            ):
                            ListView.builder(
                              itemCount:listanimals.data.length,
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                Petanimals current = listanimals;
                                return InkWell(
                                  onTap: (){
                                    setState(() {
                                      indx = current.data[index].title;
                                      petcategory= listanimals.data[index];
                                      print("$petcategory");
                                    });
                                  },
                                  child: PetsCategory(
                                    name:current.data[index].title,
                                    petcategory: indx,
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 20,),
                          Container(
                            color: Colors.white,
                            child:petcategory.items == null ?
                            Container(
                            ):
                            Container(
                              height: 300,
                              child: ListView.builder(
                                itemCount:petcategory.items.length,
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  Petanimals current = listanimals;
                                  return PetsDetails(
                                    name:petcategory.items[index].title,
                                    image: petcategory.items[index].image,
                                    subtitle: petcategory.items[index].subTitle,
                                    gender: petcategory.items[index].gender,
                                    months: petcategory.items[index].months,
                                    length: petcategory.items[index].length,
                                    distance: petcategory.items[index].distance,
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xFFFFFFFF),
                      boxShadow: [BoxShadow(
                        offset: Offset(0,-2),
                        blurRadius: 6,
                        color: Color(0x333D015B),
                      )]
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 18,
                        width: 18,
                        child: Image.asset("images/home.png"),
                      ),
                      Container(
                        height: 16,
                        width: 18,
                        child: Image.asset("images/chat.png"),
                      ),
                      Container(
                        height: 30,
                        width: 30,
                        child: Image.asset("images/add.png"),
                      ),
                      Container(
                        height: 20,
                        width: 18,
                        child: Image.asset("images/calender.png"),
                      ),
                      Container(
                        height: 18,
                        width: 16,
                        child: Image.asset("images/notifications.png"),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PetsDetails extends StatefulWidget {
  const PetsDetails({
    this.name,
    this.image,
    this.gender,
    this.subtitle,
    this.months,
    this.length,
    this.distance,
    this.petname
  }) ;
  final String name;
  final String image;
  final Gender gender;
  final String subtitle;
  final int months;
  final int length;
  final int distance;
  final String petname;

  @override
  _PetsDetailsState createState() => _PetsDetailsState();
}

class _PetsDetailsState extends State<PetsDetails> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom:10.0),
      child: Container(
        height: 140,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color(0x3D015B33),
              offset: const Offset(
                0.0,
                3.0,
              ),
              blurRadius: 6.0,
            ), //BoxShadow
          ],
          color: Colors.white, borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => PetProfile(petname: widget.name,
                    ),
                  ),
                );
              },
              child: Container(
                height:140,
                width: 140,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                        image: NetworkImage(widget.image), fit: BoxFit.cover
                    ),
                    color: Colors.pinkAccent
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 15,horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.name,style: TextStyle(color: Color(0xFF3D015B),fontSize: 12,fontWeight: FontWeight.w500),),
                  SizedBox(height: 5,),
                  Text("${widget.subtitle}",style: TextStyle(color: Color(0xFF222222),fontSize: 10,fontWeight: FontWeight.w400),),
                  SizedBox(height: 5,),
                  Text("${widget.months} Months Old / ${widget.length} feet length",style: TextStyle(fontSize: 10,color: Color(0xFFADADAD)),),
                  SizedBox(height: 5,),
                  Text("${widget.gender}",style: TextStyle(color: Color(0xFF5A5A5A),fontSize: 10),),
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined,size: 14,),
                      SizedBox(width: 3,),
                      Text("${widget.distance} Miles",style: TextStyle(color: Color(0xFFADADAD),fontSize: 8),)
                    ],
                  )
                ],
              ),
            ),
            Container(
              child: Image.asset("images/next.png",height: 16,),
            )
          ],
        ),
      ),
    );
  }
}

class PetsCategory extends StatefulWidget {
  const PetsCategory({
    this.name,
    this.petcategory,
  }) ;
  final String name;
  final String petcategory;

  @override
  _PetsCategoryState createState() => _PetsCategoryState();
}

class _PetsCategoryState extends State<PetsCategory> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right:8.0,left: 2),
          child: Container(
            decoration:widget.petcategory != widget.name ? BoxDecoration(): BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Color(0xFF3D015B),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF3D015B4D),
                  offset: Offset(0,6),
                  blurRadius: 10,

                )
              ]
            ),
            height: 50,
            width: 50,
            child: Container(
                alignment: Alignment.center,
                child: Text(widget.name, style: TextStyle(color: Color(0xFF5A5A5A),fontSize: 12,fontWeight: FontWeight.w500)),),
          ),
        )
      ],
    );
  }
}