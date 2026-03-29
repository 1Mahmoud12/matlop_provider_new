import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:matlop_provider/core/component/cache_image.dart';
import 'package:matlop_provider/core/utils/app_icons.dart';
import 'package:matlop_provider/core/utils/app_images.dart';
import 'package:matlop_provider/feature/menu/views/editProfile/manager/profile_cubit.dart'; // Add this

class EditProfileImage extends StatefulWidget {
  final UpdateProfileCubit updateProfileCubit;

  const EditProfileImage({super.key, required this.updateProfileCubit});

  @override
  State<EditProfileImage> createState() => _EditProfileImageState();
}

class _EditProfileImageState extends State<EditProfileImage> {
  // Function to pick an image
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        widget.updateProfileCubit.imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topLeft,
      children: [
        BlocProvider.value(
          value: widget.updateProfileCubit,
          child: BlocBuilder<UpdateProfileCubit, UpdateProfileState>(
            builder: (context, state) {
              return ClipOval(
                child: widget.updateProfileCubit.imageFile != null
                    ? Image.file(
                        widget.updateProfileCubit.imageFile!,
                        fit: BoxFit.cover,
                        width: 100,
                        height: 100,
                      )
                    : widget.updateProfileCubit.urlImage != ''
                        ? CacheImage(
                            imageUrl: widget.updateProfileCubit.urlImage,
                            width: 100,
                            height: 100,
                          )
                        : Image.asset(
                            AppImages.avatar,
                            fit: BoxFit.cover,
                            width: 100,
                            height: 100,
                          ),
              );
            },
          ),
        ),
        GestureDetector(
          onTap: _pickImage, // Trigger image picker when edit icon is clicked
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 5,
                  color: Colors.grey.withOpacity(0.2),
                ),
              ],
            ),
            padding: const EdgeInsets.all(5),
            child: SvgPicture.asset(AppIcons.editIcon),
          ),
        ),
      ],
    );
  }
}
