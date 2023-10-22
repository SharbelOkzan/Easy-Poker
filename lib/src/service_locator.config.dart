// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:easy_poker/src/core/domain/logic/usecases/calculate_game_results_usecase.dart'
    as _i3;
import 'package:easy_poker/src/core/domain/logic/usecases/draw_card_usecase.dart'
    as _i4;
import 'package:easy_poker/src/core/domain/logic/usecases/exchange_card_usecase.dart'
    as _i5;
import 'package:easy_poker/src/core/domain/logic/usecases/get_shuffled_deck_usecase.dart'
    as _i6;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i3.CalculateGameResultsUsecase>(
        () => _i3.CalculateGameResultsUsecase());
    gh.factory<_i4.DrawCardUsecase>(() => _i4.DrawCardUsecase());
    gh.factory<_i5.ExchangeCardUsecase>(
        () => _i5.ExchangeCardUsecase(gh<_i4.DrawCardUsecase>()));
    gh.factory<_i6.GetShuffledDeckUsecase>(() => _i6.GetShuffledDeckUsecase());
    return this;
  }
}
