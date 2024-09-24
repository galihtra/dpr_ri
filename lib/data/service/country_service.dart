import '../models/country.dart';
import '../provider/country_api.dart';

class CountryService {
  final _api = CountryApi();
  Future<List<Country>?> getAllCountries() async {
    return _api.getAllCountries();
  }
}




