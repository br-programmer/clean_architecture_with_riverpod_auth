import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../core/typedefs.dart';
import '../entities/app_user.dart';
import '../entities/friendship.dart';

class FriendsService {
  FriendsService({
    required FirebaseAuth firebaseAuth,
    required FirebaseFirestore firestore,
  })  : _firebaseAuth = firebaseAuth,
        _firestore = firestore;

  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  String get _authenticatedUserId => _firebaseAuth.currentUser?.uid ?? '';

  CollectionReference<Json> get _collection =>
      _firestore.collection('friendships');

  Future<List<AppUser>?> getMyFriends() async {
    try {
      final snapshot = await _firestore
          .collection('friendships')
          .where('status', isEqualTo: FriendshipStatus.active.name)
          .where('users', arrayContains: _authenticatedUserId)
          .get();

      if (snapshot.docs.isEmpty) {
        return [];
      }

      final friendsIds = snapshot.docs.map(
        (e) => (e['users'] as List<String>).firstWhere(
          (id) => id != _authenticatedUserId,
        ),
      );

      final friendsSnapshot = await _firestore
          .collection('users')
          .where('id', whereIn: friendsIds)
          .get();

      return friendsSnapshot.docs.where((e) => e.exists).map(
        (e) {
          final json = e.data();
          return AppUser(
            id: e.id,
            username: json['username'],
            email: json['email'],
            photoUrl: json['photoUrl'],
          );
        },
      ).toList();
    } catch (_) {
      return null;
    }
  }

  Future<List<Friendship>?> getRequests() async {
    try {
      final snapshot = await _collection
          .where('status', isEqualTo: FriendshipStatus.pending.name)
          .where('users', arrayContains: _authenticatedUserId)
          .where('sender', isNotEqualTo: _authenticatedUserId)
          .get();
      return snapshot.docs.map((e) => e.toFriendship()).toList();
    } catch (_) {
      return null;
    }
  }

  Future<Friendship?> sendRequest(AppUser user) async {
    try {
      final snapshot =
          await _collection.where('users', arrayContains: user.id).get();

      final docs = snapshot.docs;
      final data = {
        'users': [_authenticatedUserId, user.id],
        'sender': _authenticatedUserId,
        'status': FriendshipStatus.pending.name,
        'createdAt': DateTime.now().toIso8601String(),
        'updatedAt': DateTime.now().toIso8601String(),
      };

      if (docs.isEmpty) {
        final ref = await _collection.add(data);
        return (await ref.get()).toFriendship();
      }

      final friendship = docs.first.toFriendship();
      if ([
        FriendshipStatus.active,
        FriendshipStatus.pending,
      ].contains(friendship.status)) {
        return null;
      }

      await _collection.doc(friendship.id).set(data, SetOptions(merge: true));
      return Friendship(
        id: friendship.id,
        users: friendship.users,
        sender: _authenticatedUserId,
        status: FriendshipStatus.pending,
        createdAt: friendship.createdAt,
        updatedAt: DateTime.timestamp(),
      );
    } catch (_) {
      return null;
    }
  }

  Future<bool> cancelRequest(String requestId) async {
    return rejectRequest(requestId);
  }

  Future<bool> acceptRequest(String requestId) async {
    try {
      await _collection.doc(requestId).set(
        {
          'status': FriendshipStatus.active.name,
          'updatedAt': DateTime.now().toIso8601String(),
        },
        SetOptions(merge: true),
      );
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> rejectRequest(String requestId) async {
    try {
      await _collection.doc(requestId).set(
        {
          'status': FriendshipStatus.archived.name,
          'updatedAt': DateTime.now().toIso8601String(),
        },
        SetOptions(merge: true),
      );
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> deleteFriend(String friendId) async {
    try {
      final snapshot = await _collection
          .where('status', isEqualTo: FriendshipStatus.pending.name)
          .where('users', arrayContains: _authenticatedUserId)
          .where('users', arrayContains: friendId)
          .get();

      final docs = snapshot.docs;
      if (docs.isEmpty) {
        return false;
      }

      await _collection.doc(docs.first.id).set(
        {
          'status': FriendshipStatus.archived.name,
          'updatedAt': DateTime.now().toIso8601String(),
        },
        SetOptions(merge: true),
      );

      return true;
    } catch (_) {
      return false;
    }
  }
}

extension DocumentSnapshotX on DocumentSnapshot<Json> {
  Friendship toFriendship() {
    return Friendship(
      id: id,
      users: this['users'],
      sender: this['sender'],
      status: FriendshipStatus.values.byName(this['status']),
      createdAt: (this['createdAt'] as Timestamp).toDate(),
      updatedAt: (this['updatedAt'] as Timestamp).toDate(),
    );
  }
}
