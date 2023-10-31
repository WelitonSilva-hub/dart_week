import 'package:dw_barbershop/src/core/exceptions/repository_exception.dart';
import 'package:dw_barbershop/src/core/fp/either.dart';
import 'package:dw_barbershop/src/model/barbershop_model.dart';
import 'package:dw_barbershop/src/model/user_model.dart';

abstract interface class BarberShopRepository {
  Future<Either<RepositoryException, BarberShopModel>> getMyBarbershop(
    UserModel userModel,
  );
}
