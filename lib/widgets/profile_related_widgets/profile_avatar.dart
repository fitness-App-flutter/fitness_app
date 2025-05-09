import 'dart:io';
import 'package:fitness_app/widgets/profile_related_widgets/info_related_widgets/profile_image_cubit/image_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, File?>(
      builder: (context, imageFile) {
        return GestureDetector(
          onTap: () async {
            final picker = ImagePicker();
            final pickedFile = await picker.pickImage(source: ImageSource.gallery);

            if (pickedFile != null) {
              final newImageFile = File(pickedFile.path);
              context.read<ProfileCubit>().changeProfilePicture(newImageFile);
            }
          },
          child: CircleAvatar(
            radius: 50,
            backgroundImage: imageFile != null
                ? FileImage(imageFile)
                : const AssetImage('assets/images/user_icon.jpg'),
          ),
        );
      },
    );
  }
}