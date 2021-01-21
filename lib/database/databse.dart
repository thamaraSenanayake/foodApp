import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_app/model/user.dart';

class Database{
  
  String serverKey = "AAAA7_a4a9I:APA91bH_M8-EDOKRrAk2f1lPlSJlt7n4QVMUMOgfehJTImv02BshcbRC3vs8_Uwq16JLa9wgQfDgcuKUwvSA5FFxP4cmluOKGPSqbXsdP-eOFbQOCtYOEdyoVJdTyJJzjdo670JamoPH";
  
  //collection reference 
  
  final CollectionReference users = Firestore.instance.collection('user');
  final CollectionReference food = Firestore.instance.collection('food');
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

}