import 'package:get_it/get_it.dart';
import 'package:google_firebase/google_firebase.dart';
import 'package:platform_interface/domain_platform.dart';

class GetFirebaseProfileUsecase implements UsecasePlatform {
  final FirebaseAuth _firebaseAuth;

  GetFirebaseProfileUsecase(GetIt locator) : _firebaseAuth = locator();

  User? execute() => _firebaseAuth.currentUser;

  @override
  Future<void> register(GetIt locator) async {
    locator.registerFactory(() => this);
  }
}
