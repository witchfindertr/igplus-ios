import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:igplus_ios/app/bloc/app_bloc.dart';

import 'package:igplus_ios/data/models/user_stories_model.dart';

import 'package:igplus_ios/data/repositories/local/local_repository_imp.dart';
import 'package:igplus_ios/data/sources/local/local_datasource.dart';
import 'package:igplus_ios/domain/repositories/auth/auth_repository.dart';

import 'package:igplus_ios/domain/repositories/firebase/firebase_repository.dart';
import 'package:igplus_ios/domain/repositories/firebase/headers_repository.dart';
import 'package:igplus_ios/domain/repositories/instagram/instagram_repository.dart';
import 'package:igplus_ios/domain/repositories/local/local_repository.dart';
import 'package:igplus_ios/domain/usecases/get_friends_from_local_use_case.dart';
import 'package:igplus_ios/domain/usecases/get_report_from_local_use_case.dart';
import 'package:igplus_ios/domain/usecases/get_user_stories_use_case.dart';
import 'package:igplus_ios/domain/usecases/sign_up_with_cstom_token_use_case.dart';
import 'package:igplus_ios/domain/usecases/update_report_use_case.dart';
import 'package:igplus_ios/presentation/blocs/friends_list/cubit/friends_list_cubit.dart';
import 'package:igplus_ios/presentation/blocs/home/cubit/report_cubit.dart';
import 'package:igplus_ios/presentation/blocs/stories/cubit/stories_cubit.dart';
import 'package:igplus_ios/presentation/blocs/user_stories/cubit/user_stories_cubit.dart';
import '../data/models/story_model.dart';
import '../data/repositories/firebase/firebase_repository_imp.dart';
import '../data/repositories/firebase/headers_repository_imp.dart';
import '../data/repositories/instagram/instagram_repository_imp.dart';
import '../data/sources/firebase/firebase_data_source.dart';
import '../domain/usecases/authorize_user.dart';
import '../domain/usecases/get_headers_use_case.dart';
import '../domain/usecases/get_stories_use_case.dart';
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
        signUpWithCustomToken: sl(),
      ));

  sl.registerFactory(() => ReportCubit(
        updateReport: sl(),
        getUser: sl(),
        getAccountInfo: sl(),
        getDataFromLocal: sl(),
        getReportFromLocal: sl(),
      ));

  sl.registerFactory(() => FriendsListCubit(getFriendsFromLocal: sl()));

  sl.registerFactory(() => UserStoriesCubit(getUserStories: sl(), getUser: sl()));
  sl.registerFactory(() => StoriesCubit(getStories: sl(), getUser: sl()));

  sl.registerFactory(() => AppBloc(authRepository: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetAccountInfoUseCase(instagramRepository: sl()));
  sl.registerLazySingleton(() => GetHeadersUseCase(headersRepository: sl()));
  sl.registerLazySingleton(() => AuthorizeUser(firebaseRepository: sl()));
  sl.registerLazySingleton(() => CreateUserUseCase(instagramRepository: sl(), firebaseRepository: sl()));
  sl.registerLazySingleton(() => UpdateUserUseCase(instagramRepository: sl(), firebaseRepository: sl()));
  sl.registerLazySingleton(() => GetUserUseCase(firebaseRepository: sl()));
  sl.registerLazySingleton(() => GetFriendsFromLocalUseCase(localRepository: sl()));
  sl.registerLazySingleton(() => UpdateReportUseCase(instagramRepository: sl(), localRepository: sl()));
  sl.registerLazySingleton(() => GetUserStoriesUseCase(instagramRepository: sl()));
  sl.registerLazySingleton(() => GetReportFromLocalUseCase(localRepository: sl()));
  sl.registerLazySingleton(() => GetStoriesUseCase(instagramRepository: sl()));
  sl.registerLazySingleton(() => SignUpWithCustomTokenUseCase(sl()));

  // Repositories
  sl.registerLazySingleton<FirebaseRepository>(() => FirebaseRepositporyImp(firebaseDataSource: sl()));

  sl.registerLazySingleton<InstagramRepository>(
      () => InstagramRepositoryImp(instagramDataSource: sl(), userStoryMapper: sl(), storyMapper: sl()));

  sl.registerLazySingleton<LocalRepository>(() => LocalRepositoryImpl(localDataSource: sl()));

  sl.registerLazySingleton<HeadersRepository>(() => HeadersRepositoryImp(firebaseDataSource: sl()));

  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImp(firebaseDataSource: sl()));

  // Data sources
  sl.registerLazySingleton<FirebaseDataSource>(
      () => FirebaseDataSourceImp(client: sl(), firebaseAuth: sl(), firebaseFirestore: sl()));
  sl.registerLazySingleton<InstagramDataSource>(() => InstagramDataSourceImp(client: sl()));
  sl.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImp(client: sl()));

  // Data Mapper
  sl.registerLazySingleton<UserStoryMapper>(() => UserStoryMapper());
  sl.registerLazySingleton<StoryMapper>(() => StoryMapper());

  // External
  final client = http.Client();
  final firebaseFirestore = FirebaseFirestore.instance;
  final firebaseAuth = FirebaseAuth.instance;
  sl.registerLazySingleton(() => client);
  sl.registerLazySingleton(() => firebaseFirestore);
  sl.registerLazySingleton(() => firebaseAuth);
}
