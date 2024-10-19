import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkInfoI {
  Future<bool> get isConnected;

  Future<List<ConnectivityResult>> get connectivityResult;
  Stream<List<ConnectivityResult>> get onConnectivityChanged;
}

class NetworkInfo implements NetworkInfoI {
  Connectivity connectivity;
  static final NetworkInfo _networkInfo = NetworkInfo._internal(Connectivity());

  factory NetworkInfo() {
    return _networkInfo;
  }

  NetworkInfo._internal(this.connectivity) {
    connectivity = connectivity;
  }

  Future<bool> get isConnected async {
    final result = await connectivityResult;
    return result != ConnectivityResult.none;
  }

  Future<List<ConnectivityResult>> get connectivityResult async {
    return connectivity.checkConnectivity();
  }

  Stream<List<ConnectivityResult>> get onConnectivityChanged =>
      connectivity.onConnectivityChanged;
}

abstract class Failure {}

class ServerFailure extends Failure {}

class CacheFailure extends Failure {}

class NetworkFailure extends Failure {}

class ServerException implements Exception {}

class CacheException implements Exception {}

class NetworkException implements Exception {}

/// can be used for throwing [NoInternetException]
class NoInternetException implements Exception {
  late String _message;

  NoInternetException([String message = 'No internet connection']) {
    this._message = message;
  }

  @override
  String toString() {
    return _message;
  }
}
