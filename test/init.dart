library transnodeTest;

import 'package:unittest/unittest.dart';
import 'package:dartmocks/dartmocks.dart';
import 'dart:async';
import 'dart:html' as html;

import 'package:angular/angular.dart';
import 'package:angular/mock/module.dart';

import 'package:transnode/transnode.dart';

part 'services/api_service.dart';
part 'models/customer.dart';

main(){
  testCustomer();
}