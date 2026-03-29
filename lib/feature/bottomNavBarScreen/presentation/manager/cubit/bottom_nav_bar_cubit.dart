import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matlop_provider/feature/chat/presentation/chat_screen.dart';
import 'package:matlop_provider/feature/home/presentation/home_veiw.dart';
import 'package:matlop_provider/feature/menu/presentation/menu_view.dart';
import 'package:matlop_provider/feature/order/presentation/order_view.dart';
part 'bottom_nav_bar_state.dart';

class BottomNavBarCubit extends Cubit<BottomNavBarState> {
  BottomNavBarCubit() : super(BottomNavBarInitial());

  static BottomNavBarCubit of(BuildContext context) => BlocProvider.of<BottomNavBarCubit>(context);

  List<Widget> screenList = [
    const HomeView(),
    const OrderView(),
    const ChatScreen(),
    const MenuView(),
  ];
}
