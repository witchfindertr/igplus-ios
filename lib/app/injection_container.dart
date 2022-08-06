import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:igplus_ios/domain/repositories/firebase/firebase_repository.dart';
import 'package:igplus_ios/domain/repositories/firebase/headers_repository.dart';
import 'package:igplus_ios/domain/repositories/instagram/instagram_repository.dart';
import 'package:igplus_ios/domain/usecases/update_report_use_case.dart';
import 'package:igplus_ios/presentation/blocs/home/cubit/report_cubit.dart';
import '../data/repositories/firebase/firebase_repository_imp.dart';
import '../data/repositories/firebase/headers_repository_imp.dart';
import '../data/repositories/instagram/instagram_repository_imp.dart';
import '../data/sources/firebase/firebase_data_source.dart';
import '../domain/usecases/authorize_user.dart';
import '../domain/usecases/get_headers_use_case.dart';
import '../presentation/blocs/login/cubit/instagram_auth_cubit.dart';

import '../data/sources/instagram/instagram_data_source.dart';
import '../domain/usecases/creat_user_use_case.dart';
import '../domain/usecases/get_account_info_use_case.dart';
import '../domain/usecases/get_user_use_case.dart';
import '../domain/usecases/update_user_use_case.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Blocs
  sl.registerFactory(() => InstagramAuthCubit(
        getAccountInfo: sl(),
        getHeaders: sl(),
        authorizeUser: sl(),
        createUser: sl(),
        updateUser: sl(),
        getUser: sl(),
      ));

  sl.registerFactory(() => ReportCubit(
        updateReport: sl(),
        getUser: sl(),
        getAccountInfo: sl(),
      ));

  // Use cases
  sl.registerLazySingleton(() => GetAccountInfoUseCase(instagramRepository: sl()));
  sl.registerLazySingleton(() => GetHeadersUseCase(headersRepository: sl()));
  sl.registerLazySingleton(() => AuthorizeUser(firebaseRepository: sl()));
  sl.registerLazySingleton(() => CreateUserUseCase(instagramRepository: sl(), firebaseRepository: sl()));
  sl.registerLazySingleton(() => UpdateUserUseCase(instagramRepository: sl(), firebaseRepository: sl()));
  sl.registerLazySingleton(() => GetUserUseCase(firebaseRepository: sl()));

  sl.registerLazySingleton(() => UpdateReportUseCase(instagramRepository: sl()));

  // Repositories
  sl.registerLazySingleton<FirebaseRepository>(() => FirebaseRepositporyImp(firebaseDataSource: sl()));
  sl.registerLazySingleton<InstagramRepository>(() => InstagramRepositoryImp(instagramDataSource: sl()));
  sl.registerLazySingleton<HeadersRepository>(() => HeadersRepositoryImp(firebaseDataSource: sl()));

  // Data sources
  sl.registerLazySingleton<FirebaseDataSource>(() => FirebaseDataSourceImp(client: sl()));
  sl.registerLazySingleton<InstagramDataSource>(() => InstagramDataSourceImp(client: sl()));

  // External
  sl.registerLazySingleton(() => http.Client());
}
