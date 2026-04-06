import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matlop_provider/core/component/custom_app_bar.dart';
import 'package:matlop_provider/core/themes/colors.dart';
import 'package:matlop_provider/feature/menu/views/myCities/manager/cities_cubit.dart';
import 'package:matlop_provider/feature/menu/views/myCities/presentation/widgets/cities_save_button.dart';
import 'package:matlop_provider/feature/menu/views/myCities/presentation/widgets/cities_search_bar.dart';
import 'package:matlop_provider/feature/menu/views/myCities/presentation/widgets/cities_skeleton.dart';
import 'package:matlop_provider/feature/menu/views/myCities/presentation/widgets/city_list_tile.dart';

class MyCitiesView extends StatefulWidget {
  const MyCitiesView({super.key});

  @override
  State<MyCitiesView> createState() => _MyCitiesViewState();
}

class _MyCitiesViewState extends State<MyCitiesView>
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
    context.read<CitiesCubit>().loadCities().then((_) {
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
      appBar: CustomAppBar(title: 'My Cities'.tr()),
      body: BlocConsumer<CitiesCubit, CitiesState>(
        listener: (context, state) {
          if (state is CitiesUpdateSuccess) {
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          final cubit = CitiesCubit.of(context);

          if (state is CitiesLoading) {
            return const CitiesSkeleton();
          }

          if (state is CitiesError) {
            return _buildError(state.message, cubit);
          }

          final filtered = cubit.allCities
              .where((c) =>
                  c.enName.toLowerCase().contains(_searchQuery) ||
                  c.arName.toLowerCase().contains(_searchQuery) ||
                  c.shortCut.toLowerCase().contains(_searchQuery))
              .toList();

          final myCities = cubit.allCities
              .where((c) => cubit.selectedCityIds.contains(c.cityId))
              .toList();

          return Stack(
            children: [
              CustomScrollView(
                slivers: [
                  // ── Search bar ───────────────────────────────────────────
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
                      child: CitiesSearchBar(
                        controller: _searchController,
                        onChanged: (val) => setState(() => _searchQuery = val.toLowerCase()),
                      ),
                    ),
                  ),

                  // ── My Cities section ────────────────────────────────────
                  if (_searchQuery.isEmpty && myCities.isNotEmpty) ...[
                    SliverToBoxAdapter(
                      child: _SectionHeader(
                        label: 'My Cities'.tr(),
                        count: myCities.length,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (_, i) => CityListTile(
                          city: myCities[i],
                          isSelected: true,
                          onTap: () => cubit.toggleCity(myCities[i].cityId),
                        ),
                        childCount: myCities.length,
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

                  // ── All Cities section ───────────────────────────────────
                  SliverToBoxAdapter(
                    child: _SectionHeader(
                      label: _searchQuery.isEmpty
                          ? 'All Cities'.tr()
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
                                final city = filtered[i];
                                final selected =
                                    cubit.selectedCityIds.contains(city.cityId);
                                return CityListTile(
                                  city: city,
                                  isSelected: selected,
                                  onTap: () => cubit.toggleCity(city.cityId),
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
                  child: CitiesSaveButton(
                    isLoading: state is CitiesUpdateLoading,
                    hasChanges: cubit.hasChanges,
                    onSave: () => cubit.saveCities(),
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
  Widget _buildError(String message, CitiesCubit cubit) {
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
            onPressed: cubit.loadCities,
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
            Text('No cities found'.tr(),
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
