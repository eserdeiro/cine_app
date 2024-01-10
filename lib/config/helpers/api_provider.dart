import 'package:cine_app/config/constants/environment.dart';
import 'package:dio/dio.dart';

class ApiProvider {

  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Enviroment.theMovieDbKey,
        'language': 'es-ARG',
      },
    ),
  );

}
