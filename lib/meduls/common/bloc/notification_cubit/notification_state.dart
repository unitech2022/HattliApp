part of 'notification_cubit.dart';

class NotificationState extends Equatable {
  final RequestState? getAlertsState;
  final RequestState? viewAlertState;
  final AlertResponse? alertResponse;

  const NotificationState(
      {this.getAlertsState, this.viewAlertState, this.alertResponse});

  NotificationState copyWith(
          {final RequestState? getAlertsState,
          final RequestState? viewAlertState,
          final AlertResponse? alertResponse}) =>
      NotificationState(
        getAlertsState: getAlertsState ?? this.getAlertsState,
        viewAlertState: viewAlertState ?? this.viewAlertState,
        alertResponse: alertResponse ?? this.alertResponse,
      );
  @override
  List<Object?> get props => [getAlertsState, viewAlertState, alertResponse];
}
