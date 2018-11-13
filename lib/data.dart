import 'dart:convert';

import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class Conference {
  Conference(
      {this.id,
      this.name,
      this.type,
      this.from,
      this.to,
      this.imageUrl,
      this.siteUrl,
      this.cfpUrl});
  final int id;
  final String name;
  final String type;
  final DateTime from;
  final DateTime to;
  final String imageUrl;
  final String siteUrl;
  final String cfpUrl;

  static Conference parse(Map<String, dynamic> jsonObj) {
    return Conference(
        id: jsonObj['id'],
        name: jsonObj['name'],
        type: jsonObj['eventType'],
        from: DateTime.parse(jsonObj['fromDate']),
        to: DateTime.parse(jsonObj['endDate']),
        imageUrl: jsonObj['imageURL'],
        siteUrl: jsonObj['website'],
        cfpUrl: jsonObj['cfpURL']);
  }

  @override
  bool operator ==(o) {
    return o is Conference &&
        o.id == id &&
        o.name == name &&
        o.from == from &&
        o.to == to &&
        o.imageUrl == imageUrl &&
        o.siteUrl == siteUrl &&
        o.cfpUrl == cfpUrl;
  }

  @override
  int get hashCode => id;
}

Future<List<Conference>> getConferencesFromAsset() async {
  final jsonObj =
      json.decode(await rootBundle.loadString('assets/devoxx.json'));
  return jsonObj
      .map<Conference>((jsonConf) => Conference.parse(jsonConf))
      .toList();
}

Future<List<Conference>> getConferencesFromNetwork() async {
  final url = 'https://api.voxxed.com/api/voxxeddays/events/future/voxxed';
  final res = await http.get(url);
  if (res.statusCode == 200) {
    return json
        .decode(res.body)
        .map<Conference>((jsonConf) => Conference.parse(jsonConf))
        .toList();
  } else {
    throw Exception(res.statusCode.toString());
  }
}

String prettyPrintDate(DateTime date) =>
    '${date.year}-${date.month}-${date.day}';

String prettyPrintFromTo(DateTime from, DateTime to) =>
    '${prettyPrintDate(from)} - ${prettyPrintDate(to)}';

void launchBrowser(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  }
}
