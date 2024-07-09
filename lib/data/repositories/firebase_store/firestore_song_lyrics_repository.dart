import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:share_lyrics/data/models/models.dart';

class FirestoreSongLyricsRepository {
  static const _collection = 'song_lyrics';
  final _firebaseStore = FirebaseFirestore.instance.collection(_collection);

  Future<dynamic> saveSongLyrics({required String userUUID, required ShareSongLyrics shareSongLyrics}) async {
    try {
      final createdAt = DateTime.now();
      final timestamp = createdAt.millisecondsSinceEpoch;
      final docName = '$userUUID-$timestamp';
      final firestoreShareSongLyrics = shareSongLyrics.updateLocalToFirestore(userUUID: userUUID, createdAt: createdAt);
      await _firebaseStore.doc(docName).set(firestoreShareSongLyrics.toJson());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<(List<ShareSongLyrics>?, DocumentSnapshot?)> fetchSongLyrics({
    required DocumentSnapshot? lastDocSnap,
    required String userUUID,
    required int pageSize,
  }) async {
    try {
      var query =
          _firebaseStore.where('userUUID', isEqualTo: userUUID).orderBy('createdAt', descending: true).limit(pageSize);

      if (lastDocSnap != null) query = query.startAfterDocument(lastDocSnap);
      final querySnapshot = await query.get();

      final documents = querySnapshot.docs;
      final songLyrics = documents.map((e) => ShareSongLyrics.fromJson(e.data())).toList();
      final lastDoc = songLyrics.isEmpty ? null : documents.last;
      return (songLyrics, lastDoc);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<dynamic> deleteSongLyrics({required ShareSongLyrics shareSongLyrics}) async {
    try {
      final userUUID = shareSongLyrics.userUUID!;
      final createdAt = shareSongLyrics.createdAt!;
      final timestamp = createdAt.millisecondsSinceEpoch;
      final docName = '$userUUID-$timestamp';
      await _firebaseStore.doc(docName).delete();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
