import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_app/const.dart';
import 'package:food_app/model/message.dart';
import 'package:food_app/model/messageHead.dart';
import 'package:food_app/model/post.dart';
import 'package:food_app/model/review.dart';
import 'package:food_app/model/user.dart';
import 'package:food_app/res/convert.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Database{
  
  String serverKey = "AAAA7_a4a9I:APA91bH_M8-EDOKRrAk2f1lPlSJlt7n4QVMUMOgfehJTImv02BshcbRC3vs8_Uwq16JLa9wgQfDgcuKUwvSA5FFxP4cmluOKGPSqbXsdP-eOFbQOCtYOEdyoVJdTyJJzjdo670JamoPH";
  
  //collection reference 
  
  final CollectionReference users = Firestore.instance.collection('user');
  final CollectionReference msgReference = Firestore.instance.collection('msg');
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
      "favoritePost":[],
      "productList":[]
    });
  }
  
  Future deletePost(String postId) async{
    await postReference.document(postId).delete();
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
      "clapUser" :post.clapUser,
      "forSale" :post.forSale,
      "searchText" : searchText,
      "postCategory":categoryToString(post.postCategory)
    });
  }


  Future updatePost(Post post) async{

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
      "city" :post.city,
      "location" :post.location.latitude.toString()+","+post.location.longitude.toString(),
      "price" :post.price,
      "amount" :post.amount,
      "intendDate" :post.intendDate,
      "insertTime" :DateTime.now(),
      "description" :post.description,
      "imgUrl" :post.imgUrl,
      "forSale" :post.forSale,
      "postCategory":categoryToString(post.postCategory),
      "searchText" : searchText
    });
  }

  Future<List<Post>> getPostToCategory(User user,UserCategory category ) async{
    QuerySnapshot querySnapshot;
    querySnapshot = await postReference
    .where("postCategory",isEqualTo: categoryToString(category))
    .orderBy('intendDate',descending:true)
    .getDocuments();
    List<Post> _postList = await _setPostList(querySnapshot);
    for (var i = 0; i < _postList.length; i++) {
      if(_postList[i].userTelNumber == user.telNumber){
        _postList.removeAt(i);
      }
      
    }
    
    return _postList;
  }

  Future<List<Post>> getPostList(User user) async{
    List<Post> _sortPostList = [];
    List<Post> _postList = [];
    QuerySnapshot querySnapshot;
    querySnapshot = await postReference
    .orderBy('intendDate',descending:true)
    .getDocuments();
    
    _postList = await _setPostList(querySnapshot);
    
    for (var item in _postList) {
      if(item.userTelNumber != user.telNumber){
        _sortPostList.add(item);
      }
    }
    
    return _sortPostList;
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
    if(user.favoritePost.length == 0){
      return [];
    }
    QuerySnapshot querySnapshot;
    querySnapshot = await postReference
    .where('id',whereIn: user.favoritePost)
    .orderBy('intendDate',descending:true)
    .getDocuments();

    return await _setPostList(querySnapshot);

  }

  Future<List<Post>> searchPostList(String searchKey,bool forSale, String userId) async{
    QuerySnapshot querySnapshot;
    List<Post> _postList = [];
    List<Post> _sortPostList = [];

    querySnapshot = await postReference
    .where('searchText',arrayContainsAny: [searchKey.toLowerCase()])
    .where('forSale',isEqualTo: forSale)
    .orderBy('intendDate',descending:true)
    .getDocuments();
    
    _postList = await _setPostList(querySnapshot);
    
    for (var item in _postList) {
      if(item.userTelNumber != userId){
        _sortPostList.add(item);
      }
    }

    _sortPostList.sort((a,b) {
        return b.reviewCount.compareTo(a.reviewCount);
    });
    return _sortPostList;
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

  Future<void> resetClapCount(String userTelNumber)async{
    await users.document(userTelNumber).updateData({
      'clapCount':0
    });
  }

  Future<bool> addClap(List<User> clappedUsers, User newUser,Post post) async{
    List<Map<String,dynamic>> clapListMap =[];

    int clapCount = 0;

    await users.document(post.userTelNumber).get().then((document){
      clapCount = document['clapCount'];
    });

    await users.document(post.userTelNumber).updateData({
      'clapCount':clapCount == null?0:++clapCount
    });


   
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



  Future<bool> updateReview(List<Review> review, User reviewedUser,{bool readAll = false}) async{
    List<Map<String,dynamic>> reviewListMap =[];
   
    for (var item in review) {
      reviewListMap.add(
        {
          "review": item.review,
          "starCount": item.starCount,
          "userTelNumber": item.userTelNumber,
          "userName": item.userName,
          "dateTime": item.dateTime,
          "reply":item.reply,
          "replyTime":item.replyTime,
          "read":readAll? true: item.read,
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
      "email":user.email,
      "profilePicUrl":user.profilePicUrl,
      "address":user.address,
      "description":user.description,
      "userCategory":categoryToString(user.category),
      "productList":user.productList
    });
  }



  Future<List<Post>> _setPostList(QuerySnapshot querySnapshot) async {
    List<Post> postList = [];

    for (var item in querySnapshot.documents) {
      String userTelNumber = item["userTelNumber"];
      

      QuerySnapshot  userDetails = await users
      .where('telNumber',isEqualTo: userTelNumber).
      getDocuments();
      int starCount = 0;

      User user;
      for (var userItem in userDetails.documents) {
        user = User();
        user.reviewList = [];
        user.profilePicUrl  =userItem['profilePicUrl'];
        user.name = userItem['name'];
        user.telNumber = item["userTelNumber"];
        if(userItem["reviewList"] != null){
          for (var itemReviewList in userItem["reviewList"]) {
            starCount += itemReviewList['starCount'];
            Timestamp dateTime = itemReviewList['dateTime'];
            Timestamp replyTime = itemReviewList['replyTime'];
            user.reviewList.add(
              Review()
              ..id = itemReviewList['id']
              ..review = itemReviewList['review']
              ..starCount = itemReviewList['starCount']
              ..userTelNumber = itemReviewList['userTelNumber']
              ..userName = itemReviewList['userName']
              ..dateTime = DateTime.fromMillisecondsSinceEpoch(dateTime.millisecondsSinceEpoch) 
              ..reply = itemReviewList['reply']
              ..read = itemReviewList['read']
              ..replyTime = replyTime == null? null: DateTime.fromMillisecondsSinceEpoch(replyTime.millisecondsSinceEpoch) 
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
        ..imgUrl = item["imgUrl"].cast<String>()
        ..clapUser = clapUser
        ..forSale = item["forSale"]
        ..user = user
        ..postCategory = stringToUserCategory(item["postCategory"])
        ..reviewCount = starCount
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
          Timestamp dateTime = reviewItem['dateTime'];
          Timestamp replyTime = reviewItem['replyTime'];

          review.add(
            Review()
            ..review = reviewItem['review']
            ..starCount = reviewItem['starCount']
            ..userTelNumber = reviewItem['userTelNumber']
            ..userName = reviewItem['userName']
            ..dateTime = DateTime.fromMillisecondsSinceEpoch(dateTime.millisecondsSinceEpoch)
            ..reply = reviewItem['reply']
            ..read = reviewItem['read']
            ..replyTime = replyTime == null? null: DateTime.fromMillisecondsSinceEpoch(replyTime.millisecondsSinceEpoch) 
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
        ..productList=item['productList'].cast<String>()
        ..category = stringToUserCategory(item['category'])
        ..reviewList = review;
    }

    return user;
  }

  Future<MessageHeader> getMessageHeadData(User user,User otherUser) async {
    QuerySnapshot querySnapshot;
    String id;

    if(int.parse(user.telNumber)>int.parse(otherUser.telNumber)){
      id = user.telNumber+otherUser.telNumber;
    }else{
      id = otherUser.telNumber+user.telNumber;
    }

    querySnapshot = await msgReference
    .where('headName',isEqualTo: id )
    .getDocuments();

    if(querySnapshot.documents.length == 0){
      await msgReference.document(id).setData({
        "headName":id,
        "user1":user.telNumber,
        "user2":otherUser.telNumber,
        "user1name":user.name,
        "user2name":otherUser.name,
        "user1ImgUrl":user.profilePicUrl,
        "user2ImgUrl":otherUser.profilePicUrl,
        "user1LastRead":DateTime.now(),
        "user2LastRead":DateTime.now(),
        // "msgCount":0,
        "msgList":[]
      });
    }

    QuerySnapshot chatHeadSnapshot = await msgReference
    .where('headName',isEqualTo: id).
    getDocuments();

    List<MessageHeader> messageHead  = setMessageHeader(chatHeadSnapshot,user);
    return messageHead[0];

  }

  Future<void> sendMsg(List<SingleMessage> msg, String headName) async{
    List<Map<String,dynamic>> msgListMap =[];
   
    for (var item in msg) {
      msgListMap.add(
        {
          "userTelNumber":item.userTelNumber,
          "msg":item.msg,
          "dateTime":item.dateTime,
        }
      );
    }
    await msgReference.document(headName).updateData({
      "msgList":msgListMap
    });
  }

  Future<void> setLastRead(MessageHeader messageHeader, User user) async{
    
    if(messageHeader.user1 == user.telNumber){
      await msgReference.document(messageHeader.headName).updateData({
        "user1LastRead":DateTime.now()
      });
    }else{
      await msgReference.document(messageHeader.headName).updateData({
        "user2LastRead":DateTime.now()
      });
    }
  }

  Future<List<MessageHeader>> getChatHeadList(User user) async{
    List<MessageHeader> messageHeader = [];
    QuerySnapshot querySnapshot = await msgReference
    .where('user1',isEqualTo: user.telNumber)
    .getDocuments();

    messageHeader = setMessageHeader(querySnapshot,user); 

   querySnapshot = await msgReference
    .where('user2',isEqualTo: user.telNumber)
    .getDocuments();

    messageHeader.addAll(
      setMessageHeader(querySnapshot,user)
    );

    return messageHeader; 
  }




  List<MessageHeader> setMessageHeader(QuerySnapshot querySnapshot, User currentUser) {
    List<MessageHeader> messageHeader = [];
    int msgCount = 0;
    for (var item in querySnapshot.documents) {
      List<SingleMessage> msgList = [];

      Timestamp user1LastRead = item['user1LastRead'];
      Timestamp user2LastRead = item['user2LastRead'];

      if(item["msgList"] != null){
        
        DateTime lastRead;
        if(item["user1"] == currentUser.telNumber){
          lastRead = DateTime.fromMillisecondsSinceEpoch(user1LastRead.millisecondsSinceEpoch);
        }
        else if(item["user2"] == currentUser.telNumber){
          lastRead = DateTime.fromMillisecondsSinceEpoch(user2LastRead.millisecondsSinceEpoch);
        }
        
        msgCount = 0;
        for (var msg in item["msgList"]) {
          Timestamp timestamp = msg['dateTime'];
          DateTime dateTime =DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch);
          
          if(dateTime.difference(lastRead).inMilliseconds > 1){
            ++msgCount;
          }

          msgList.add(
            SingleMessage()
            ..msg = msg['msg']
            ..userTelNumber = msg['userTelNumber']
            ..dateTime = dateTime
          );
        }
      }

      

      messageHeader.add(
        MessageHeader()
        ..headName = item["headName"]
        ..user1 = item["user1"]
        ..user2 = item["user2"]
        ..user1name = item["user1name"]
        ..user2name = item["user2name"]
        ..user1ImgUrl = item["user1ImgUrl"]
        ..user2ImgUrl = item["user2ImgUrl"]
        ..user1LastRead = DateTime.fromMillisecondsSinceEpoch(user1LastRead.millisecondsSinceEpoch)
        ..user2LastRead = DateTime.fromMillisecondsSinceEpoch(user2LastRead.millisecondsSinceEpoch)
        ..unreadMsgCount = msgCount
        ..msgList = msgList
      );
        
    }

    return messageHeader;
  }



  

}