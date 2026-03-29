import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:matlop_provider/core/network/dio_helper.dart';
import 'package:matlop_provider/core/network/end_points.dart';
import 'package:matlop_provider/core/network/errors/failures.dart';
import 'package:matlop_provider/feature/menu/views/editProfile/data/models/profile_model.dart';
import 'package:matlop_provider/feature/menu/views/editProfile/data/models/update_profile_params.dart';
import 'package:matlop_provider/main.dart';

abstract class UpdateProfileDataSourceInterface {
  Future<Either<Failure, ProfileModel>> updateProfile({
    required UpdateProfileParams params,
  });

  Future<Either<Failure, ProfileModel>> getProfile({
    required int userId,
  });
}

class UpdateProfileDataSource extends UpdateProfileDataSourceInterface {
  @override
  Future<Either<Failure, ProfileModel>> updateProfile({
    required UpdateProfileParams params,
  }) async {
    try {
      const endpoint = EndPoints.updateProfile;
      final response = await DioHelper.putData(
        endPoint: endpoint,
        data: await params.toJson(),
        formDataIsEnabled: true,
      );

      return right(ProfileModel.fromJson(response.data));
    } catch (error) {
      if (error is DioException) {
        return left(ServerFailure.fromDioException(error));
      }
      return left(ServerFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, ProfileModel>> getProfile({
    required int userId,
  }) async {
    try {
      final String endpoint = '${EndPoints.getProfileById}/$userId';
      final response = await DioHelper.getData(
        url: endpoint,
      );
     logger.i(response.data);
      if (response.data['code'] == 1) {
        return left(ServerFailure(response.data['message']));
      }
      return right(ProfileModel.fromJson(response.data));
    } catch (error) {
      if (error is DioException) {
        return left(ServerFailure.fromDioException(error));
      }
      return left(ServerFailure(error.toString()));
    }
  }
}
