import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matlop_provider/core/network/local/cache.dart';
import 'package:matlop_provider/core/utils/utils.dart';
import 'package:matlop_provider/feature/menu/views/editProfile/data/dataSource/update_profile_data_source.dart';
import 'package:matlop_provider/feature/menu/views/editProfile/data/models/profile_model.dart';
import 'package:matlop_provider/feature/menu/views/myServices/data/models/technical_service_model.dart';
import 'package:matlop_provider/feature/menu/views/myServices/data/services_data_source.dart';

part 'services_state.dart';

class ServicesCubit extends Cubit<ServicesState> {
  ServicesCubit() : super(ServicesInitial());

  static ServicesCubit of(BuildContext context) => BlocProvider.of(context);

  final ServicesDataSourceInterface _servicesDataSource = ServicesDataSource();
  final UpdateProfileDataSourceInterface _profileDataSource = UpdateProfileDataSource();

  /// All services available from the API.
  List<TechnicalServiceData> allServices = [];

  /// Service IDs currently selected for this technical (seeded from profile).
  Set<int> selectedServiceIds = {};

  /// Returns true if the selection differs from what the profile last reported.
  bool get hasChanges {
    final original = Set<int>.from(
      (profileCacheValue?.data?.services ?? []).map((s) => s.serviceId),
    );
    return !_setsEqual(selectedServiceIds, original);
  }

  bool _setsEqual(Set<int> a, Set<int> b) => a.length == b.length && a.containsAll(b);

  // ── Load ──────────────────────────────────────────────────────────────────

  /// Fetches the profile AND all services concurrently so that user's services
  /// are always pre-selected even if edit-profile was never visited.
  Future<void> loadServices() async {
    emit(ServicesLoading());

    final userId = userCacheValue?.data?.userId ?? -1;

    final futureServices = _servicesDataSource.getAllServices();
    final futureProfile = _profileDataSource.getProfile(userId: userId);

    final servicesResult = await futureServices;
    final profileResult = await futureProfile;

    // Apply profile services (either freshly fetched or from cache fallback)
    profileResult.fold(
      (_) {
        // Profile fetch failed – fall back to whatever is already cached
        selectedServiceIds = Set<int>.from(
          (profileCacheValue?.data?.services ?? []).map((s) => s.serviceId),
        );
      },
      (profile) {
        // Update cache so the rest of the app benefits too
        profileCacheValue = profile;
        selectedServiceIds = Set<int>.from(
          (profile.data?.services ?? []).map((s) => s.serviceId),
        );
      },
    );

    // Now handle the services list
    servicesResult.fold(
      (failure) => emit(ServicesError(failure.errMessage)),
      (services) {
        allServices = services;
        emit(ServicesSuccess());
      },
    );
  }

  // ── Toggle ────────────────────────────────────────────────────────────────

  void toggleService(int serviceId) {
    if (selectedServiceIds.contains(serviceId)) {
      selectedServiceIds.remove(serviceId);
    } else {
      selectedServiceIds.add(serviceId);
    }
    emit(ServicesSuccess());
  }

  // ── Save ──────────────────────────────────────────────────────────────────

  Future<void> saveServices() async {
    final userId = userCacheValue?.data?.userId ?? -1;
    if (userId == -1) {
      Utils.showToast(title: 'User not found'.tr(), state: UtilState.error);
      return;
    }

    emit(ServicesUpdateLoading());

    final result = await _servicesDataSource.updateMyServices(
      technicalUserId: userId,
      serviceIds: selectedServiceIds.toList(),
    );

    result.fold(
      (failure) {
        emit(ServicesUpdateError(failure.errMessage));
        Utils.showToast(title: failure.errMessage, state: UtilState.error);
      },
      (_) {
        // Patch the cached profile so other screens see the updated services
        if (profileCacheValue?.data != null) {
          profileCacheValue!.data!.services = allServices
              .where((s) => selectedServiceIds.contains(s.serviceId))
              .map((s) => ProfileService(
                    serviceId: s.serviceId,
                    serviceNameAr: s.arName,
                    serviceNameEn: s.enName,
                  ))
              .toList();
        }
        emit(ServicesUpdateSuccess());
        Utils.showToast(
          title: 'Services updated successfully'.tr(),
          state: UtilState.success,
        );
      },
    );
  }
}
