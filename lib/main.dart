// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const MyApp());
}

const MaterialColor white = MaterialColor(
  0xFFFFFFFF,
  <int, Color>{
    50: Color(0xFFFFFFFF),
    100: Color(0xFFFFFFFF),
    200: Color(0xFFFFFFFF),
    300: Color(0xFFFFFFFF),
    400: Color(0xFFFFFFFF),
    500: Color(0xFFFFFFFF),
    600: Color(0xFFFFFFFF),
    700: Color(0xFFFFFFFF),
    800: Color(0xFFFFFFFF),
    900: Color(0xFFFFFFFF),
  },
);

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Boetepot',
      theme: ThemeData(primarySwatch: white),
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset(
                'assets/ASCN7Color.svg',
                fit: BoxFit.fitHeight,
                height: 55,
                width: 55,
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: const Text(
                  'ASCN Nieuwland 7',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
        body: playerList(),
      ),
    );
  }
}

class playerList extends StatefulWidget {
  const playerList({Key? key}) : super(key: key);

  @override
  _playerListState createState() => _playerListState();
}

final List<String> players = <String>[
  'Jan Holthuis',
  'Tammo Stakenburg C',
  'Ivar van der Stappen',
  'Justin Kraak',
  'Mitchel Landman',
  'Danny van Hamersveld',
  'Indy van Barlingen',
  'Lars van Hamersveld',
  'Levi Hilbers',
  'Marc Boerema',
  'Pepijn Stas',
  'Stan Bruinvelds',
  'Larsse Vink',
  'Marcel Vlastuin',
  'Mart Lindeman',
  'Rens de Wilde',
  'Ruben Jansen',
  'Yari van Barlingen',
  'Mitchell Hop ',
];

final List<double> amount = <double>[
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0
];

List<Map<String, double>> spelers = [
  {
    "Ruben Jansen": 0,
  },
  {
    "Mitchell Hop": 0,
  }
];

class _playerListState extends State<playerList> {
  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: PlayerInfos.length,
      itemBuilder: (BuildContext context, index) {
        return ListTile(
          title: Text('${PlayerInfos[index].name}'),
          subtitle: Text('Boete € ${PlayerInfos[index].amount}'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BoeteLijst(
                    playerinfo: PlayerInfos[index], notifyParent: refresh),
              ),
            );
          },
          trailing: Wrap(
            spacing: 12,
            children: <Widget>[
              IconButton(
                  onPressed: () async {
                    await LaunchApp.openApp(
                      androidPackageName: 'com.abnamro.nl.tikkie',
                      iosUrlScheme: '',
                      appStoreLink:
                          'itms-apps://apps.apple.com/nl/app/tikkie/id1112935685',
                      // openStore: true
                    );
                  },
                  icon: const Icon(Icons.share))
            ],
          ),
        );
      },
    );
  }
}

class BoeteLijst extends StatefulWidget {
  // In the constructor, require a Todo.
  BoeteLijst({Key? key, required this.playerinfo, required this.notifyParent})
      : super(key: key);

  // Declare a field that holds the Todo.
  PlayerInfo playerinfo;
  final Function() notifyParent;

  @override
  State<BoeteLijst> createState() => _BoeteLijstState();
}

class _BoeteLijstState extends State<BoeteLijst> {
  List count = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

  decrementBoete(index) {
    setState(() {
      count[index]--;
      widget.playerinfo.amount =
          widget.playerinfo.amount - Boetes[index].amount;
      widget.notifyParent();
    });
  }

  incrementBoete(index) {
    setState(() {
      count[index]++;
      widget.playerinfo.amount =
          widget.playerinfo.amount + Boetes[index].amount;
      widget.notifyParent();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Scaffold(
        appBar: AppBar(
          title:
              Text(widget.playerinfo.name + ' € ${widget.playerinfo.amount}'),
          centerTitle: true,
        ),
        body: ListView.builder(
          itemCount: Boetes.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(Boetes[index].name),
              subtitle: Text('€ ${Boetes[index].amount}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  count[index] != 0
                      ? IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () => decrementBoete(index),
                        )
                      : Container(),
                  Text(count[index].toString(),
                      style: const TextStyle(fontSize: 18.0)),
                  IconButton(
                      onPressed: () => incrementBoete(index),
                      icon: const Icon(Icons.add)),
                ],
              ),
            );
          },
        ));
  }
}

class PlayerInfo {
  final String name;
  double amount;

  PlayerInfo(this.name, this.amount);
}

final PlayerInfos = List.generate(
  18,
  (i) => PlayerInfo(
    players[i],
    amount[i],
  ),
);

class Boete {
  String name;
  double amount;

  Boete(this.name, this.amount);
}

final List<Boete> Boetes = List.generate(
  18,
  (i) => Boete(
    boetes[i],
    kosten[i],
  ),
);

final List<String> boetes = <String>[
  'Bier morsen',
  '100% kans gemist',
  'Bal over hek (water)',
  'Corner over achterlijn',
  'Te laat op training',
  'Te laat bij wedstrijd',
  'Niet afmelden',
  'Niet willen vlaggen',
  'Panna geïncasseerd',
  'Eigen goal',
  'Gele kaart',
  'Rode kaart',
  'Scheenbeschermers vergeten',
  'Sokken vergeten',
  'Voetbalschoenen vergeten',
  'Verkeerd inwerpen',
  'Bierglas kapot',
  'Bal kwijt geraakt'
];

final List<double> kosten = <double>[
  0.50,
  1.00,
  2.00,
  0.50,
  1.00,
  2.00,
  1.00,
  2.00,
  0.50,
  3.00,
  2.00,
  3.00,
  1.50,
  1.50,
  2.00,
  1.00,
  1.00,
  10.00
];
