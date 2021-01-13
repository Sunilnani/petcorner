import 'package:flutter/material.dart';
import 'package:flutter_pet_corner/petcorner.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                      height: 440,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(35),
                              bottomRight: Radius.circular(35)
                          ),
                          image: DecorationImage(
                              image: AssetImage("images/petcorner.png"), fit: BoxFit.cover)
                      )),
                  SizedBox(height: 50,),
                  Text("Make a new Friend",style: TextStyle(color: Color(0xFF3D015B),fontSize: 24,fontWeight: FontWeight.bold),),
                  SizedBox(height: 20,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Center(child: Text("Find the best pet in your location and get them in your arms",textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w400),))),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:40.0),
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color(0xFF3D015B), borderRadius: BorderRadius.circular(30),
                      ),
                      child: FlatButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => PetCorner(
                              ),
                            ),
                          );
                        },
                        child: Stack(
                          children: <Widget>[
                            Container(
                              height: 50,
                              width: 260,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(30),
                                color: Color(0xFF3D015B),
                              ),
                              child: Center(
                                child:  Text(
                                  "LET'S GO",
                                  style: TextStyle(
                                      color: Color(0xFFFFFFFF),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),

                              ),
                            ),

                            Positioned(
                             top: 4,bottom: 4,right: 1,
                              child: Container(
                                height: 42,
                                width: 42,
                                decoration: BoxDecoration(
                                  image: DecorationImage(image: AssetImage("images/right_arrow.png")),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                    ),
                  ),
                ],
              ),
            ),
          ),
      ),
    );
  }
}
