import 'user_model.dart';
import 'package:loginpage/user_data_model/personal_data.dart';


class CurrentUserSingleton {
  CurrentUserSingleton._internal();

 
  static final CurrentUserSingleton _instance = CurrentUserSingleton._internal();
 
  factory CurrentUserSingleton() => _instance;

  UserModel? _user;
  PersonalData? _personaldata;

  UserModel? get currentuser => _user;
  PersonalData? get personaldata => _personaldata;

  void setUser(UserModel currentuser) {
    _user = currentuser;
  }
  void setPersonaldata(PersonalData data){
    _personaldata = data;
  }

  void clearUser() {
    _user = null;
    _personaldata = null;
  }

  bool get isLoggedIn => _user != null;
}
