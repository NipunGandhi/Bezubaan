import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math' show cos, sqrt, asin;
import 'dart:convert';

calculateDistance(lat1, lon1, lat2, lon2) {
  var p = 0.017453292519943295;
  var c = cos;
  var a = 0.5 -
      c((lat2 - lat1) * p) / 2 +
      c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
  return 12742 * asin(sqrt(a));
}

getData(double userlatitude, double userlongitude) async {
  var snaps = await FirebaseFirestore.instance.collection("posts").get();
  List<Map> abc = [];
  for (var queryDocumentSnapshot in snaps.docs) {
    Map<String, dynamic> data = queryDocumentSnapshot.data();
    var description = data["description"];
    var creatorName = data["creatorName"];
    var emailId = data["emailId"];
    var creatorId = data["creatorId"];
    var timeOfPost = data["timeOfPost"].toDate();
    var creatorImage = data["creatorImage"];
    var imageUrl = data["imageUrl"];
    var phoneNumber = data["phoneNumber"];
    var longitude = data["longitude"];
    var latitude = data["latitude"];
    var locationData = calculateDistance(userlatitude, userlongitude,
        double.parse(latitude), double.parse(longitude));

    Map newData = {
      "description": description,
      "creatorName": creatorName,
      "emailId": emailId,
      "creatorId": creatorId,
      "creatorImage": creatorImage,
      "imageUrl": imageUrl,
      "phoneNumber": phoneNumber,
      "longitude": longitude,
      "latitude": latitude,
      "locationData": locationData,
      "timeOfPost": timeOfPost
    };
    abc.add(newData);
  }
  abc.sort((a, b) => (a['locationData']).compareTo(b['locationData']));
  return abc;
}
