part of 'statist_cubit.dart';

class StatistState extends Equatable {
  final RequestState? getReviewsProviderState;
  final RequestState? getAllOrdersState;
  final ResponseTotalOrder? allOrders;
  final int typeStatistTime;
  final String? startDateStatist;
  final String? endDateStatist;
  final ReviewModel? reviewModel;
  // ** my  wallet
  final RequestState? balanceWithdrawal;
  final bool isAllMony;

  final int currentIndexTap;

  const StatistState({
    this.getReviewsProviderState,
    this.getAllOrdersState,
    this.allOrders,
    this.typeStatistTime = 0,
    this.endDateStatist,
    this.startDateStatist,
    this.reviewModel,
    this.balanceWithdrawal,
    this.isAllMony = false,
    this.currentIndexTap = 0,
  });

  StatistState copyWith({
    final RequestState? getReviewsProviderState,
    final int? typeStatistTime,
    final RequestState? getAllOrdersState,
     final ResponseTotalOrder? allOrders,
    final String? startDateStatist,
    final String? endDateStatist,
    final ReviewModel? reviewModel,
    final int? currentIndexTap,
    final RequestState? balanceWithdrawal,
    final bool? isAllMony,
  }) =>
      StatistState(
        currentIndexTap: currentIndexTap ?? this.currentIndexTap,
         allOrders: allOrders ?? this.allOrders,
        getAllOrdersState: getAllOrdersState ?? this.getAllOrdersState,
        getReviewsProviderState:
            getReviewsProviderState ?? this.getReviewsProviderState,
        typeStatistTime: typeStatistTime ?? this.typeStatistTime,
        endDateStatist: endDateStatist ?? this.endDateStatist,
        startDateStatist: startDateStatist ?? this.startDateStatist,
        reviewModel: reviewModel ?? this.reviewModel,
        balanceWithdrawal: balanceWithdrawal ?? this.balanceWithdrawal,
        isAllMony: isAllMony ?? this.isAllMony,
      );
  @override
  List<Object?> get props => [
        getReviewsProviderState,
        endDateStatist,
        typeStatistTime,
        startDateStatist,
        reviewModel,
        isAllMony,
        allOrders,
        balanceWithdrawal,
        currentIndexTap,
        getAllOrdersState
      ];
}
