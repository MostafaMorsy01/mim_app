import 'package:meem_app/Models/category_model.dart';
import 'package:meem_app/Models/city_model.dart';
import 'package:meem_app/Models/shipping_company_model.dart';

class SpSignupListData {
  List<Category> categories;
  List<City> cities;
  List<ShippingCompany> shippingCompanies;

  SpSignupListData({
    required this.categories,
    required this.cities,
    required this.shippingCompanies,
  });

  factory SpSignupListData.fromJson(Map<String, dynamic> json) {
    return SpSignupListData(
      categories: json['categories'] != null
          ? List<Category>.from(
              json['categories'].map((cat) => Category.fromJson(cat)))
          : [],
      cities: json['cities'] != null
          ? List<City>.from(json['cities'].map((city) => City.fromJson(city)))
          : [],
      shippingCompanies: json['shipping_companies'] != null
          ? List<ShippingCompany>.from(json['shipping_companies']
              .map((company) => ShippingCompany.fromJson(company)))
          : [],
    );
  }
}
