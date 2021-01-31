import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_app/model/post.dart';
import 'package:food_app/model/review.dart';
import 'package:food_app/model/user.dart';
import 'package:food_app/res/convert.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Database{
  
  String serverKey = "AAAA7_a4a9I:APA91bH_M8-EDOKRrAk2f1lPlSJlt7n4QVMUMOgfehJTImv02BshcbRC3vs8_Uwq16JLa9wgQfDgcuKUwvSA5FFxP4cmluOKGPSqbXsdP-eOFbQOCtYOEdyoVJdTyJJzjdo670JamoPH";
  
  //collection reference 
  
  final CollectionReference users = Firestore.instance.collection('user');
  final CollectionReference postReference = Firestore.instance.collection('food');
  final CollectionReference systemData = Firestore.instance.collection('systemData');


  Future<User> login(String telNumber, String password ) async{
    QuerySnapshot querySnapshot;

    querySnapshot = await users
    .where('telNumber',isEqualTo: telNumber )
    .where('password',isEqualTo: password)
    .getDocuments();

    if(querySnapshot.documents.length == 0){
      return null;
    }

    return _setUser(querySnapshot);
  }

  Future<User> getUser(String telNumber) async{
    QuerySnapshot querySnapshot;

    querySnapshot = await users
    .where('telNumber',isEqualTo: telNumber )
    .getDocuments();

    if(querySnapshot.documents.length == 0){
      return null;
    }

    return _setUser(querySnapshot);
  }

  Future<bool> checkUser(String telNumber) async{
    QuerySnapshot querySnapshot;

    querySnapshot = await users
    .where('telNumber',isEqualTo: telNumber )
    .getDocuments();

    if(querySnapshot.documents.length == 0){
      return true;
    }else{
      return false;
    }
  }

  Future addUser(User user) async{
    await users.document(user.telNumber).setData({
      "telNumber":user.telNumber,
      "name":user.name,
      "flowers":[],
      "flowing":[],
      "email":"",
      "profilePicUrl":"",
      "password":user.password,
      "address":"",
      "userCategory":"",
      "reviewList":[],
      "description":"",
      "favoritePost":[]
    });
  }

  Future addPost(Post post) async{

    String key;
    List<String> searchText = [];
    String searchTextValue ="";

    key=post.title.toLowerCase();

    for (var i = 0; i < key.length; i++) {
      searchTextValue += key[i];
      searchText.add(searchTextValue);
    }
    
    await postReference.document(post.id).setData({
      "id" :post.id,
      "userTelNumber" :post.userTelNumber,
      "title" :post.title,
      // "place" :post.place,
      "city" :post.city,
      "location" :post.location.latitude.toString()+","+post.location.longitude.toString(),
      "price" :post.price,
      "amount" :post.amount,
      "intendDate" :post.intendDate,
      "insertTime" :DateTime.now(),
      "description" :post.description,
      "imgUrl" :post.imgUrl,
      "clapUser" :[],
      "forSale" :post.forSale,
      "searchText" : searchText
    });
  }

  Future<List<Post>> getPostList() async{
    QuerySnapshot querySnapshot;
    querySnapshot = await postReference
    .orderBy('intendDate',descending:true)
    .getDocuments();

    return await _setPostList(querySnapshot);
  }

  Future<void> addRemoveFavorite(String postId, User user) async{
    if(user.favoritePost.contains(postId)){
      user.favoritePost.remove(postId);
    }else{
      user.favoritePost.add(postId);
    }

    await users.document(user.telNumber).updateData({
      "favoritePost":user.favoritePost
    });

  }

  Future<List<Post>> getFavorite( User user) async{
    QuerySnapshot querySnapshot;
    querySnapshot = await postReference
    .where('search',whereIn: [user.favoritePost])
    .orderBy('intendDate',descending:true)
    .getDocuments();

    return await _setPostList(querySnapshot);

  }

  Future<List<Post>> searchPostList(String searchKey,bool forSale) async{
    QuerySnapshot querySnapshot;
    querySnapshot = await postReference
    .where('search',arrayContainsAny: [searchKey])
    .where('forSale',isEqualTo: forSale)
    .orderBy('intendDate',descending:true)
    .getDocuments();

    return await _setPostList(querySnapshot);
  }

  Future<List<Post>> getClappedPost(User user) async{
    QuerySnapshot querySnapshot;
    querySnapshot = await postReference
    .where('userTelNumber',isEqualTo: user.telNumber)
    .orderBy('intendDate',descending:true)
    .getDocuments();
    List<Post> postList = await _setPostList(querySnapshot);

    for (var i = 0; i < postList.length; i++) {
      if(postList[i].clapUser.isEmpty){
        postList.removeAt(i);
      }
    }
    return postList;
  }

  Future<List<Post>> getMyPost(User user) async{
    QuerySnapshot querySnapshot;
    querySnapshot = await postReference
    .where('userTelNumber',isEqualTo: user.telNumber)
    .orderBy('intendDate',descending:true)
    .getDocuments();
    return await _setPostList(querySnapshot);
  }

  Future<bool> addClap(List<User> clappedUsers, User newUser,Post post) async{
    List<Map<String,dynamic>> clapListMap =[];
   
    for (var item in clappedUsers) {
      if(item.telNumber == newUser.telNumber){
        return false;
      }
      clapListMap.add(
        {
          "telNumber":item.telNumber,
          "name":item.name,
        }
      );
    }

    clapListMap.add(
        {
          "telNumber":newUser.telNumber,
          "name":newUser.name,
        }
      );

    await postReference.document(post.id).updateData({
      "clapUser":clapListMap
    });
    return true;
  }

  Future<bool> addReview(List<Review> review, User reviewedUser) async{
    List<Map<String,dynamic>> reviewListMap =[];
   
    for (var item in review) {
      reviewListMap.add(
        {
          "review": item.review,
          "starCount": item.starCount,
          "userTelNumber": item.userTelNumber,
          "userName": item.userName,
          "dateTime": item.dateTime,
        }
      );
    }
    await users.document(reviewedUser.telNumber).updateData({
      "reviewList":reviewListMap
    });
    return true;
  }

  Future<void> follow(User otherUser, User user) async{
    user.flowing.add(otherUser.telNumber);
    otherUser.flowers.add(user.telNumber);

    await users.document(user.telNumber).updateData({
      "flowing":user.flowing
    });

    await users.document(otherUser.telNumber).updateData({
      "flowers":otherUser.flowers
    });

  }

  Future<void> unFollow(User otherUser, User user) async{
    user.flowing.remove(otherUser.telNumber);
    otherUser.flowers.remove(user.telNumber);

    await users.document(user.telNumber).updateData({
      "flowing":user.flowing
    });

    await users.document(otherUser.telNumber).updateData({
      "flowers":otherUser.flowers
    });

  }

  Future updateUser(User user) async{
    await users.document(user.telNumber).updateData({
      "name":user.name,
      "email":"",
      "profilePicUrl":"",
      "address":"",
      "userCategory":"",
      "description":user.description,
      "category":categoryToString(user.category)
    });
  }



  Future<List<Post>> _setPostList(QuerySnapshot querySnapshot) async {
    List<Post> postList = [];

    for (var item in querySnapshot.documents) {
      String userTelNumber = item["userTelNumber"];
      
      User user = User();

      QuerySnapshot  userDetails = await users
      .where('telNumber',isEqualTo: userTelNumber).
      getDocuments();

      for (var userItem in userDetails.documents) {
        user.reviewList = [];
        user.profilePicUrl  =userItem['profilePicUrl'];
        user.name = userItem['name'];
        if(userItem["reviewList"] != null){
          for (var itemReviewList in userItem["reviewList"]) {
            user.reviewList.add(
              Review()
              ..id = itemReviewList['id']
              ..review = itemReviewList['review']
              ..starCount = itemReviewList['starCount']
              ..userTelNumber = itemReviewList['userTelNumber']
              ..userName = itemReviewList['userName']
              ..dateTime = itemReviewList['dateTime']
            );
          }
        }
      }

      List<User> clapUser = [];
      if(item["clapUser"] != null){
        for (var clapUserList in item["clapUser"]) {
          clapUser.add(
            User()
            ..telNumber = clapUserList['telNumber']
            ..name = clapUserList['name']
          );
        }
      }

      Timestamp intendDate = item["intendDate"];
      Timestamp insertTime = item["insertTime"];

      postList.add( 
        Post()
        ..id = item["id"]
        ..userTelNumber = item["userTelNumber"]
        ..title = item["title"]
        ..place = item["place"]
        ..city = item["city"]
        ..location =  LatLng(double.parse(item["location"].toString().split(",")[0]),double.parse(item["location"].toString().split(",")[1]))
        ..price = item["price"]
        ..amount = item["amount"]
        ..intendDate = DateTime.fromMillisecondsSinceEpoch(intendDate.millisecondsSinceEpoch) 
        ..insertTime =  DateTime.fromMillisecondsSinceEpoch(insertTime.millisecondsSinceEpoch) 
        ..description = item["description"]
        ..imgUrl = item["imgUrl"]
        ..clapUser = clapUser
        ..forSale = item["forSale"]
        ..user = user
      );


    }
    return postList;
  }

  Future<User> _setUser(QuerySnapshot querySnapshot) async {
    User user;
    for (var item in querySnapshot.documents) {
      List<Review> review = [];
      if(item["reviewList"] != null){
        for (var reviewItem in item["reviewList"]) {
          review.add(
            Review()
            ..review = reviewItem.review
            ..starCount = reviewItem.starCount
            ..userTelNumber = reviewItem.userTelNumber
            ..userName = reviewItem.userName
            ..dateTime = reviewItem.dateTime
          );
        }
      }
      user = User()
        ..telNumber= item['telNumber']
        ..name= item['name']
        ..flowers= item['flowers'].cast<String>()
        ..flowing= item['flowing'].cast<String>()
        ..email= item['email']
        ..profilePicUrl= item['profilePicUrl']
        ..address= item['address']
        ..favoritePost=item['favoritePost'].cast<String>()
        ..category = stringToUserCategory(item['category']);
    }

    return user;
  }

  

}