import 'dart:convert';

import 'package:flutter_webdeneme/data/Eczane_api.dart';
import 'package:flutter_webdeneme/model/Eczane.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webdeneme/model/sehir.dart';
import 'package:hexcolor/hexcolor.dart';

class EczaneListesiforWeb extends StatefulWidget {
  EczaneListesiforWeb({Key? key}) : super(key: key);

  @override
  _EczaneListesiforWebState createState() => _EczaneListesiforWebState();
}

class _EczaneListesiforWebState extends State<EczaneListesiforWeb> {
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
    print(sehir + "  " + ilce);
    if (sehir == "Hepsi") {
      setState(() {});
    } else {
      if (ilce == "Hepsi") {
        setState(() {
          EczaneListesi2.removeWhere((item) => item.sehir != sehir);
        });
      } else {
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
  var _options = ["Hepsi"];

  var _options2 = ["Hepsi"];

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
      backgroundColor: HexColor("002366"),
      body: Column(
        children: <Widget>[
          SizedBox(height: MediaQuery.of(context).size.height/25,),
          Container(
            padding: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height / 6,
            child: Text(
              'Eczaneler',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20,color: Colors.white),
            ),
          ),
          //======================================================== State
          SizedBox(height: 30),

          Container(
            padding: EdgeInsets.only(left: 15, right: 15, top: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: HexColor("FA8072"),
              boxShadow: [
                BoxShadow(color: Colors.green, spreadRadius: 1),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton<String>(
                        value: _selectedItem,
                        iconSize: 30,
                        icon: (null),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                        hint: Text('Select State'),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedItem = newValue.toString();
                            choiceAction(_selectedItem);
                            _options2=["Hepsi"];
                            for (var item in SehirListesi) {
                              if (_options2!.contains(item.ilce.toString()) ==
                                      false &&
                                  item.il == _selectedItem) {
                                setState(() {
                                  _options2.add(item.ilce.toString());
                                });
                              } else {}
                            }
                            _selectedItem2="Hepsi";
                          });
                        },
                        items: _options?.map((item) {
                              return new DropdownMenuItem(
                                child: Text(item.toString()),
                                value: item.toString(),
                              );
                            })?.toList() ??
                            [],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),

          //======================================================== City

          Container(
            padding: EdgeInsets.only(left: 15, right: 15, top: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: HexColor("FA8072"),
              boxShadow: [
                BoxShadow(color: Colors.green, spreadRadius: 1),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton<String>(
                        value: _selectedItem2,
                        iconSize: 30,
                        icon: (null),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                        hint: Text('Select City'),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedItem2 = newValue.toString();
                            choiceAction2(_selectedItem, _selectedItem2);
                          });
                        },
                        items: _options2?.map((item) {
                              return new DropdownMenuItem(
                                child: Text(item.toString()),
                                value: item.toString(),
                              );
                            })?.toList() ??
                            [],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 25,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: HexColor("FA8072"),
              boxShadow: [
                BoxShadow(color: Colors.green, spreadRadius: 1),
              ],
            ),
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width - 50,
            child: ListView.builder(
                itemCount: EczaneListesi2.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(EczaneListesi2[index].name),
                    subtitle: Text(EczaneListesi2[index].sehir.toString() +
                        "  " +
                        EczaneListesi2[index].ilce.toString()),
                  );
                }),
          )
        ],
      ),
    );
  }
}
