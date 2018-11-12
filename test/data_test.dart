import 'dart:convert';

import 'package:test/test.dart';
import 'package:devoxx/data.dart';

void main() {
  test('Test Conference JSON parsing', () {
    final jsonStr = """
      {
        "id": 24,
        "name": "Voxxed Days Thessaloniki 2018",
        "eventType": "VOXXED",
        "fromDate": "2018-11-19",
        "endDate": "2018-11-20",
        "imageURL": "https://s3-eu-west-1.amazonaws.com/voxxeddays/webapp/images/dc58a482-029e-47c4-8c1e-20f6917cd712.jpg",
        "website": "https://voxxeddays.com/thessaloniki",
        "cfpURL": "https://vdthess18.confinabox.com/"
      }
    """;

    final expectedConference = Conference(
      id: 24,
      name: 'Voxxed Days Thessaloniki 2018',
      type: 'VOXXED',
      from: DateTime(2018, 11, 19),
      to: DateTime(2018, 11, 20),
      imageUrl:
          'https://s3-eu-west-1.amazonaws.com/voxxeddays/webapp/images/dc58a482-029e-47c4-8c1e-20f6917cd712.jpg',
      siteUrl: 'https://voxxeddays.com/thessaloniki',
      cfpUrl: 'https://vdthess18.confinabox.com/',
    );

    final parsedConference = Conference.parse(json.decode(jsonStr));
    expect(parsedConference, expectedConference);
  });
}
