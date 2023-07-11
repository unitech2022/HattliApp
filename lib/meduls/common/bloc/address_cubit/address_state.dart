part of 'address_cubit.dart';

class AddressState extends Equatable {
  final RequestState? addAddressState;
  final RequestState? updateAddressState;
  final RequestState? deleteAddressState;

  const AddressState(
      {this.addAddressState, this.updateAddressState, this.deleteAddressState});

  AddressState copyWith(
      {final RequestState? addAddressState,
      final RequestState? updateAddressState,
      final RequestState? deleteAddressState}) {
    return AddressState(
      addAddressState: addAddressState ?? this.addAddressState,
      updateAddressState: updateAddressState ?? this.updateAddressState,
      deleteAddressState: deleteAddressState ?? this.deleteAddressState,
    );
  }

  @override
  List<Object?> get props => [
      addAddressState,
      updateAddressState,
    deleteAddressState
      ];
}
