import 'package:flutter/material.dart';
import 'package:devoxx/data.dart';

void main() => runApp(DevoxxApp());

class DevoxxApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Devoxx Conferences',
      home: DevoxxHomePage(),
    );
  }
}

class DevoxxHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Devoxx Conferences'),
      ),
      body: FutureBuilder(
          future: getConferencesFromNetwork(),
          builder: (context, AsyncSnapshot<List<Conference>> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            if (snapshot.hasData) {
              return ListView(
                  children:
                      snapshot.data.map((c) => ConferenceTile(c)).toList());
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}

class ConferenceTile extends StatelessWidget {
  ConferenceTile(this.conference);
  final Conference conference;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(conference.imageUrl),
      ),
      title: Text(conference.name),
      subtitle: Text(prettryPrintFromTo(conference.from, conference.to)),
      onTap: () => launchBrowser(conference.siteUrl),
    );
  }
}
