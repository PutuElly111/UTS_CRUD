import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DataTampil extends StatefulWidget {
  const DataTampil({
    Key key,
  }) : super(key: key);
  @override
  _DataTampilState createState() => _DataTampilState();
}

class _DataTampilState extends State<DataTampil> {
  final String url = "http://192.168.1.24:80/api/inputs";
  Future getinput() async {
    var response = await http.get(Uri.parse(url));
    print(jsonDecode(response.body));
    return jsonDecode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data pelanggang"),
      ),
      body: Container(
        width: double.maxFinite,
        margin: EdgeInsets.all(5),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              FutureBuilder(
                  future: getinput(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data['data'].length,
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemBuilder: (context, index) {
                            Container(
                                height: 150,
                                child: Card(
                                  elevation: 8,
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Text("Nama Sepatu"),
                                          Text(snapshot.data['data'][index]
                                              ['namaSepatu'])
                                        ],
                                      )
                                    ],
                                  ),
                                ));
                          });
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
