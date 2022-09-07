import 'package:hive/hive.dart';
import 'package:igplus_ios/domain/entities/friend.dart';
import 'package:http/http.dart' as http;
import 'package:igplus_ios/domain/entities/report.dart';

abstract class LocalDataSource {
  List<Friend>? getCachedFollowersList();
  Future<void> cacheFollowers({required List<Friend> friendsList});
  List<Friend>? getCachedFollowingsList();
  Future<void> cacheFollowings({required List<Friend> friendsList});
  Report? getCachedReport();
  Future<void> cacheReport({required Report report});
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
  // followers ------------------>
  // ----------------------->
  @override
  List<Friend>? getCachedFollowersList() {
    Box<Friend> followersBox = Hive.box<Friend>(Friend.followersBoxKey);
    print(followersBox.get(0));
    if (followersBox.isEmpty) {
      return null;
    } else {
      final List<Friend> friendsList =
          List.generate(followersBox.length, (index) => followersBox.getAt(index)).whereType<Friend>().toList();
      return friendsList;
    }
  }

  @override
  Future<void> cacheFollowers({required List<Friend> friendsList}) async {
    Box<Friend> friendsBox = Hive.box<Friend>(Friend.followersBoxKey);

    final friendsMap = {for (var e in friendsList) e.username: e};
    try {
      await friendsBox.putAll(friendsMap);
    } catch (e) {
      print(e);
    }
  }

  // ----------------------->
  // followings ------------------>
  // ----------------------->
  @override
  List<Friend>? getCachedFollowingsList() {
    Box<Friend> followersBox = Hive.box<Friend>(Friend.followersBoxKey);
    print(followersBox.get(0));
    if (followersBox.isEmpty) {
      return null;
    } else {
      final List<Friend> friendsList =
          List.generate(followersBox.length, (index) => followersBox.getAt(index)).whereType<Friend>().toList();
      return friendsList;
    }
  }

  @override
  Future<void> cacheFollowings({required List<Friend> friendsList}) async {
    Box<Friend> friendsBox = Hive.box<Friend>(Friend.followersBoxKey);

    final friendsMap = {for (var e in friendsList) e.username: e};
    try {
      await friendsBox.putAll(friendsMap);
    } catch (e) {
      print(e);
    }
  }
}
