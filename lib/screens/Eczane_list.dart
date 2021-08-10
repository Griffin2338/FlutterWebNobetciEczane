import 'dart:convert';

import 'package:flutter_webdeneme/data/Eczane_api.dart';
import 'package:flutter_webdeneme/model/Eczane.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webdeneme/model/sehir.dart';

class EczaneListesi extends StatefulWidget {
  EczaneListesi({Key? key}) : super(key: key);

  @override
  _EczaneListesiState createState() => _EczaneListesiState();
}

class _EczaneListesiState extends State<EczaneListesi> {
  List<Eczane> EczaneListesi = <Eczane>[];
  List<Eczane> EczaneListesi2 = <Eczane>[];
  List<Sehir> SehirListesi = <Sehir>[];
  late List<String> sehirlistesi = [];

  void getEczane() async {
    EczaneApi.getCharacters().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        EczaneListesi = list.map((model) => Eczane.fromJson(model)).toList();
        EczaneListesi2 = EczaneListesi;
      });
    });
  }

  void getSehir() async {
    EczaneApi.getCharacters().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        SehirListesi = list.map((model) => Sehir.fromJson(model)).toList();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getEczane();
    getSehir();
  }

  void choiceAction(String choice) {
    EczaneListesi2 = EczaneListesi.toList();


    if (choice == "Hepsi") {
      setState(() {});
    } else {
      setState(() {
        EczaneListesi2.removeWhere((item) => item.sehir != choice);
      });
    }
  }
  void choiceAction2(String sehir, String ilce) {
    EczaneListesi2 = EczaneListesi.toList();
    print(sehir+"  "+ilce);
    if (sehir == "Hepsi") {
      setState(() {});
    } else {
      if(ilce=="Hepsi"){
        setState(() {
          EczaneListesi2.removeWhere((item) => item.sehir != sehir);

        });

      }
      else{
      setState(() {
      EczaneListesi2.removeWhere((item) => item.sehir != sehir);
      EczaneListesi2.removeWhere((item) => item.ilce != ilce);

      });
      }

    }
  }





  late String selectedKey;

  String _selectedItem = 'Hepsi';
  String _selectedItem2 = 'Hepsi';
  List _options = ["Hepsi"];

  List _options2 = ["Hepsi"];


  @override
  Widget build(BuildContext context) {
    Map<String, Sehir> mp = {};
    for (var item in SehirListesi) {
      mp[item.il] = item;
      mp[item.ilce] = item;
    }
    var filteredList = mp.values.toList();

    for (var item in filteredList) {
      if (_options!.contains(item.il.toString()) == false) {
        setState(() {
          _options.add(item.il.toString());
        });
      } else {}
    }






    return Scaffold(
        appBar: AppBar(
          title: Text("Eczaneler"),
          actions: <Widget>[
            PopupMenuButton(
              itemBuilder: (BuildContext bc) {
                return _options
                    .map((day) => PopupMenuItem(
                          child: Text(day),
                          value: day,
                        ))
                    .toList();
              },
              onSelected: (value) {
                setState(() {
                  _options2=["Hepsi"];
                  _selectedItem = value.toString();
                  choiceAction(_selectedItem);
                  for (var item in SehirListesi) {
                    if (_options2!.contains(item.ilce.toString()) == false && item.il==_selectedItem ) {
                      setState(() {
                        _options2.add(item.ilce.toString());
                      });
                    } else {}
                  }
                });
              },
            ),
            PopupMenuButton(
              itemBuilder: (BuildContext bc) {
                return _options2
                    .map((day) => PopupMenuItem(
                          child: Text(day),
                          value: day,
                        ))
                    .toList();
              },
              onSelected: (value) {
                setState(() {
                  _selectedItem2 = value.toString();
                  choiceAction2(_selectedItem,_selectedItem2);
                });
              },
            ),
          ],
        ),
        body: Container(
          child: ListView.builder(
              itemCount: EczaneListesi2.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(EczaneListesi2[index].name),
                  subtitle: Text(EczaneListesi2[index].sehir.toString()+"  "+EczaneListesi2[index].ilce.toString()),
                );
              }),
        ));
  }
}
