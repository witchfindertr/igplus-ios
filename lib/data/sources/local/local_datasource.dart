import 'package:hive/hive.dart';
import 'package:igplus_ios/domain/entities/friend.dart';
import 'package:http/http.dart' as http;
import 'package:igplus_ios/domain/entities/report.dart';

abstract class LocalDataSource {
  Report? getCachedReport();
  Future<void> cacheReport({required Report report});
  List<Friend>? getCachedFriendsList({required String boxKey});
  Future<void> cacheFriendsList({required List<Friend> friendsList, required String boxKey});
}

class LocalDataSourceImp extends LocalDataSource {
  final http.Client client;

  LocalDataSourceImp({required this.client});

  // ----------------------->
  // report ------------------>
  // ----------------------->
  @override
  Future<void> cacheReport({required Report report}) async {
    final reportBox = Hive.box<Report>(Report.boxKey);
    try {
      await reportBox.put('report', report);
    } catch (e) {
      print(e);
    }
  }

  @override
  Report? getCachedReport() {
    try {
      final reportBox = Hive.box<Report>(Report.boxKey);
      // reportBox.deleteFromDisk();
      Report? report;
      report = reportBox.get('report');
      return report;
    } catch (e) {
      print(e);
      return null;
    }
  }

  // ----------------------->
  // Friends ------------------>
  // ----------------------->

  @override
  List<Friend>? getCachedFriendsList({required String boxKey}) {
    Box<Friend> friendBox = Hive.box<Friend>(boxKey);

    if (friendBox.isEmpty) {
      return null;
    } else {
      final List<Friend> friendsList =
          List.generate(friendBox.length, (index) => friendBox.getAt(index)).whereType<Friend>().toList();
      return friendsList;
    }
  }

  @override
  Future<void> cacheFriendsList({required List<Friend> friendsList, required String boxKey}) async {
    Box<Friend> friendBox = Hive.box<Friend>(boxKey);

    final friendsMap = {for (var e in friendsList) e.username: e};
    try {
      await friendBox.putAll(friendsMap);
    } catch (e) {
      print(e);
    }
  }
}
