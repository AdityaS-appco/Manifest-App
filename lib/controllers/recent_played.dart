// recent_tracks_controller.dart
import 'dart:developer';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/playlist_tab_model/playlist_by_id_model.dart';

class RecentTracksController extends GetxController {
  static const String STORAGE_KEY = 'recent_tracks';
  final recentTracks = <Track>[].obs;
  final int maxTracks = 10;

  @override
  void onInit() {
    super.onInit();
    loadRecentTracks();
  }

  Future<void> loadRecentTracks() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? storedTracks = prefs.getString(STORAGE_KEY);
      
      if (storedTracks != null) {
        final List<dynamic> decoded = jsonDecode(storedTracks);
        final tracks = decoded.map((item) => Track.fromJson(item)).toList();
        recentTracks.value = tracks;
        log(recentTracks.toString());
      }
    } catch (e) {
      print('Error loading recent tracks: $e');
    }
  }

  Future<void> addTrack(Track track) async {
    try {
      // Remove if track already exists (based on trackId)
      recentTracks.removeWhere((t) => t.trackId == track.trackId);
      
      // Add new track at the beginning
      recentTracks.insert(0, track);
      
      // Maintain max limit
      if (recentTracks.length > maxTracks) {
        recentTracks.removeLast();
      }
      
      await saveToStorage();
    } catch (e) {
      print('Error adding track: $e');
    }
  }

  Future<void> saveToStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final encodedTracks = jsonEncode(recentTracks.map((t) => t.toJson()).toList());
      await prefs.setString(STORAGE_KEY, encodedTracks);
    } catch (e) {
      print('Error saving tracks: $e');
    }
  }

  void clearRecentTracks() async {
    try {
      recentTracks.clear();
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(STORAGE_KEY);
    } catch (e) {
      print('Error clearing tracks: $e');
    }
  }
}
