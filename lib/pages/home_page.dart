

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:usando_api_md/pages/cidades_fragment.dart';
import 'package:usando_api_md/pages/consulta_cep_fragmet.dart';

class HomePage extends StatefulWidget{

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{

  var _fragment = 0;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(_fragment == 0 ? ConsultaCepFragmet.title :
        CidadesFragmet.title),
      ),
      body: Container(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _fragment,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
            label: ConsultaCepFragmet.title,
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.list),
            label: CidadesFragmet.title,
          )
        ],
        onTap: (int newIndex){
          if(newIndex != _fragment){
            setState(() {
              _fragment = newIndex;
            });
          }
        },
      ),
    );
  }
}