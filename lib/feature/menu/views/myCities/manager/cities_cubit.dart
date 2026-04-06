import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matlop_provider/core/network/local/cache.dart';
import 'package:matlop_provider/core/utils/utils.dart';
import 'package:matlop_provider/feature/addNewAddress/data/models/city_model.dart';
import 'package:matlop_provider/feature/menu/views/editProfile/data/dataSource/update_profile_data_source.dart';
import 'package:matlop_provider/feature/menu/views/editProfile/data/models/profile_model.dart';
import 'package:matlop_provider/feature/menu/views/myCities/data/cities_data_source.dart';

part 'cities_state.dart';

class CitiesCubit extends Cubit<CitiesState> {
  CitiesCubit() : super(CitiesInitial());

  static CitiesCubit of(BuildContext context) => BlocProvider.of(context);

  final CitiesDataSourceInterface _citiesDataSource = CitiesDataSource();
  final UpdateProfileDataSourceInterface _profileDataSource = UpdateProfileDataSource();

  /// All cities available from the API.
  List<CityData> allCities = [];

  /// City IDs currently selected for this technical (seeded from profile).
  Set<int> selectedCityIds = {};

  /// Returns true if the selection differs from what the profile last reported.
  bool get hasChanges {
    final original = Set<int>.from(
      (profileCacheValue?.data?.cities ?? []).map((c) => c.cityId),
    );
    return !_setsEqual(selectedCityIds, original);
  }

  bool _setsEqual(Set<int> a, Set<int> b) => a.length == b.length && a.containsAll(b);

  // ── Load ──────────────────────────────────────────────────────────────────

  /// Fetches the profile AND all cities concurrently so that user's cities
  /// are always pre-selected even if edit-profile was never visited.
  Future<void> loadCities() async {
    emit(CitiesLoading());

    final userId = userCacheValue?.data?.userId ?? -1;

    final futureCities = _citiesDataSource.getAllCities();
    final futureProfile = _profileDataSource.getProfile(userId: userId);

    final citiesResult = await futureCities;
    final profileResult = await futureProfile;

    // Apply profile cities (either freshly fetched or from cache fallback)
    profileResult.fold(
      (_) {
        // Profile fetch failed – fall back to whatever is already cached
        selectedCityIds = Set<int>.from(
          (profileCacheValue?.data?.cities ?? []).map((c) => c.cityId),
        );
      },
      (profile) {
        // Update cache so the rest of the app benefits too
        profileCacheValue = profile;
        selectedCityIds = Set<int>.from(
          (profile.data?.cities ?? []).map((c) => c.cityId),
        );
      },
    );

    // Now handle the cities list
    citiesResult.fold(
      (failure) => emit(CitiesError(failure.errMessage)),
      (cities) {
        allCities = cities;
        emit(CitiesSuccess());
      },
    );
  }

  // ── Toggle ────────────────────────────────────────────────────────────────

  void toggleCity(int cityId) {
    if (selectedCityIds.contains(cityId)) {
      selectedCityIds.remove(cityId);
    } else {
      selectedCityIds.add(cityId);
    }
    emit(CitiesSuccess());
  }

  // ── Save ──────────────────────────────────────────────────────────────────

  Future<void> saveCities() async {
    final userId = userCacheValue?.data?.userId ?? -1;
    if (userId == -1) {
      Utils.showToast(title: 'User not found'.tr(), state: UtilState.error);
      return;
    }

    emit(CitiesUpdateLoading());

    final result = await _citiesDataSource.updateMyCities(
      technicalUserId: userId,
      cityIds: selectedCityIds.toList(),
    );

    result.fold(
      (failure) {
        emit(CitiesUpdateError(failure.errMessage));
        Utils.showToast(title: failure.errMessage, state: UtilState.error);
      },
      (_) {
        // Patch the cached profile so other screens see the updated cities
        if (profileCacheValue?.data != null) {
          profileCacheValue!.data!.cities = allCities
              .where((c) => selectedCityIds.contains(c.cityId))
              .map((c) => ProfileCity(
                    cityId: c.cityId,
                    cityNameAr: c.arName,
                    cityNameEn: c.enName,
                  ))
              .toList();
        }
        emit(CitiesUpdateSuccess());
        Utils.showToast(
          title: 'Cities updated successfully'.tr(),
          state: UtilState.success,
        );
      },
    );
  }
}
