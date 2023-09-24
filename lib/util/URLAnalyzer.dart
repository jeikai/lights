import 'package:flutter/cupertino.dart';
import 'package:flutter_social_button/flutter_social_button.dart';

class URLAnalyzer {
  //Facebook
  static final facebook = RegExp(r'https://www\.facebook\.com/(.+)');

  // Twitter
  static final twitter = RegExp(r'https://twitter\.com/([a-zA-Z0-9_]+)');

  // Instagram
  static final instagram =
      RegExp(r'https://www\.instagram\.com/([a-zA-Z0-9_.]+)/');

  // LinkedIn
  static final linkedin =
      RegExp(r'https://www\.linkedin\.com/in/([a-zA-Z0-9-]+)');

  // GitHub
  static final github = RegExp(r'https://github\.com/([a-zA-Z0-9-]+)');

  // YouTube
  static final youtube =
      RegExp(r'https://www\.youtube\.com/(user|c)/([a-zA-Z0-9-]+)');

  (IconData, String) analyze(String url) {
    if (url.contains(URLAnalyzer.facebook.pattern)) {
      final match = URLAnalyzer.facebook.firstMatch(url);
      final username = match!.group(1);
      return (FontAwesomeIcons.facebook, username!);
    }
    if (url.contains(URLAnalyzer.twitter.pattern)) {
      final match = URLAnalyzer.twitter.firstMatch(url);
      final username = match!.group(1);
      return (FontAwesomeIcons.twitter, username!);
    }
    if (url.contains(URLAnalyzer.instagram.pattern)) {
      final match = URLAnalyzer.instagram.firstMatch(url);
      final username = match!.group(1);
      return (FontAwesomeIcons.instagram, username!);
    }
    if (url.contains(URLAnalyzer.linkedin.pattern)) {
      final match = URLAnalyzer.linkedin.firstMatch(url);
      final username = match!.group(1);
      return (FontAwesomeIcons.linkedin, username!);
    }
    if (url.contains(URLAnalyzer.github.pattern)) {
      final match = URLAnalyzer.github.firstMatch(url);
      final username = match!.group(1);
      return (FontAwesomeIcons.github, username!);
    }
    if (url.contains(URLAnalyzer.youtube.pattern)) {
      final match = URLAnalyzer.youtube.firstMatch(url);
      final username = match!.group(1);
      return (FontAwesomeIcons.youtube, username!);
    }
    return (FontAwesomeIcons.internetExplorer, url);
  }
}
