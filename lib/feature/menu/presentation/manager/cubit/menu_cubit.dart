import 'dart:developer';
import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

part 'menu_state.dart';

class MenuCubit extends Cubit<MenuState> {
  MenuCubit() : super(MenuInitial());
  static MenuCubit of(BuildContext context) => BlocProvider.of(context);
  void whatsapp() async {
    const contact = '+201008526282';
    const androidUrl = 'whatsapp://send?phone=$contact&text=Hi, I need some help';
    final iosUrl = "https://wa.me/$contact?text=${Uri.parse('Hi, I need some help')}";

    try {
      if (Platform.isIOS) {
        await launchUrl(Uri.parse(iosUrl));
      } else {
        await launchUrl(Uri.parse(androidUrl));
      }
    } on Exception {
      log('WhatsApp is not installed.');
    }
  }

  void shareApp() {
    const appLink = 'https://yourappstorelink.com'; // Replace with your app link
    Share.share(
      'Check out this amazing app: $appLink',
      subject: 'Share Our App!',
    );
  }
}
