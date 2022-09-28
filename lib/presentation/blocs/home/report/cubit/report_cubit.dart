import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:igplus_ios/data/failure.dart';
import 'package:igplus_ios/domain/entities/account_info.dart';
import 'package:igplus_ios/domain/entities/stories_user.dart';
import 'package:igplus_ios/domain/entities/user.dart';
import 'package:igplus_ios/domain/repositories/auth/auth_repository.dart';
import 'package:igplus_ios/domain/usecases/clear_local_data_use_case.dart';
import 'package:igplus_ios/domain/usecases/get_account_info_from_local_use_case.dart';

import 'package:igplus_ios/domain/usecases/get_account_info_use_case.dart';
import 'package:igplus_ios/domain/usecases/get_user_feed_use_case.dart';
import 'package:igplus_ios/domain/usecases/get_friends_from_local_use_case.dart';
import 'package:igplus_ios/domain/usecases/get_report_from_local_use_case.dart';
import 'package:igplus_ios/domain/usecases/get_user_use_case.dart';
import 'package:igplus_ios/domain/usecases/save_account_info_to_local_use_case.dart';
import 'package:igplus_ios/domain/usecases/save_media_to_local_use_case.dart';
import 'package:igplus_ios/domain/usecases/update_report_use_case.dart';

import 'package:igplus_ios/domain/entities/report.dart';

part 'report_state.dart';

class ReportCubit extends Cubit<ReportState> {
  final UpdateReportUseCase updateReport;
  final GetUserUseCase getUser;
  final GetAccountInfoUseCase getAccountInfo;
  final GetFriendsFromLocalUseCase getDataFromLocal;
  final GetReportFromLocalUseCase getReportFromLocal;
  final GetUserFeedUseCase getUserFeed;
  final CacheMediaToLocalUseCase cacheMediaToLocal;
  final GetAccountInfoFromLocalUseCase getAccountInfoFromLocalUseCase;
  final CacheAccountInfoToLocalUseCase cacheAccountInfoToLocalUseCase;
  final ClearAllBoxesUseCase clearAllBoxesUseCase;
  final AuthRepository authRepository;
  late final StreamSubscription authSubscription;
  ReportCubit({
    required this.updateReport,
    required this.getUser,
    required this.getAccountInfo,
    required this.getDataFromLocal,
    required this.getReportFromLocal,
    required this.getUserFeed,
    required this.cacheMediaToLocal,
    required this.getAccountInfoFromLocalUseCase,
    required this.cacheAccountInfoToLocalUseCase,
    required this.clearAllBoxesUseCase,
    required this.authRepository,
  }) : super(ReportInitial()) {
    authSubscription = authRepository.authUser.listen((user) {
      init();
    });
  }

  void init() async {
    // await clearAllBoxesUseCase.execute();
    // await Hive.box<StoriesUser>(StoriesUser.boxKey).clear();
    emit(const ReportInProgress(loadingMessage: "We are loading your data..."));
    // get cached account info from local // TODO - get from local
    final accountInfoEither = await getAccountInfoFromLocalUseCase.execute();
    AccountInfo? cachedAccountInfo = accountInfoEither.fold(
      (failure) => null,
      (accountInfo) => accountInfo,
    );

    // show old account info
    if (cachedAccountInfo != null) {
      emit(ReportAccountInfoLoaded(
          accountInfo: cachedAccountInfo, loadingMessage: "We are updating your account stats..."));
    }

    // get user info
    final failureOrCurrentUser = await getUser.execute();
    if (failureOrCurrentUser.isLeft()) {
      final failure = (failureOrCurrentUser as Left).value;
      emit(ReportFailure(message: 'Failed to get user info', failure: failure));
    } else {
      User currentUser = (failureOrCurrentUser as Right).value;
      // get account info
      final failureOrAccountInfo =
          await getAccountInfo.execute(igUserId: currentUser.igUserId, igHeaders: currentUser.igHeaders);
      if (failureOrAccountInfo.isLeft()) {
        final failure = (failureOrAccountInfo as Left).value;
        emit(ReportFailure(message: "failed to get account info", failure: failure));
      } else {
        final AccountInfo accountInfo = (failureOrAccountInfo as Right).value;

        // check if account was changed
        if (cachedAccountInfo != null && accountInfo.igUserId != cachedAccountInfo.igUserId) {
          // clear all boxes if user changed
          await clearAllBoxesUseCase.execute();
        }
        // cache new account info to local
        await cacheAccountInfoToLocalUseCase.execute(accountInfo: accountInfo);

        emit(ReportAccountInfoLoaded(accountInfo: accountInfo, loadingMessage: "Updating satats..."));
        Either<Failure, Report?>? failureOrReport;

        // get report from local
        failureOrReport = await getReportFromLocal.execute();

        // check if is report data is outdated
        if (failureOrReport.isLeft() ||
            ((failureOrReport as Right).value.followers != accountInfo.followers ||
                (failureOrReport as Right).value.followings != accountInfo.followings)) {
          // track progress of data loading from instagram
          if (failureOrReport.isLeft()) {
            int loadedFriends = 0;
            Timer.periodic(const Duration(seconds: 4), (timer) {
              loadedFriends += 191;
              if (loadedFriends < accountInfo.followers) {
                emit(ReportAccountInfoLoaded(
                    accountInfo: accountInfo,
                    loadingMessage: "$loadedFriends of ${accountInfo.followers} Friends Loaded..."));
              } else {
                emit(ReportAccountInfoLoaded(accountInfo: accountInfo, loadingMessage: "Analysing loaded data..."));
                timer.cancel();
              }
            });
          }

          // update report
          failureOrReport = await updateReport.execute(currentUser: currentUser, accountInfo: accountInfo);

          if (failureOrReport.isLeft()) {
            final failure = (failureOrReport as Left).value;
            emit(ReportFailure(message: 'Failed to update report', failure: failure));
          } else {
            final report = (failureOrReport as Right).value;
            emit(ReportSuccess(report: report, accountInfo: accountInfo));
          }
        } else {
          // get report from local
          final report = (failureOrReport as Right).value;
          if (failureOrReport.isLeft()) {
            final failure = (failureOrReport as Left).value;
            emit(ReportFailure(message: 'Failed to get report from local', failure: failure));
          } else {
            emit(ReportSuccess(report: report, accountInfo: accountInfo));
          }
        }
      }
    }
  }
}
