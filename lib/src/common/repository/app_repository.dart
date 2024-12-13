

import 'package:flutter/cupertino.dart';

abstract class AppRepository{
  Future<bool> signIn({required Map<String, Object> userData,required BuildContext context});
}