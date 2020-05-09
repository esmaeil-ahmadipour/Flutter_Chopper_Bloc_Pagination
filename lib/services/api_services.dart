import 'package:chopper/chopper.dart';
import 'package:chopperblocpagination/resources/strings.dart';

part 'api_services.chopper.dart';

@ChopperApi()
abstract class ApiService extends ChopperService {

  @Get(path: "/data/top/totalvolfull")
  Future<Response> getResult(
      @Query("limit") int limit,
      @Query("tsym") String tsym,
      @Query("page") int page);

  static ApiService create() {
    final client = ChopperClient(
      baseUrl: AppString.getInstance().baseUrl,
      services: [_$ApiService()],
      converter: JsonConverter(),
      errorConverter: JsonConverter(),
    );
    return _$ApiService(client);
  }
}