part of 'address_cubit.dart';

class AddressState extends Equatable {
  final RequestState? addAddressState;
  final RequestState? updateAddressState;
  final RequestState? deleteAddressState;
  final RequestState? getAddressState;
  final AddressModel? address;
  final RequestState? searchLocationState;

   final RequestState? movMapState;
    final RequestState? initMapState;

  const AddressState(
      {this.addAddressState,
      this.updateAddressState,
      this.deleteAddressState,
      this.searchLocationState,
      this.getAddressState,this.movMapState,this.initMapState,
      this.address});

  AddressState copyWith(
      {final RequestState? addAddressState,
      final RequestState? searchLocationState,
      final RequestState? updateAddressState,
      final RequestState? deleteAddressState,
      final RequestState? getAddressState,
        final RequestState? initMapState,
     final RequestState? movMapState,
      final AddressModel? address}) {
    return AddressState(
      addAddressState: addAddressState ?? this.addAddressState,
      searchLocationState: searchLocationState ?? this.searchLocationState,
      updateAddressState: updateAddressState ?? this.updateAddressState,
      deleteAddressState: deleteAddressState ?? this.deleteAddressState,
      getAddressState: getAddressState ?? this.getAddressState,
      address: address ?? this.address,
        movMapState: movMapState ?? this.movMapState,
            initMapState: initMapState ?? this.initMapState,
    );
  }

  @override
  List<Object?> get props => [
        addAddressState,
        updateAddressState,
        deleteAddressState,
        searchLocationState,
        address,
        getAddressState
        ,movMapState,initMapState
      ];
}
