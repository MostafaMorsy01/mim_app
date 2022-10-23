import 'package:meem_app/Models/HomeModel/HomeCarouselModel.dart';
import 'package:meem_app/Models/HomeModel/HomeCelebrityStoresModel.dart';
import 'package:meem_app/Models/HomeModel/HomeFeaturedCategoryModel.dart';
import 'package:meem_app/Models/HomeModel/HomeFeaturedStoresModel.dart';
import 'package:meem_app/Models/HomeModel/HomeRecentlyAddedModel.dart';
import 'package:meem_app/Models/category_model.dart';
import 'package:meem_app/Models/city_model.dart';
import 'package:meem_app/Models/shipping_company_model.dart';

class HomeCoreModel {
  String? address;
  List<HomeCarouselModel>? homeCarousel;
  List<HomeFeaturedCategoryModel>? homeFeatureCategory;
  List<HomeCelebrityStoresModel>? homeCelebrityStores;
  List<HomeFeaturedStoresModel>? homeFeatureStores;
  List<HomeRecentlyAddedModel>? homeRecentlyAdded;

  HomeCoreModel({
    required this.address,
    required this.homeCarousel,
    required this.homeFeatureCategory,
    required this.homeCelebrityStores,
    required this.homeFeatureStores,
    required this.homeRecentlyAdded
  });

  factory HomeCoreModel.fromJson(Map<String, dynamic>? json) {
    return HomeCoreModel(
      address: json!['address'],
      homeCarousel: json['home_carousel'] != null
          ? List<HomeCarouselModel>.from(
          json['home_carousel'].map((homeCar) => HomeCarouselModel.fromJson(homeCar)))
          : [],
      homeFeatureCategory: json['featured_categories'] != null
          ? List<HomeFeaturedCategoryModel>.from(json['featured_categories'].map((category) => HomeFeaturedCategoryModel.fromJson(category)))
          : [],
      homeCelebrityStores: json['celebrity_stores'] != null
          ? List<HomeCelebrityStoresModel>.from(json['celebrity_stores']
          .map((recently) => HomeCelebrityStoresModel.fromJson(recently)))
          : [],
      homeFeatureStores: json['featured_store'] != null
          ? List<HomeFeaturedStoresModel>.from(json['featured_store']
          .map((recently) => HomeFeaturedStoresModel.fromJson(recently)))
          : [],
      homeRecentlyAdded: json['recently_added_stores'] != null
          ? List<HomeRecentlyAddedModel>.from(json['recently_added_stores']
          .map((recently) => HomeRecentlyAddedModel.fromJson(recently)))
          : [],
    );
  }
}
