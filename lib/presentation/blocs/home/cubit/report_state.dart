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
  const ReportSuccess({required this.report});
  @override
  List<Object> get props => [report];
}

class ReportFailure extends ReportState {
  final String message;

  const ReportFailure({required this.message});
  @override
  List<Object> get props => [message];
}
