import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:share_lyrics/data/models/models.dart';

class FirestoreSongLyricsRepository {
  static const _collection = 'song_lyrics';
  final _firebaseStore = FirebaseFirestore.instance.collection(_collection);

  Future<dynamic> saveSongLyrics({required String userUUID, required ShareSongLyrics shareSongLyrics}) async {
    try {
      final firestoreShareSongLyrics = shareSongLyrics.updateLocalToFirestore(
        userUUID: userUUID,
        createdAt: DateTime.now(),
      );

      await _firebaseStore.doc(userUUID).set(firestoreShareSongLyrics.toJson());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<(List<ShareSongLyrics>?, DocumentSnapshot?)> fetchSongLyrics({
    required String userUUID,
    required int pageSize,
  }) async {
    try {
      final querySnapshot = await _firebaseStore
          .where('userUUID', isEqualTo: userUUID)
          .orderBy('createdAt', descending: true)
          .limit(pageSize)
          .get();

      final documents = querySnapshot.docs;
      final songLyrics = documents.map((e) => ShareSongLyrics.fromJson(e.data())).toList();
      final lastDoc = songLyrics.isEmpty ? null : documents.last;
      return (songLyrics, lastDoc);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<(List<ShareSongLyrics>?, DocumentSnapshot?)> fetchNext({
    required DocumentSnapshot lastDocSnap,
    required String userUUID,
    required int pageSize,
  }) async {
    try {
      final querySnapshot = await _firebaseStore
          .where('userUUID', isEqualTo: userUUID)
          .orderBy('createdAt', descending: true)
          .startAfterDocument(lastDocSnap)
          .limit(pageSize)
          .get();

      final documents = querySnapshot.docs;
      final songLyrics = documents.map((e) => ShareSongLyrics.fromJson(e.data())).toList();
      final lastDoc = songLyrics.isEmpty ? null : documents.last;
      return (songLyrics, lastDoc);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
