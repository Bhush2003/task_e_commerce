import 'package:hive/hive.dart';

import '../repository/auth/model/user.dart';

class SingleToneHiveObject {

  get userBox=>()async{return await Hive.openBox<User>('User_Box');};
}