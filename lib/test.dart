

import 'package:o_travel/api/company/city_api.dart';
import 'package:o_travel/api/company/country_api.dart';
import 'package:o_travel/api/company/domain_api.dart';
import 'package:o_travel/api/company/me_api.dart';
import 'package:o_travel/api/company/offer_api.dart';
import 'package:o_travel/api/company/story_api.dart';

import 'api/company/category_api.dart';

void main() {
  getAllOffers().then((value) => print('getAllOffer $value'));
}

