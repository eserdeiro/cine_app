
import 'package:cine_app/infrastructure/datasources/local_database_datasource_impl.dart';
import 'package:cine_app/infrastructure/repository/local_database_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localDatabaseProvider = Provider((ref) {

return LocalDatabaseRepositoryImpl(LocalDatabaseDataSourceImpl());

});