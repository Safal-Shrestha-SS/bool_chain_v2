import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  GeoPoint position;
  String userId,
      userName,
      userProfilePicture,
      userBio,
      userGender,
      userAddress,
      userEmail;
  List<String> userHonor;
  double userNumber, userRating;
  List<String> userBooks;
  Users(
      {this.userAddress,
      this.userBio,
      this.userBooks,
      this.userEmail,
      this.userGender,
      this.userId,
      this.position,
      this.userName,
      this.userNumber,
      this.userHonor,
      this.userProfilePicture,
      this.userRating});
}
