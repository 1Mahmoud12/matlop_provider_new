import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:matlop_provider/core/component/custom_app_bar.dart';
import 'package:matlop_provider/core/network/local/cache.dart';
import 'package:matlop_provider/core/utils/app_icons.dart';
import 'package:matlop_provider/feature/order/presentation/manager/specialrderCubit/special_order_cubit.dart';
import 'package:matlop_provider/feature/order/presentation/widgets/filer_order_dialog.dart';
import 'package:matlop_provider/feature/order/presentation/widgets/filter_special_order_dialog.dart';
import 'package:matlop_provider/feature/order/presentation/widgets/order_list.dart';
import 'package:matlop_provider/feature/order/presentation/widgets/custom_switcher_two.dart';
import 'package:matlop_provider/feature/order/presentation/widgets/special_order_list.dart';

class OrderView extends StatefulWidget {
  const OrderView({super.key});

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  double _pageOffset = 0.0;
  late PageController _pageController;
  int _selectedIndex = 0;
  String _selectedStatus = 'current'.tr();

  final List<Widget> _pagesList = const [
    OrderList(),
    SpecialOrderList(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: _selectedIndex,
    );
    _pageController.addListener(_updatePageOffset);
  }

  @override
  void dispose() {
    _pageController.removeListener(_updatePageOffset);
    _pageController.dispose();
    super.dispose();
  }

  void _updatePageOffset() {
    setState(() {
      _pageOffset = _pageController.page ?? 0;
    });
  }

  void _onSwitcherTapped(int index) {
    setState(() {
      Future.delayed(const Duration(milliseconds: 500), () {
        _selectedIndex = index;
      });
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  void _openFilterDialog() async {
    final bool isCooperate = userCacheValue?.data?.profile?.roleId == 9;
    if (_selectedIndex == 1 || isCooperate) {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return FilterSpecialOrderDialog(
            selectedOrderType: 'special_order'.tr(), // Initial order type
            selectedStatus: _selectedStatus, // Pass the selected status
            onPress: (status, type) {
              SpecialOrderCubit.of(context).getSpecialOrderByStatus(context, status: status + 1, type: type + 1);
            },
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return FilterOrderDialog(
            selectedStatus: _selectedStatus,
            onStatusChanged: (newStatus) {
              setState(() {
                _selectedStatus = newStatus;
              });
            },
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isCooperate = userCacheValue?.data?.profile?.roleId == 9;

    return Scaffold(
      appBar: CustomAppBar(
        title: 'orders'.tr(),
        showArrow: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: _openFilterDialog,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.2),
                          ),
                          shape: BoxShape.circle),
                      child: SvgPicture.asset(AppIcons.filer),
                    ),
                  ),
                ),
                if (!isCooperate)
                  Expanded(
                    flex: 5,
                    child: CustomSwitcherTwo(
                      selectedIndex: _selectedIndex,
                      pageOffset: _pageOffset,
                      onSwitcherTapped: _onSwitcherTapped,
                    ),
                  )
                else
                  const Spacer(flex: 5),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: isCooperate
                  ? const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: SpecialOrderList(),
                    )
                  : PageView.builder(
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
                      itemCount: _pagesList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: _pagesList[index],
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
