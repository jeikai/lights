import 'dart:math';
import 'package:just_audio/just_audio.dart';
import 'package:flutterapp/util/Preferences.dart';

class MusicManager {
  static AudioPlayer? _audioPlayer;

  static const List<String> _musicUrls = [
    'https://res.cloudinary.com/dycsfcnso/video/upload/v1722308654/lights/music/bg_sound1_htjb0d.mp3',
    'https://res.cloudinary.com/dycsfcnso/video/upload/v1722308657/lights/music/bg_sound2_uzr1ym.mp3',
    'https://res.cloudinary.com/dycsfcnso/video/upload/v1722308655/lights/music/bg_sound3_cg5uxa.mp3'
  ];

  static Future<void> init() async {
    _audioPlayer = AudioPlayer();
    if (isMusicEnabled()) {
      _playMusic();
    }
  }

  static bool isMusicEnabled() {
    return Preferences.getBgMusic() ?? true;
  }

  static Future<void> turnOffMusic() async {
    _stopMusic();
  }

  static Future<void> turnOnMusic() async {
    bool? enabled = Preferences.getBgMusic();
    if (enabled == true) {
      _playMusic();
    }
  }

  static Future<void> setMusicEnabled(bool enabled) async {
    await Preferences.setBgMusic(enabled);
    if (enabled) {
      _playMusic();
    } else {
      _stopMusic();
    }
  }

  static Future<void> _playMusic() async {
    await _stopMusic();
    final random = Random();
    final randomIndex = random.nextInt(_musicUrls.length);
    final randomMusicUrl = _musicUrls[randomIndex];
    await _audioPlayer?.setUrl(randomMusicUrl);
    await _audioPlayer?.setLoopMode(LoopMode.all);
    await _audioPlayer?.play();
  }

  static Future<void> _stopMusic() async {
    await _audioPlayer?.stop();
  }

  static void dispose() {
    _audioPlayer?.dispose();
    _audioPlayer = null;
  }
}
