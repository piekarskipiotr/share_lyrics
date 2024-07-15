import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:share_lyrics/data/models/models.dart';

class FirestoreSongLyricsRepository {
  static const _collection = 'song_lyrics';
  final _firebaseStore = FirebaseFirestore.instance.collection(_collection);

  Future<dynamic> saveSongLyrics({required String userUUID, required SharedLyrics sharedLyrics}) async {
    try {
      final createdAt = DateTime.now();
      final timestamp = createdAt.millisecondsSinceEpoch;
      final docName = '$userUUID-$timestamp';
      final firestoreSharedLyrics = sharedLyrics.updateLocalToFirestore(userUUID: userUUID, createdAt: createdAt);
      await _firebaseStore.doc(docName).set(firestoreSharedLyrics.toFirestoreJson());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<(List<SharedLyrics>?, DocumentSnapshot?)> fetchSongLyrics({
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
      final songLyrics = documents.map((e) => SharedLyrics.fromJson(e.data())).toList();
      final lastDoc = songLyrics.isEmpty ? null : documents.last;
      return (songLyrics, lastDoc);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<dynamic> deleteSongLyrics({required SharedLyrics sharedLyrics}) async {
    try {
      final userUUID = sharedLyrics.userUUID!;
      final createdAt = sharedLyrics.createdAt!;
      final timestamp = createdAt.millisecondsSinceEpoch;
      final docName = '$userUUID-$timestamp';
      await _firebaseStore.doc(docName).delete();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
