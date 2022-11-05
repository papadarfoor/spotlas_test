import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/feed_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Spotlas {
  Future getFeed(context) async {
    try {
      var url = Uri.parse('https://dev.api.spotlas.com/interview/feed?page=1');
      var response = await http.get(
        url,
      );
      if (response.statusCode != 200) {
        return const SnackBar(content: Text('Error'));
      }
      List<FeedModel> feed = [];
      var data = json.decode(response.body);

      final prefs = await SharedPreferences.getInstance();

      for (var i = 0; i < data.length; i++) {
        feed.add(FeedModel(
            id: data[i]['id'],
            authorUsername: data[i]['author']['username'],
            authorFullName: data[i]['author']['full_name'],
            authorProfilePicture: data[i]['author']['photo_url'],
            createdAt: data[i]['created_at'],
            spotName: data[i]['spot']['name'],
            spots: jsonEncode(data[i]['spot']['types']),
            location: data[i]['spot']['location']['display'],
            logo: data[i]['spot']['logo']['url'],
            mediaImage: jsonEncode(data[i]['media']),
            caption: data[i]['caption']['text'],
            tags: data[i]['caption'].containsKey('tags')
                ? jsonEncode(data[i]['caption']['tags'])
                : "",
            saved: prefs.getBool(data[i]['id']) == null ? false : true,
            liked:  prefs.getBool(data[i]['id']) == null ? false : true)
            );
      }

      return feed;
    } catch (exception) {
      return (exception.toString());
    }
  }

  
}
