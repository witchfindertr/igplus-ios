import '../../models/ig_headers_model.dart';

import 'package:http/http.dart' as http;

abstract class FirebaseDataSource {
  Future<IgHeadersModel> getLatestHeaders();
}

class FirebaseDataSourceImp extends FirebaseDataSource {
  final http.Client client;

  FirebaseDataSourceImp({required this.client});
  @override
  Future<IgHeadersModel> getLatestHeaders() async {
    // TODO: implement getLatestHeaders

    return throw UnimplementedError();
  }
}
