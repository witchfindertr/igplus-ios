part of 'report_cubit.dart';

abstract class ReportState extends Equatable {
  const ReportState();

  @override
  List<Object> get props => [];
}

class ReportInitial extends ReportState {}

class ReportInProgress extends ReportState {}

class ReportSuccess extends ReportState {
  final Report report;
  final AccountInfo accountInfo;
  const ReportSuccess({required this.report, required this.accountInfo});
  @override
  List<Object> get props => [report, accountInfo];
}

class ReportAccountInfoLoaded extends ReportState {
  final AccountInfo accountInfo;
  const ReportAccountInfoLoaded({required this.accountInfo});
  @override
  List<Object> get props => [accountInfo];
}

class ReportFailure extends ReportState {
  final String message;

  const ReportFailure({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}
