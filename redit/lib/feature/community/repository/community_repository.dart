
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:redit/constants/firebase_constants.dart';
import 'package:redit/core/provider/failure.dart';
import 'package:redit/core/provider/type_def.dart';
import 'package:redit/models/community.dart';

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

  CollectionReference get _communities => _firestore.collection(FirebaseConstants.communitiesCollection);

}