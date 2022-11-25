
import 'package:hive/hive.dart';

part 'ourUser.g.dart';


@HiveType(typeId: 123, adapterName: "OurUserDetailOriginal")
class OurUser {

  @HiveField(0)
  String ?uid;

  @HiveField(1)
  String ?email;

  @HiveField(2)
  String ?name;

  @HiveField(3)
  String ?phone;

  @HiveField(4)
  String ?description;

  @HiveField(5)
  String ?userName;

  @HiveField(6)
  String ?imageLink;

  String ?filePath;
  OurUser({
    this.description,
    this.email,
    this.name,
    this.uid,this.phone,this.userName,
    this.filePath,this.imageLink,
  });


  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "email": email,
      "name":name,
      "phone":phone,
      "description":description,
      "userName":userName,
      "filePath":filePath,
      "imageLink":imageLink,
    };
  }


  /// from the map to convert the data back into the normal form
  factory OurUser.fromJson(Map<String, dynamic> data) {
    return OurUser(
      uid: data['uid'],
      email: data['email'],
      name: data["name"],
      description: data["description"],
      phone: data["phone"],
      userName: data["userName"],
      filePath: data["filePath"],
      imageLink: data["imageLink"]
    );
  }
}