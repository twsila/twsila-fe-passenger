import 'package:equatable/equatable.dart';

import '../models/goods_model.dart';

class GoodsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SendGoodsRequest extends GoodsEvent {
  final GoodsModel goodsModel;

  SendGoodsRequest({required this.goodsModel});
}
