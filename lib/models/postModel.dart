import 'dart:io';

class PostModel {
  String? creatorId;

  String? imageUrl;
  String? creatorImage;
  DateTime? timeOfPost;

  String? creatorName;

  Map<String, dynamic>? locationData;

  String? description;

  String? emailId;
  String? phoneNumber;

  File? imageFile;
  String? latitude;
  String? longitude;

  PostModel({
    this.description,
    this.creatorName,
    this.creatorId,
    this.emailId,
    this.locationData,
    this.timeOfPost,
    this.imageUrl,
    this.creatorImage,
    this.imageFile,
    this.phoneNumber,
    this.longitude,
    this.latitude,
  });

  Map<String, dynamic> toJson() {
    return {
      "creatorId": creatorId,
      "description": description,
      "emailId": emailId,
      "locationData": locationData,
      "timeOfPost": timeOfPost,
      "creatorName": creatorName,
      "imageUrl": imageUrl,
      "creatorImage": creatorImage,
      "phoneNumber": phoneNumber,
      "longitude": longitude,
      "latitude": latitude,
    };
  }

  /// from the map to convert the data back into the normal form
  factory PostModel.fromJson(Map<String, dynamic> data) {
    return PostModel(
      description: data["description"],
      creatorName: data["creatorName"],
      emailId: data["emailId"],
      creatorId: data["creatorId"],
      locationData: data["locationData"],
      timeOfPost: data["timeOfPost"].toDate(),
      creatorImage: data["creatorImage"],
      imageUrl: data["imageUrl"],
      phoneNumber: data["phoneNumber"],
      longitude: data["longitude"],
      latitude: data["latitude"],
    );
  }

  String getPostCreatedDuration() {
    if (DateTime.now().difference(timeOfPost!).inSeconds < 60) {
      return '${DateTime.now().difference(this.timeOfPost!).inSeconds} Seconds Ago';
    } else if (DateTime.now().difference(this.timeOfPost!).inMinutes < 60) {
      return '${DateTime.now().difference(this.timeOfPost!).inMinutes} Minutes Ago';
    } else if (DateTime.now().difference(this.timeOfPost!).inHours < 24) {
      return '${DateTime.now().difference(this.timeOfPost!).inHours} Hours Ago';
    } else if (DateTime.now().difference(this.timeOfPost!).inDays < 30) {
      return '${DateTime.now().difference(this.timeOfPost!).inDays} Days Ago';
    } else if (DateTime.now().difference(this.timeOfPost!).inDays < 365) {
      return '${DateTime.now().difference(this.timeOfPost!).inDays ~/ 30} Months Ago';
    } else {
      return '${DateTime.now().difference(this.timeOfPost!).inDays ~/ 365} Years Ago';
    }
  }
}
