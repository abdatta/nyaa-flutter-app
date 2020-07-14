import 'package:nyaa_app/shared/models/item-type.model.dart';

class NyaaComment {
  String user;
  NyaaItemType
      userType; // Todo: Find all user types and create a separate class for NyaaUserType
  String avatar;
  String date;
  String body;

  NyaaComment({this.user, this.userType, this.avatar, this.date, this.body});
}
