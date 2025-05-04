import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
class ProfileCubit extends Cubit<File?> {
  ProfileCubit() : super(null);

  void changeProfilePicture(File imageFile) {
    emit(imageFile);
  }
}
