import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matlop_provider/core/component/custom_app_bar.dart';
import 'package:matlop_provider/core/themes/colors.dart';
import 'package:matlop_provider/feature/menu/views/myServices/manager/services_cubit.dart';
import 'package:matlop_provider/feature/menu/views/myServices/presentation/widgets/services_save_button.dart';
import 'package:matlop_provider/feature/menu/views/myServices/presentation/widgets/services_search_bar.dart';
import 'package:matlop_provider/feature/menu/views/myServices/presentation/widgets/services_skeleton.dart';
import 'package:matlop_provider/feature/menu/views/myServices/presentation/widgets/service_list_tile.dart';

class MyServicesView extends StatefulWidget {
  const MyServicesView({super.key});

  @override
  State<MyServicesView> createState() => _MyServicesViewState();
}

class _MyServicesViewState extends State<MyServicesView>
    with SingleTickerProviderStateMixin {
  late AnimationController _fabController;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _fabController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    context.read<ServicesCubit>().loadServices().then((_) {
      _fabController.forward();
    });
    _searchController.addListener(() {
      setState(() => _searchQuery = _searchController.text.toLowerCase());
    });
  }

  @override
  void dispose() {
    _fabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackGround,
      appBar: CustomAppBar(title: 'My Services'.tr()),
      body: BlocConsumer<ServicesCubit, ServicesState>(
        listener: (context, state) {
          if (state is ServicesUpdateSuccess) {
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          final cubit = ServicesCubit.of(context);

          if (state is ServicesLoading) {
            return const ServicesSkeleton();
          }

          if (state is ServicesError) {
            return _buildError(state.message, cubit);
          }

          final filtered = cubit.allServices
              .where((s) =>
                  s.enName.toLowerCase().contains(_searchQuery) ||
                  s.arName.toLowerCase().contains(_searchQuery))
              .toList();

          final myServices = cubit.allServices
              .where((s) => cubit.selectedServiceIds.contains(s.serviceId))
              .toList();

          return Stack(
            children: [
              CustomScrollView(
                slivers: [
                  // ── Search bar ───────────────────────────────────────────
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
                      child: ServicesSearchBar(
                        controller: _searchController,
                        onChanged: (val) =>
                            setState(() => _searchQuery = val.toLowerCase()),
                      ),
                    ),
                  ),

                  // ── My Services section ──────────────────────────────────
                  if (_searchQuery.isEmpty && myServices.isNotEmpty) ...[
                    SliverToBoxAdapter(
                      child: _SectionHeader(
                        label: 'My Services'.tr(),
                        count: myServices.length,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (_, i) => ServiceListTile(
                          service: myServices[i],
                          isSelected: true,
                          onTap: () => cubit.toggleService(myServices[i].serviceId),
                        ),
                        childCount: myServices.length,
                      ),
                    ),
                    const SliverToBoxAdapter(child: SizedBox(height: 12)),
                    const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Divider(color: AppColors.cBorderDecoration),
                      ),
                    ),
                  ],

                  // ── All Services section ─────────────────────────────────
                  SliverToBoxAdapter(
                    child: _SectionHeader(
                      label: _searchQuery.isEmpty
                          ? 'All Services'.tr()
                          : 'Search Results'.tr(),
                      count: filtered.length,
                      color: AppColors.cBoldTextColor,
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.only(bottom: 100),
                    sliver: filtered.isEmpty
                        ? SliverToBoxAdapter(child: _buildEmpty())
                        : SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (_, i) {
                                final service = filtered[i];
                                final selected = cubit.selectedServiceIds
                                    .contains(service.serviceId);
                                return ServiceListTile(
                                  service: service,
                                  isSelected: selected,
                                  onTap: () =>
                                      cubit.toggleService(service.serviceId),
                                );
                              },
                              childCount: filtered.length,
                            ),
                          ),
                  ),
                ],
              ),

              // ── Save FAB ──────────────────────────────────────────────────
              Positioned(
                bottom: 24,
                left: 16,
                right: 16,
                child: ScaleTransition(
                  scale: _fabController,
                  child: ServicesSaveButton(
                    isLoading: state is ServicesUpdateLoading,
                    hasChanges: cubit.hasChanges,
                    onSave: () => cubit.saveServices(),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // ── Error ──────────────────────────────────────────────────────────────────
  Widget _buildError(String message, ServicesCubit cubit) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.cloud_off_rounded,
              size: 64, color: AppColors.cDisablePrimaryColor),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.subTextColor),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: cubit.loadServices,
            icon: const Icon(Icons.refresh_rounded),
            label: Text('Retry'.tr()),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ],
      ),
    );
  }

  // ── Empty state ────────────────────────────────────────────────────────────
  Widget _buildEmpty() {
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: Center(
        child: Column(
          children: [
            const Icon(Icons.search_off_rounded,
                size: 56, color: AppColors.cDisablePrimaryColor),
            const SizedBox(height: 8),
            Text('No services found'.tr(),
                style: const TextStyle(color: AppColors.subTextColor)),
          ],
        ),
      ),
    );
  }
}

// ── Section Header ──────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  final String label;
  final int count;
  final Color color;

  const _SectionHeader({
    required this.label,
    required this.count,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 18,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
          ),
          const SizedBox(width: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '$count',
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
