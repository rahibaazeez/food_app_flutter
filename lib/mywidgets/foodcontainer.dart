import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class FoodView extends StatefulWidget {
  const FoodView({super.key});

  @override
  State<FoodView> createState() => _FoodViewState();
}

class _FoodViewState extends State<FoodView> {
  getData()async{
Response response=await get(Uri.parse("https://www.themealdb.com/api/json/v1/1/search.php?f=b"));
if(response.statusCode==200){
  var data=jsonDecode(response.body);
  return data;
}
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color(0xFF232227),
      body: FutureBuilder(
          future: getData(),

          builder: (BuildContext context, snapshot) {  if(snapshot.connectionState==ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if(snapshot.hasData){
            return GridView.builder(
              itemCount: 7,
              gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2 ),
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xFF232227),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          spreadRadius: 1,
                          blurRadius: 4,
                        )
                      ]),
                  child: Column(
                    children: [
                      InkWell(


                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0), // Adjust the radius as needed
                          ),

                          child: Image.network(""
                            ,
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                            ""
                        ),
                      ),


                    ],
                  ),
                );

              },);
          }else{
            return const Center(
              child: Text("Something wrong"),
            ); }}
      ),

    );
  }
}
