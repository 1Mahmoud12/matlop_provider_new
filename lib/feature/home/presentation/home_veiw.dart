import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:matlop_provider/core/component/custom_switcher.dart';
import 'package:matlop_provider/core/network/local/cache.dart';
import 'package:matlop_provider/feature/home/presentation/widgets/home_view_header.dart';
import 'package:matlop_provider/feature/order/presentation/order_view.dart';
import 'package:matlop_provider/feature/order/presentation/widgets/order_list.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  double _pageOffset = 0.0; // Page offset for animation
  late PageController _pageController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(initialPage: _selectedIndex);
    _pageController.addListener(_updatePageOffset); // Listen to page scroll
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const HomeViewHeader(),
          if (userCacheValue?.data?.userTypeId != 4)
            CustomSwitcher(
              selectedIndex: _selectedIndex,
              pageOffset: _pageOffset,
              onSwitcherTapped: _onSwitcherTapped,
            )
          else
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 14),
              //32
              padding: const EdgeInsets.all(10),
              //20
              alignment: AlignmentDirectional.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                border: Border.all(
                  color: Colors.grey.withOpacity(0.2),
                ),
              ),
              child: Text(
                'All available offers'.tr(),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey,
                    ),
              ),
            ),
          if (userCacheValue?.data?.userTypeId != 4)
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });

                  if (_selectedIndex == 1) {
                    // Do something
                  } else {
                    // Do something else
                  }
                },
                itemCount: 2,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: pagesList[index],
                  );
                },
              ),
            )
          else
            const Expanded(
              child: OffersOrderList(),
            ),
          // Adding a space at the bottom of the list
          const SizedBox(height: 100), // Adjust the height as needed
        ],
      ),
    );
  }
}

List<Widget> pagesList = [
  const OrderList(
    status: 0,
  ),
  const SpecialOrderList(
    status: 1,
  ),
];
