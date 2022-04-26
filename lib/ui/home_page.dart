// ignore_for_file: unused_local_variable, prefer_final_fields, unnecessary_null_comparison, curly_braces_in_flow_control_structures, unused_element, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String _search;
  int _offset = 0;
  Future<Map> _getGifs() async {
    http.Response response;

    if (_search == null) {
      response = await http.get(Uri.parse(
          'https://api.giphy.com/v1/gifs/trending?api_key=e4pRGOj3PHOAwH0rwYtIzKjY8tm1xOOI&limit=20&rating=g'));
    } else
      response = await http.get(Uri.parse(
          'https://api.giphy.com/v1/gifs/search?api_key=e4pRGOj3PHOAwH0rwYtIzKjY8tm1xOOI&q=$_search&limit=20&offset=$_offset&rating=g&lang=en'));
    return json.decode(response.body);
  }

  @override
  void initState() {
    super.initState();
    _getGifs().then((map) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Image.network(
              "https://media.giphy.com/headers/2021-04-23-04-1619150653/OSCARS_BANNER_HP-2021.gif"),
          centerTitle: true,
        ),
        backgroundColor: Colors.black,
        body: Column(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  decoration: InputDecoration(
                      labelText: "Pesquise aqui",
                      labelStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder()),
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                )),
            Expanded(
              child: FutureBuilder(
                  future: _getGifs(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                      case ConnectionState.none:
                        return Container(
                          width: 200.0,
                          height: 200.0,
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                            strokeWidth: 5.0,
                          ),
                        );
                      default:
                        if (snapshot.hasError)
                          return Container();
                        else
                          _createGifTable(context, snapshot);
                    }
                  }),
            ),
          ],
        ));
        
  }

  Widget _createGifTable(BuildContext context, AsyncSnapshot, snapshot) {
          
}
}
