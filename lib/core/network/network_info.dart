import 'package:data_connection_checker/data_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final DataConnectionChecker _dataConnectionChecker;

  NetworkInfoImpl({
    required DataConnectionChecker dataConnectionChecker
  }): _dataConnectionChecker = dataConnectionChecker;

  @override
  Future<bool> get isConnected => _dataConnectionChecker.hasConnection;
  
}