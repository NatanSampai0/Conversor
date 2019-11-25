import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const request = "https://api.hgbrasil.com/finance?key=f36d286f";

void main() async{
  runApp(MaterialApp(
    home: Home(),
  ));
}

Future<Map> getData() async{
  http.Response response = await http.get(request);
  return json.decode(response.body);
}

class Home extends StatefulWidget{
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        title: Text("Conversor"),
        backgroundColor: Colors.teal[800],
        centerTitle: true,
      ),
      body: FutureBuilder<Map>(
        future: getData(),
        builder: (context, snapshot){
          switch (snapshot.connectionState){
            case ConnectionState.none:
            case ConnectionState.waiting:
            return _buildMessage("Carregando Dados ...", Colors.amber);
            default:
            if (snapshot.hasError) {
              return _buildMessage("Erro ao carregar dados ...", Colors.orange[200]);
            } else {
              return _buildMessage("Dados carregados com sucesso ...", Colors.white);
            }
          }
        }
      ),
    );
  }
}

Widget _buildMessage(String text, Color color){
  return Center(
    child: Text(
      text,
      style: TextStyle(color: color,fontSize: 25.0),
      textAlign: TextAlign.center,
    ),
);
}