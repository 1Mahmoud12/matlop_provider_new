import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:matlop_provider/core/component/custom_app_bar.dart';
import 'package:matlop_provider/core/component/loading_widget.dart';
import 'package:matlop_provider/core/themes/colors.dart';
import 'package:matlop_provider/core/utils/app_icons.dart';
import 'package:matlop_provider/core/utils/constant_model.dart';
import 'package:matlop_provider/feature/home/presentation/widgets/special_order_card.dart';
import 'package:matlop_provider/feature/order/presentation/manager/offersCubit/offers_order_cubit.dart';
import 'package:matlop_provider/feature/order/presentation/manager/specialrderCubit/special_order_cubit.dart';
import 'package:matlop_provider/feature/order/presentation/widgets/empty_orders.dart';
import 'package:matlop_provider/feature/order/presentation/widgets/filer_order_dialog.dart';
import 'package:matlop_provider/feature/order/presentation/widgets/filter_special_order_dialog.dart';
import 'package:matlop_provider/feature/order/presentation/widgets/order_list.dart';

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
    if (_selectedIndex == 1) {
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
                Expanded(
                  flex: 5,
                  child: CustomSwitcherTwo(
                    selectedIndex: _selectedIndex,
                    pageOffset: _pageOffset,
                    onSwitcherTapped: _onSwitcherTapped,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                itemCount: 2,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: pagesList[index],
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

List<Widget> pagesList = [
  const OrderList(),
  const SpecialOrderList(),
];

class CustomSwitcherTwo extends StatelessWidget {
  final int selectedIndex;
  final double pageOffset;
  final Function(int) onSwitcherTapped;

  const CustomSwitcherTwo({
    super.key,
    required this.selectedIndex,
    required this.pageOffset,
    required this.onSwitcherTapped,
  });

  double getAnimationWidth(BuildContext context, double pageOffset) {
    final double screenWidth = MediaQuery.sizeOf(context).width;
    final double segmentWidth = screenWidth * 0.3;
    final double spacing = screenWidth * 0.05;

    return (spacing + segmentWidth) * pageOffset;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10), //20
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        border: Border.all(
          color: Colors.grey.withOpacity(0.2),
        ),
      ),
      child: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            curve: Curves.fastLinearToSlowEaseIn,
            left: context.locale.languageCode == 'en' ? getAnimationWidth(context, pageOffset) : null,
            right: context.locale.languageCode == 'en' ? null : getAnimationWidth(context, pageOffset),
            top: 0,
            bottom: 0,
            child: Container(
              width: MediaQuery.sizeOf(context).width * 0.35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(35),
                color: AppColors.primaryColor,
              ),
            ),
          ),
          Row(
            children: List.generate(
              2,
              (index) {
                return Expanded(
                  child: InkWell(
                    overlayColor: const WidgetStatePropertyAll(Colors.transparent),
                    onTap: () {
                      onSwitcherTapped(index);
                    },
                    child: Container(
                      height: 40,
                      padding: const EdgeInsets.all(10),
                      child: Center(
                        child: Text(
                          index == 0 ? 'Order'.tr() : 'Special Order'.tr(),
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: selectedIndex == index ? Colors.white : Colors.grey,
                              ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SpecialOrderList extends StatefulWidget {
  final int? status;
  final int? type;

  const SpecialOrderList({super.key, this.status, this.type});

  @override
  State<SpecialOrderList> createState() => _SpecialOrderListState();
}

class _SpecialOrderListState extends State<SpecialOrderList> {
  @override
  void initState() {
    SpecialOrderCubit.of(context).getSpecialOrderByStatus(context, status: widget.status, type: widget.type);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpecialOrderCubit, SpecialOrderState>(
      buildWhen: (previousState, currentState) {
        return currentState is SpecialOrderLoading || currentState is SpecialOrderError || currentState is SpecialOrderSuccess;
      },
      builder: (context, state) {
        if (state is SpecialOrderLoading && ConstantModel.specialOrdersModel == null) {
          return const Center(child: LoadingWidget());
        } else if (state is SpecialOrderError) {
          return const EmptyOrders();
        } else if (ConstantModel.specialOrdersModel != null) {
          if (ConstantModel.specialOrdersModel!.data == null) {
            return const EmptyOrders();
          }
          return ListView.builder(
            itemCount: ConstantModel.specialOrdersModel?.data?.length ?? 0,
            itemBuilder: (context, index) {
              return SpecialOrderCard(
                itemSpecialOrder: ConstantModel.specialOrdersModel!.data![index],
              );
            },
          );
        }
        return const SizedBox();
      },
    );
  }
}

class OffersOrderList extends StatefulWidget {
  const OffersOrderList({super.key});

  @override
  State<OffersOrderList> createState() => _OffersOrderListListState();
}

class _OffersOrderListListState extends State<OffersOrderList> {
  final OffersOrderCubit offersOrderCubit = OffersOrderCubit();

  @override
  void initState() {
    offersOrderCubit.getOffersOrderByStatus(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: offersOrderCubit,
      child: BlocBuilder<OffersOrderCubit, OffersOrderState>(
        buildWhen: (previousState, currentState) {
          return currentState is OffersOrderLoading || currentState is OffersOrderError || currentState is OffersOrderSuccess;
        },
        builder: (context, state) {
          if (state is OffersOrderLoading && ConstantModel.offersModel == null) {
            return const Center(child: LoadingWidget());
          } else if (state is OffersOrderError) {
            return const EmptyOrders();
          } else if (ConstantModel.offersModel != null) {
            if (ConstantModel.offersModel!.data == null) {
              return const EmptyOrders();
            }
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: ConstantModel.offersModel?.data?.length ?? 0,
              itemBuilder: (context, index) {
                return (ConstantModel.offersModel!.data![index].isNew ?? false)
                    ? SpecialOrderCard(
                        itemSpecialOrder: ConstantModel.offersModel!.data![index],
                        offersOrderCubit: offersOrderCubit,
                      )
                    : const SizedBox.shrink();
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
