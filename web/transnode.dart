library transnode;

import 'package:angular/angular.dart';
import 'package:di/di.dart';


import 'package:transnode/routes/transnode_routes.dart' show TransnodeRouter;

import 'package:transnode/controllers/app_controller.dart';
import 'package:transnode/controllers/login_controller.dart';

import 'package:transnode/services/api_service.dart';
import 'package:transnode/services/user_service.dart';

@MirrorsUsed(override: '*')
import 'dart:mirrors';


class TransnodeModule extends Module {
  TransnodeModule() {
    type(RouteInitializer, implementedBy: TransnodeRouter);
    type(AppController);
    type(LoginController);
    type(User);
    type(ApiService);
    factory(NgRoutingUsePushState,
            (_) => new NgRoutingUsePushState.value(false));
  }
}

void main() {
  ngBootstrap(module: new TransnodeModule());
}