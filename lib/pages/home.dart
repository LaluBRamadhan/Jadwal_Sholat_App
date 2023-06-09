import 'package:flutter/material.dart';
import '../main.dart';
//import '../models/user_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart' as intl;

String getDate() {
  DateTime now = DateTime.now();
  String formattedDate = intl.DateFormat('yyyy-MM-dd').format(now);
  return formattedDate;
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String currentDate = getDate();

  late String subuh;
  late String dzuhur;
  late String ashar;
  late String maghrib;
  late String isya;

  late String tanggal;
  @override
  void initState() {
    subuh = "";
    dzuhur = "";
    ashar = "";
    maghrib = "";
    isya = "";

    tanggal = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Jadwal Solat $tanggal",
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Text("subuh : $subuh",
              style: const TextStyle(
                fontSize: 20,
              )),
          Text("dzuhur : $dzuhur",
              style: const TextStyle(
                fontSize: 20,
              )),
          Text("ashar : $ashar",
              style: const TextStyle(
                fontSize: 20,
              )),
          Text("maghrib : $maghrib",
              style: const TextStyle(
                fontSize: 20,
              )),
          Text("isya : $isya",
              style: const TextStyle(
                fontSize: 20,
              )),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal[300],
                ),
                  onPressed: () async {
                    var myResponse = await http.get(Uri.parse(
                        "https://api.banghasan.com/sholat/format/json/jadwal/kota/703/tanggal/$currentDate"));
                    if (myResponse.statusCode == 200) {
                      //print("Connected");
                      Map<String, dynamic> data =
                          json.decode(myResponse.body) as Map<String, dynamic>;
                      //print(data["hasil"]);
                      //print(currentDate);
                      setState(() {
                        tanggal = data['jadwal']['data']['tanggal'].toString();
                        subuh = data['jadwal']['data']['subuh'].toString();
                        dzuhur = data['jadwal']['data']['dzuhur'].toString();
                        ashar = data['jadwal']['data']['ashar'].toString();
                        maghrib = data['jadwal']['data']['maghrib'].toString();
                        isya = data['jadwal']['data']['isya'].toString();
                      });
                    } else {
                      //something in the future
                    }
                  },
                  child: const Text("Refresh")),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal[300],
                ),
                  onPressed: () {
                    Navigator.of(context).pop(MaterialPageRoute(
                      builder: (context) => const Homepage(),
                    ));
                  },
                  child: const Text("Back")),
            ],
          )
        ],
      )),
    );
  }
}
