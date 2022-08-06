import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:igplus_ios/domain/usecases/get_account_info_use_case.dart';
import 'package:igplus_ios/domain/usecases/get_user_use_case.dart';
import 'package:igplus_ios/domain/usecases/update_report_use_case.dart';

import '../../../../domain/entities/report.dart';

part 'report_state.dart';

class ReportCubit extends Cubit<ReportState> {
  final UpdateReportUseCase updateReport;
  final GetUserUseCase getUser;
  final GetAccountInfoUseCase getAccountInfo;
  ReportCubit({
    required this.updateReport,
    required this.getUser,
    required this.getAccountInfo,
  }) : super(ReportInitial());

  void init() async {
    emit(ReportInProgress());
    // get user info
    final failureOrCurrentUser = await getUser.execute();
    if (failureOrCurrentUser.isLeft()) {
      emit(const ReportFailure(message: 'Failed to get user info'));
    } else {
      final currentUser = (failureOrCurrentUser as Right).value;

      // get account info
      final failureOrAccountInfo =
          await getAccountInfo.execute(igUserId: currentUser.igUserId, igHeaders: currentUser.igHeaders);
      if (failureOrAccountInfo.isLeft()) {
        emit(const ReportFailure(message: 'Failed to get account info'));
      } else {
        final accountInfo = (failureOrAccountInfo as Right).value;
        final failureOrReport = await updateReport.execute(currentUser: currentUser, accountInfo: accountInfo);
        if (failureOrReport.isLeft()) {
          emit(const ReportFailure(message: 'Failed to update report'));
        } else {
          final Report report = (failureOrReport as Right).value;
          emit(ReportSuccess(report: report));
        }
      }
    }
  }
}
