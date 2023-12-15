import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'models/usermodal.dart';

class MainProfilePage extends StatefulWidget {
  const MainProfilePage({Key? key}) : super(key: key);

  @override
  State<MainProfilePage> createState() => _MainProfilePageState();
}

class _MainProfilePageState extends State<MainProfilePage> {
  @override
  Widget build(BuildContext context) {
    Future<List<UserModal>> getUserData() async {
      Response response =
      await get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
      if (response.statusCode == 200) {
        List<dynamic> data =jsonDecode(response.body);
        List<UserModal> userList=data.map((e) => UserModal.fromJson(e)).toList();
        return userList;
      } else {
        return throw "";
      }
    }

    return Scaffold(
        body: FutureBuilder(
            future: getUserData(),
            builder: (context, AsyncSnapshot <List<UserModal>> snapshot) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    if(snapshot.hasData){
                      return ListTile(
                        leading: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.lightBlue
                          ),
                        ),
                        title: Text(snapshot.data![index].name!,
                          textScaleFactor: 1.0,
                        ),
                        trailing: Text(snapshot.data![index].id!.toString()),
                      );
                    }else{
                      return Text("error");
                    }
                  });
            }));
  }
}