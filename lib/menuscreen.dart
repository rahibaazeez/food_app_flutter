import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/singlepageview.dart';
import 'package:http/http.dart';

import 'models/slidermodel.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  Future<slidermodel> getData() async {
    Response response = await get(
        Uri.parse("https://www.themealdb.com/api/json/v1/1/search.php?f=b"));
    if (response.statusCode == 200) {
      var body = slidermodel.fromJson(jsonDecode(response.body));
      return body;
    } else {
      return throw "";
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Menu"),
      ),
      body: ListView(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height,
            child: FutureBuilder<slidermodel>(
                future: getData(),
                builder: (context, AsyncSnapshot<slidermodel> snapshot) {
                  return GridView.builder(
                      itemCount:16,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      itemBuilder: (context,index){
                        if(snapshot.hasData){
                          Meals meals=snapshot.data!.meals![index];
                          return InkWell(
                            onTap: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FoodSingle(meal: meals,)));
                            },
                            child: Card(
                              color: Colors.grey.shade300,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: NetworkImage(
                                               meals!.strMealThumb!),
                                            fit: BoxFit.fitWidth)),
                                  ),
                                  Text(
                                   meals!.strMeal!,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 15),
                                  )
                                ],
                              ),
                            ),
                          );
                        }else {
                          return const Center(
                            child: Text('Something Went Wrong'),
                          );
                        }
                      });
                }),
          )
        ],
      ),

    );
  }
}
