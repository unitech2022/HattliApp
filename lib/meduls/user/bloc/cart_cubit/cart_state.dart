part of 'cart_cubit.dart';

class CartState extends Equatable {
  final RequestState? addCartState;
  final RequestState? deleteCartState;
  final RequestState? updateCartState;
  final RequestState? getCartsState;
  final CartResponse? cartResponse;
  final RequestState?addQuantityState;
    final RequestState? minusQuantityState;
  final List<int> quantities;
  final List<double> prices;

  const CartState(
      {this.addCartState,
      this.deleteCartState,
      this.updateCartState,
        this.addQuantityState,
      this.minusQuantityState,
      this.getCartsState,
      this.cartResponse,
      this.quantities = const [],
      this.prices = const []});

  CartState copyWith(
          {final RequestState? addCartState,
          final RequestState? deleteCartState,
          final RequestState? updateCartState,
          final RequestState? getCartsState,
          final CartResponse? cartResponse,
          final List<int>? quantities,
          final List<double>? prices,
            final RequestState?addQuantityState,
    final RequestState? minusQuantityState
          }) =>
      CartState(
        addCartState: addCartState ?? this.addCartState,
        deleteCartState: deleteCartState ?? this.deleteCartState,
        updateCartState: updateCartState ?? this.updateCartState,
        getCartsState: getCartsState ?? this.getCartsState,
        cartResponse: cartResponse ?? this.cartResponse,
         quantities: quantities ?? this.quantities,
        prices: prices ?? this.prices,
        addQuantityState: addQuantityState ?? this.addQuantityState,
        minusQuantityState: minusQuantityState ?? this.minusQuantityState,
      );

  @override
  List<Object?> get props => [
        updateCartState,
        addCartState,
        updateCartState,
        cartResponse,
        getCartsState,
        prices,
        quantities,
        minusQuantityState,
        addQuantityState
      ];
}
