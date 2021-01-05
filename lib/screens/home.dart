import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:search_invocador/models/league.dart';
import 'package:search_invocador/models/summoner.dart';
import 'package:search_invocador/services/api.dart';
import 'package:search_invocador/utils/UpperFirst.dart';
import 'package:search_invocador/utils/utf8_string.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({this.title});

  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _searchField = TextEditingController();

  Summoner selected;
  String search;

  String profileUrl({int img}) =>
      'http://ddragon.leagueoflegends.com/cdn/10.25.1/img/profileicon/$img.png';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
        title: Center(child: Text(widget.title)),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            searchField,
            infoField,
          ],
        ),
      ),
    );
  }

  Widget get searchField => Container(
        margin: EdgeInsets.fromLTRB(40, 40, 40, 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(27, 5, 40, 0),
          child: TextField(
            controller: _searchField,
            onSubmitted: (data) {
              setState(
                () {
                  search = data;
                },
              );
            },
            cursorColor: Colors.grey,
            decoration: InputDecoration(
              hintText: 'Digite o nome do invocador...',
              border: OutlineInputBorder(),
              icon: Icon(Icons.search),
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
            ),
          ),
        ),
      );

  Widget get infoField {
    if (search == null) {
      return infoMessage;
    } else {
      return FutureBuilder(
        future: fetchSummoner(search),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return summonerCard(summoner: snapshot.data);
          } else {
            return Expanded(
              flex: 1,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      );
    }
  }

  Widget summonerCard({Summoner summoner}) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 105,
                  height: 105,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      fit: BoxFit.contain,
                      image:
                          NetworkImage(profileUrl(img: summoner.profileIconId)),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 10),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        formatUTF8(summoner.name),
                        style: GoogleFonts.roboto(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${summoner.summonerLevel}',
                        style: GoogleFonts.roboto(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[300],
                        ),
                      ),
                      summoner.ranks.isEmpty
                          ? SizedBox()
                          : leagueColumn(summoner: summoner),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget leagueColumn({Summoner summoner}) {
    List<Row> rows = [];
    if (summoner.ranks.length > 1) {
      summoner.ranks[0].queueType == 'RANKED_SOLO_5x5'
          ? rows.addAll([
              tierRow(league: summoner.ranks[0]),
              tierRow(league: summoner.ranks[1]),
            ])
          : rows.addAll([
              tierRow(league: summoner.ranks[1]),
              tierRow(league: summoner.ranks[0]),
            ]);
    } else {
      rows.addAll([
        tierRow(league: summoner.ranks[0]),
      ]);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: rows,
    );
  }

  Row tierRow({League league}) {
    String queueType = league.queueType == 'RANKED_SOLO_5x5' ? 'Solo' : 'Flex';
    return Row(
      children: [
        Image.asset(
          'assets/tier/Emblem_${league.tier}.png',
          scale: 20,
        ),
        Text(
          '$queueType: ${upperFirstLetter(league.tier)} ${league.rank} ${league.leaguePoints} pdl',
          style: GoogleFonts.roboto(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget get infoMessage {
    return Expanded(
      flex: 1,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 32,
              color: Colors.grey,
            ),
            Text(
              'Pesquise por um invocador!',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
