import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:taxi_for_you/Features/other/goods_view/bloc/goods_event.dart';
import 'package:taxi_for_you/Features/other/goods_view/bloc/goods_state.dart';

import '../../../../app/app_prefs.dart';
import '../../../../core/network/base_response.dart';
import '../../goods_view/models/goods_repo.dart';

class GoodsBloc extends Bloc<GoodsEvent, GoodsRequestStates> {
  final GoodsRepo goodsRepo;
  final AppPreferences appPreferences;

  GoodsBloc(this.goodsRepo, this.appPreferences)
      : super(GoodsRequestIsNotLoading()) {
    on<SendGoodsRequest>(_sendGoodsRequest);
  }

  void _sendGoodsRequest(
      SendGoodsRequest event, Emitter<GoodsRequestStates> emit) async {
    emit(GoodsRequestIsLoading());

    try {
      await (goodsRepo.sendGoodsRequest(event.goodsModel));

      emit(GoodsRequestSuccessfully());
    } catch (e) {
      if (e is PlatformException) {
        if (e.message != null) {
          emit(GoodsRequestFailed(
              baseResponse: BaseResponse(errorMessage: e.message)));
        }
      } else {
        var response = BaseResponse(errorMessage: e.toString());
        emit(GoodsRequestFailed(baseResponse: response));
      }
    }
  }
}
