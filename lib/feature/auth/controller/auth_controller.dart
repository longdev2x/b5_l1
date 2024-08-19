import 'package:exercies4/common/components/app_dialog.dart';
import 'package:exercies4/common/components/loader_provider.dart';
import 'package:exercies4/common/data/model/user_entity.dart';
import 'package:exercies4/common/routes/app_route_name.dart';
import 'package:exercies4/feature/auth/repo/auth_repos.dart';
import 'package:exercies4/global.dart';
import 'package:exercies4/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthController {
  static void signUp(
      {required WidgetRef ref,
      required String email,
      required String pass}) async {
    try {
      ref.read(isLoaderProvider.notifier).state = true;
      UserCredential userCredential =
          await AuthRepos.signUp(email: email, pass: pass);

      String? userId = userCredential.user?.uid;
      if (userId == null) return;
      Global.storageService.setUserId(userId);

      UserEntity objUser = UserEntity(uid: userId, email: email);
      await AuthRepos.setUserInfor(objUser);

      navKey.currentState?.pushNamed(AppRouteName.application);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "email-already-in-use":
          AppToast.showToast("Email đã được sử dụng");
          break;
        case "invalid-email":
          AppToast.showToast("Email không hợp lệ");
          break;
        case "weak-password":
          AppToast.showToast("Mật khẩu chưa đủ mạnh");
          break;
        case "operation-not-allowed":
          if (kDebugMode) {
            print("Chưa bật email-pass trên Firebase");
          }
          break;
        default:
          AppToast.showToast("Có lỗi gì đó");
      }
    } finally {
      ref.read(isLoaderProvider.notifier).state = false;
    }
  }



  static void signIn({
    required String email,
    required String password,
    required WidgetRef ref,
  }) async {
    ref.read(isLoaderProvider.notifier).state = true;
    try {
      UserCredential userCredential = await AuthRepos.signIn(
        email: email,
        pass: password,
      );
      User? user = userCredential.user;
      if (user == null) {
        AppToast.showToast('Kiểm tra lại tài khoản');
        return;
      }
      
      UserEntity? objUser = await AuthRepos.getUserInfor(user.uid);
      if(objUser == null) {
        objUser = UserEntity(uid: user.uid, email: email);
        await AuthRepos.setUserInfor(objUser);
      }
      navKey.currentState!.pushNamed(AppRouteName.application);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "user-disabled":
          AppToast.showToast("Tài khoản bị vô hiệu hoá");
          break;
        case "invalid-email":
          AppToast.showToast("Email không hợp lệ");
          break;
        case "user-not-found":
          AppToast.showToast("Email chưa đăng ký");
          break;
        case "wrong-password":
          AppToast.showToast("Sai mật khẩu");
          break;
        default:
          AppToast.showToast("Vui lòng kiểm tra lại");
      }
    } finally {
      ref.read(isLoaderProvider.notifier).state = false;
    }
  }
}
