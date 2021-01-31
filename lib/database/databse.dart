import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_app/model/post.dart';
import 'package:food_app/model/review.dart';
import 'package:food_app/model/user.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Database{
  
  String serverKey = "AAAA7_a4a9I:APA91bH_M8-EDOKRrAk2f1lPlSJlt7n4QVMUMOgfehJTImv02BshcbRC3vs8_Uwq16JLa9wgQfDgcuKUwvSA5FFxP4cmluOKGPSqbXsdP-eOFbQOCtYOEdyoVJdTyJJzjdo670JamoPH";
  
  //collection reference 
  
  final CollectionReference users = Firestore.instance.collection('user');
  final CollectionReference postReference = Firestore.instance.collection('food');
  final CollectionReference systemData = Firestore.instance.collection('systemData');


  Future<User> login(String telNumber, String password ) async{
    QuerySnapshot querySnapshot;
    User user;

    querySnapshot = await users
    .where('telNumber',isEqualTo: telNumber )
    .where('password',isEqualTo: password)
    .getDocuments();

    if(querySnapshot.documents.length == 0){
      return null;
    }

    for (var item in querySnapshot.documents) {
      user = User()
        ..telNumber= item['telNumber']
        ..name= item['name']
        ..flowers= item['flowers'].cast<String>()
        ..flowing= item['flowing'].cast<String>()
        ..email= item['email']
        ..profilePicUrl= item['profilePicUrl']
        ..password= item['password']
        ..address= item['address'];
    }

    return user;
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
      "userCategory":""
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

  

}