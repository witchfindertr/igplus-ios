import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:igplus_ios/data/failure.dart';
import 'package:igplus_ios/domain/entities/account_info.dart';

import 'package:igplus_ios/domain/usecases/get_account_info_use_case.dart';
import 'package:igplus_ios/domain/usecases/get_friends_from_local_use_case.dart';
import 'package:igplus_ios/domain/usecases/get_report_from_local_use_case.dart';
import 'package:igplus_ios/domain/usecases/get_user_use_case.dart';
import 'package:igplus_ios/domain/usecases/update_report_use_case.dart';

import '../../../../domain/entities/report.dart';

part 'report_state.dart';

class ReportCubit extends Cubit<ReportState> {
  final UpdateReportUseCase updateReport;
  final GetUserUseCase getUser;
  final GetAccountInfoUseCase getAccountInfo;
  final GetFriendsFromLocalUseCase getDataFromLocal;
  final GetReportFromLocalUseCase getReportFromLocal;
  ReportCubit({
    required this.updateReport,
    required this.getUser,
    required this.getAccountInfo,
    required this.getDataFromLocal,
    required this.getReportFromLocal,
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
        final AccountInfo accountInfo = (failureOrAccountInfo as Right).value;
        emit(ReportAccountInfoLoaded(accountInfo: accountInfo));
        Either<Failure, Report?>? failureOrReport;

        // get report from local
        failureOrReport = await getReportFromLocal.execute();

        // check if is report data is outdated
        if (failureOrReport.isLeft() ||
            ((failureOrReport as Right).value.followers != accountInfo.followers ||
                (failureOrReport as Right).value.followings != accountInfo.followings)) {
          // update report
          failureOrReport = await updateReport.execute(currentUser: currentUser, accountInfo: accountInfo);
          if (failureOrReport.isLeft()) {
            emit(const ReportFailure(message: 'Failed to update report'));
          } else {
            final report = (failureOrReport as Right).value;
            emit(ReportSuccess(report: report, accountInfo: accountInfo));
          }
        } else {
          // get report from local
          final report = (failureOrReport as Right).value;
          if (failureOrReport.isLeft()) {
            emit(const ReportFailure(message: 'Failed to get report from local'));
          } else {
            emit(ReportSuccess(report: report, accountInfo: accountInfo));
          }
        }
      }
    }
  }
}
