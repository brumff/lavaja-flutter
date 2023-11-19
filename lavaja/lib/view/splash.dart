import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:lavaja/data/prefs_service.dart';

import '../routes/app_routes.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => __SplashState();
}

class __SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    redirecionar();
  }

  Future<void> redirecionar() async {
    // bool auth = false;
    // try {
    //   bool auth = (await PrefsService.isAuth()) ?? false;
    //   print(auth);
    // } catch (e) {}

    // if (auth == true) {
      
      var token = await PrefsService.getToken();
     
      if (token != null) {
        var decodedToken = JwtDecoder.decode(token);
        if (decodedToken.containsKey('profile')) {
          var userProfile = decodedToken['profile'];
          if (userProfile == 'ROLE_LAVACAR') {
            Modular.to.pushReplacementNamed(AppRoutes.HOMELAVACAR);
          } else if (userProfile == 'ROLE_DONOCARRO') {
            Modular.to.pushReplacementNamed(AppRoutes.HOMEDONOCARRO);
          } else {
            Modular.to.pushReplacementNamed(AppRoutes.LOGIN);
          }
        }
      } else {
        Modular.to.pushReplacementNamed(AppRoutes.LOGIN);
      }
    // } else {
    //   Modular.to.pushReplacementNamed(AppRoutes.LOGIN);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.5,
          child: Image.asset('assets/images/icone_carro.png'),
        ),
      ),
    );
  }
}
