part of 'order_cubit.dart';

class OrderState extends Equatable {
  final RequestState? addOrderState;
  final RequestState? deleteOrderState;
  final RequestState? updateOrderState;
  final RequestState? getOrdersState;
  final OrderDetailsResponse? orderDetailsResponse;
    final RequestState? getOrderDetailsState;
  final int currentIndexTap;
  const OrderState( {this.orderDetailsResponse, this.getOrderDetailsState,
    this.addOrderState,
    this.deleteOrderState,
    this.updateOrderState,
    this.currentIndexTap = 0,
    this.getOrdersState,
  });

  OrderState copyWith({
    final RequestState? addOrderState,
    final RequestState? deleteOrderState,
    final RequestState? updateOrderState,
    final RequestState? getOrdersState,
    final int? currentIndexTap,
     final OrderDetailsResponse? orderDetailsResponse,
    final RequestState? getOrderDetailsState
  }) =>
      OrderState(
        addOrderState: addOrderState ?? this.addOrderState,
        deleteOrderState: deleteOrderState ?? this.deleteOrderState,
        updateOrderState: updateOrderState ?? this.updateOrderState,
        getOrdersState: getOrdersState ?? this.getOrdersState,
        currentIndexTap: currentIndexTap ?? this.currentIndexTap,
           orderDetailsResponse: orderDetailsResponse ?? this.orderDetailsResponse,
        getOrderDetailsState: getOrderDetailsState ?? this.getOrderDetailsState,
      );

  @override
  List<Object?> get props => [
        deleteOrderState,
        addOrderState,
        updateOrderState,
        currentIndexTap,
        getOrdersState,
        getOrderDetailsState
      ];
}
