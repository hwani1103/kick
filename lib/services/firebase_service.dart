import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/video_model.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String?> uploadVideo(File videoFile, String userId) async {
    try {
      final fileName = '${DateTime.now().millisecondsSinceEpoch}.mp4';
      final ref = _storage.ref().child('videos/$fileName');

      await ref.putFile(videoFile);
      final downloadUrl = await ref.getDownloadURL();

      await _firestore.collection('videos').add({
        'videoUrl': downloadUrl,
        'userId': userId,
        'kicks': 0,
        'kickedBy': [],
        'createdAt': DateTime.now().toIso8601String(),
        'reportCount': 0,
      });

      return downloadUrl;
    } catch (e) {
      print('Upload error: $e');
      return null;
    }
  }

  Stream<List<VideoModel>> getVideosStream() {
    return _firestore
        .collection('videos')
        .orderBy('kicks', descending: true)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => VideoModel.fromMap(doc.data(), doc.id))
          .toList();
    });
  }

  Future<void> kickVideo(String videoId, String userId) async {
    try {
      final docRef = _firestore.collection('videos').doc(videoId);
      final doc = await docRef.get();

      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        final kickedBy = List<String>.from(data['kickedBy'] ?? []);

        if (kickedBy.contains(userId)) {
          kickedBy.remove(userId);
          await docRef.update({
            'kicks': FieldValue.increment(-1),
            'kickedBy': kickedBy,
          });
        } else {
          kickedBy.add(userId);
          await docRef.update({
            'kicks': FieldValue.increment(1),
            'kickedBy': kickedBy,
          });
        }
      }
    } catch (e) {
      print('Kick error: $e');
    }
  }

  Future<void> reportVideo(String videoId) async {
    try {
      final docRef = _firestore.collection('videos').doc(videoId);
      await docRef.update({
        'reportCount': FieldValue.increment(1),
      });

      final doc = await docRef.get();
      if (doc.exists) {
        final reportCount = doc.data()?['reportCount'] ?? 0;
        if (reportCount >= 3) {
          await docRef.delete();
          final videoUrl = doc.data()?['videoUrl'];
          if (videoUrl != null) {
            await _storage.refFromURL(videoUrl).delete();
          }
        }
      }
    } catch (e) {
      print('Report error: $e');
    }
  }
}
