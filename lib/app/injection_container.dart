import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:igplus_ios/domain/repositories/firebase/firebase_repository.dart';
import 'package:igplus_ios/domain/repositories/firebase/headers_repository.dart';
import 'package:igplus_ios/domain/repositories/instagram/instagram_repository.dart';
import '../data/repositories/firebase/firebase_repository_imp.dart';
import '../data/repositories/firebase/headers_repository_imp.dart';
import '../data/repositories/instagram/instagram_repository_imp.dart';
import '../data/sources/firebase/firebase_data_source.dart';
import '../domain/usecases/authorize_user.dart';
import '../domain/usecases/get_headers.dart';
import '../presentation/blocs/cubit/instagram_auth_cubit.dart';

import '../data/sources/instagram/instagram_data_source.dart';
import '../domain/usecases/creat_user.dart';
import '../domain/usecases/get_account_info.dart';
import '../domain/usecases/get_user.dart';
import '../domain/usecases/update_user.dart';

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

  // Use cases
  sl.registerLazySingleton(() => GetAccountInfo(instagramRepository: sl()));
  sl.registerLazySingleton(() => GetHeaders(headersRepository: sl()));
  sl.registerLazySingleton(() => AuthorizeUser(firebaseRepository: sl()));
  sl.registerLazySingleton(() => CreateUser(instagramRepository: sl(), firebaseRepository: sl()));
  sl.registerLazySingleton(() => UpdateUser(instagramRepository: sl(), firebaseRepository: sl()));
  sl.registerLazySingleton(() => GetUser(firebaseRepository: sl()));

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
