// import 'package:dartz/dartz.dart';
// import 'package:igshark/data/failure.dart';
// import 'package:igshark/domain/entities/ig_headers.dart';

// class HeadersRepository {
//   Future<Either<Failure, IgHeaders> getHeaders() async {

//     return Right(IgHeaders(
//       userAgent: 'Mozilla/5.0 (Linux; Android 9; Redmi Note 8 Pro Build/PPR1.180610.011; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/101.0.4951.61 Mobile Safari/537.36',
//       cookie: 'sessionid=2728720115%3Afux9lhzGjD8ESf%3A11',
//       accept: 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
//       acceptEncoding: 'gzip, deflate, br',
//       acceptLanguage: 'en-US,en;q=0.5',
//       upgradeInsecureRequests: '1',
//       XIGAppID: '936619743392459',
//       XCSRFToken: '0fRjvDxa1IMmqLxokwSCERUV2savdxmc',
//     ));
//   }
// }

import 'package:dartz/dartz.dart';
import 'package:igshark/data/failure.dart';
import 'package:igshark/domain/entities/ig_headers.dart';

import '../../entities/user.dart';

abstract class HeadersRepository {
  Future<Either<Failure, IgHeaders>> getHeaders({User? currentUser, Map<String, dynamic>? headers});
}
