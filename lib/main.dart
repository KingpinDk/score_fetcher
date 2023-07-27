import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:score_fetcher/globals.dart';
import 'package:score_fetcher/my_button.dart';
import 'package:score_fetcher/my_textfield.dart';
import 'package:http/http.dart' as http;
import 'package:score_fetcher/score_model.dart';
void main() {
  runApp(const Home());
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var name = "";
  final _messangerKey = GlobalKey<ScaffoldMessengerState>();
  @override
  Widget build(BuildContext context) {
    TextEditingController userName = TextEditingController();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: _messangerKey,
      title: "Score fetcher",
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Score Fetcher",
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              color: Colors.white70
            ),
          ),
          backgroundColor: Colors.green,
        ),
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  MyTextField(
                      controller: userName,
                      hintText: "User Name type pannugo",
                      obscureText: false),
                  SizedBox(height: 20.0,),
                  MyButton(
                      onTap: ()async{
                        listBadges.clear();
                        await assignData(userName.text);
                        setState(() {name = userName.text.toString();});
                        },
                      text: "Fetch Score"),
                  SizedBox(height: 20.0,),
                  (name != "")?Text("User Name: $name"):Text(""),
                  SizedBox(height: 20,),
                  (listBadges.isEmpty)?Text(""):
                  Expanded(
                        child: ListView.builder(
                          itemCount: listBadges.length,
                            itemBuilder: (context,index){
                              return Card(
                                child: ListTile(
                                  title: Text(listBadges[index].progLanguage ?? "not found"),
                                  subtitle: Text("${listBadges[index].badge}"),
                                  trailing: Column(
                                    children: [
                                      Text("Stars Earned: ${listBadges[index].stars}"),
                                      Text("Points Scored: ${listBadges[index].points}"),
                                      Text("Problems Solved: ${listBadges[index].solved}")
                                    ],
                                  ),
                                ),
                                color: (listBadges[index].badge == "Bronze")?Color.fromRGBO(205, 127, 50, 1.0):(listBadges[index].badge == "Silver")?Color.fromRGBO(192, 192, 192, 1.0):Color.fromRGBO(255, 215, 0, 1.0),
                              );
                            }
                        ),
                      )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  assignData(String id) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if(connectivityResult == ConnectivityResult.none){
      _messangerKey.currentState?.showSnackBar(const SnackBar(content: Text("Thambi modhala net on pannuga")));
    }
    else if(id.isEmpty) {
        _messangerKey.currentState?.showSnackBar(const SnackBar(content: Text("modhala username type pannuga sir")));
      }
    else{
      var request = http.Request('GET', Uri.parse('https://www.hackerrank.com/rest/hackers/$id/badges'));

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      final body = response.body;
      final json = jsonDecode(body);

      if (response.statusCode == 200) {
        var c =  ScoreModel.fromJson(json);
        if(c.models!.isEmpty){
          _messangerKey.currentState?.showSnackBar(const SnackBar(content: Text("You don't even have a single badge!!!")));
        }
        else {
            for(int i = 0; i < c.models!.length; i++){
              var stars = c.models?[i].stars;
              var points = c.models?[i].currentPoints;
              var progLanguage = c.models?[i].badgeName;
              var solved = c.models?[i].solved;
              if(stars! <= 2) {
                listBadges.add(Badges(badge:"Bronze" , points: points, progLanguage: progLanguage, solved: solved, stars: stars));
              }
              else if(stars <= 4) {
                listBadges.add(Badges(badge:"Silver" , points: points, progLanguage: progLanguage, solved: solved, stars: stars));
              }
              else if(stars <= 6) {
                listBadges.add(Badges(badge:"Gold" , points: points, progLanguage: progLanguage, solved: solved, stars: stars));
              }
            }
          }
      }
      else {
        _messangerKey.currentState?.showSnackBar(const SnackBar(content: Text("Something went wrong seek kingpin_dk's help"),));

      }
    }
  }
}

class Badges{
  late String? badge;
  late String? progLanguage;
  late int? stars;
  late int? solved;
  late double? points;
  Badges({required this.badge, required this.points, required this.progLanguage, required this.solved, required this.stars});
}