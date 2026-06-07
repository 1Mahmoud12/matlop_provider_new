import 'dart:developer';
import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:matlop_provider/core/component/loading_widget.dart';
import 'package:matlop_provider/core/utils/utils.dart';
import 'package:matlop_provider/feature/menu/data/dataSources/settings_data_source.dart';

part 'menu_state.dart';

class MenuCubit extends Cubit<MenuState> {
  MenuCubit() : super(MenuInitial());
  static MenuCubit of(BuildContext context) => BlocProvider.of(context);
  void whatsapp(BuildContext context) async {
    animationDialogLoading(context);
    final result = await SettingsDataSource.getSettings();
    if (context.mounted) closeDialog(context);
    result.fold((l) {
      Utils.showToast(title: l.errMessage, state: UtilState.error);
    }, (r) async {
      final contact = r.data?.whatsAppNumber ?? '+96650021622';
      final androidUrl = 'whatsapp://send?phone=$contact&text=Hi, I need some help';
      final iosUrl = "https://wa.me/$contact?text=${Uri.parse('Hi, I need some help')}";

      try {
        if (Platform.isIOS) {
          await launchUrl(Uri.parse(iosUrl));
        } else {
          await launchUrl(Uri.parse(androidUrl));
        }
      } on Exception {
        log('WhatsApp is not installed.');
        Utils.showToast(title: 'WhatsApp is not installed.', state: UtilState.error);
      }
    });
  }

  void shareApp() {
    const appLink = 'https://yourappstorelink.com'; // Replace with your app link
    Share.share(
      'Check out this amazing app: $appLink',
      subject: 'Share Our App!',
    );
  }
}
