import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:redit/constants/firebase_constants.dart';
import 'package:redit/core/provider/failure.dart';
import 'package:redit/core/provider/firebase_providers.dart';
import 'package:redit/core/provider/type_def.dart';
import 'package:redit/models/community.dart';


final communityRepositoryProvider = Provider((ref){

  return CommunityRepository(firestore: ref.watch(firestoreProvider));

});

class CommunityRepository{
  final FirebaseFirestore _firestore;

  CommunityRepository({required FirebaseFirestore firestore}) :
        _firestore = firestore;

  FutureVoid createCommunity(Community community) async{
    try{

        var CommunityDoc = await _communities.doc(community.name).get();

        if(CommunityDoc.exists){
          throw Exception("Community with same name already exists");
        }

        return right(_communities.doc(community.name).set(community.toMap()));

    } on FirebaseException catch(e){
      throw e.message!;
    }
    catch(e){

      return left(Failure(e.toString()));

    }
  }

  Stream<List<Community>> getUserCommunities(String uid) {
    return _communities.where('members', arrayContains: uid).snapshots().map((event) {
      List<Community> communities = [];
      for (var doc in event.docs) {
        communities.add(Community.fromMap(doc.data() as Map<String, dynamic>));
      }
      return communities;
    });
  }

Stream<Community> getCommunityByName(String name){
    return _communities.doc(name).snapshots().map((event) =>
        Community.fromMap(event.data() as Map<String, dynamic>));
}

  CollectionReference get _communities => _firestore.collection(FirebaseConstants.communitiesCollection);

}