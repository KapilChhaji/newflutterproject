import 'dart:convert';
import 'package:alieample2/splash.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'MyStatefulWidget.dart';
class Welcome extends StatefulWidget {
  const Welcome({Key? key, required String title}) : super(key: key);

  @override
  State<Welcome> createState() => _Welcome();
}

class _Welcome extends State<Welcome> {
  List<dynamic> users = [];
  String token="";

@override
void initState() {
    // TODO: implement initState
    super.initState();
    getCard();
    fetchUsers();

  }
  Future<void> getCard() async {
  SharedPreferences pref1= await SharedPreferences.getInstance();
  setState(() {
  token=pref1.getString("login")!;
  });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        //const SizedBox(height: 45,width: 30,),
        Text("list of Users"),
        Padding(
          padding: const EdgeInsets.only(top: 30,left: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("list of Users", style: TextStyle(fontSize: 20),
              ),
              OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                  onPressed: () async {
                    SharedPreferences pref1= await SharedPreferences.getInstance();
                    await pref1.remove("login");
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return  MyStatefulWidget();
                        },
                      ),
                      (raute) => false,
                    );
                  },
                  icon: const Icon(Icons.exit_to_app),
                  label: const Text("Logout")),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                final firstName = user['first_name'];
                final lastName = user['last_name'];
                final email = user['email'];
                final imageurl = user['avatar'];
                return ListTile(
                  //leading: Text("${index+1}"),
                  leading: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(imageurl)),
                  //child: Text('${index+1}')),
                  title: Text(firstName + " " + lastName),
                  subtitle: Text(email),
                );
              }),
        ),
      ]),
    );
  }

  Future<void> fetchUsers() async {
    print("fetchUsers called");
    const url = "https://reqres.in/api/users?page=2";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    setState(() {
      users = json['data'];
    });
    print("fatchUsers Complete");
  }
}
