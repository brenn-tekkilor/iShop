import 'package:flutter/material.dart';
import 'package:ishop/utils/util.dart';

enum ProductFulfillmentType {
  curbside,
  delivery,
  inStore,
  shipToHome,
}

enum ProductSellingPriceType {
  clearance,
  promo,
  regular,
}

const priceLines = [
  [.01, .99],
  [1.00, 1.99],
  [2.00, 2.99],
  [3.00, 3.99],
  [4.00, 4.99],
  [5.00, 5.99],
  [6.00, 6.99],
  [7.00, 7.99],
  [8.00, 8.99],
  [9.00, 9.99],
  [10.00, 14.99],
  [15.00, 19.99],
  [20.00, 49.99],
  [50.00, 99.99],
  [100.00, 149.99],
  [150.00, 199.99],
  [200.00, 249.99],
  [250.00, 299.99],
  [300.00, 399.99],
  [400.00, 499.99],
  [500.00, 599.99],
  [600.00, 799.99],
  [800.00, 999.99],
  [1000.00, 10000.00],
];

class Product {
  String id;
  String upc;
  String name;
  List<ProductLocation> locations;
  List<ProductCategory> category;
  ProductBrand brand;
  String description;
  List<ProductImage> images;
  bool favorite;
  List<ProductFulfillmentType> fulfillment;
  Measurement size;
  ProductDimensions dimensions;
  ProductTemperature temperature;
  List<TaxonomyType> taxonomies;
  String productId;
  List<String> sellingPrices;
  int priceLine;
}

class ProductSellingPrice {
  String id;
  double price;
  ProductSellingPriceType type;
  DateTimeRange validityPeriod;
  UnitOfMeasureType soldBy;
}

class ProductLocation {
  String retailLocationId;
  List<String> aisleLocationIds;
}

class ProductDimensions {
  Measurement depth;
  Measurement height;
  Measurement width;
}

class ProductTemperature {
  TemperatureIndicatorType indicator;
  bool heatSensitive;
}

class ProductImage {
  PerspectiveType perspective;
  bool featured;
  List<HTMLImage> images;
}

class ProductBrand {
  String id;
  String name;
  List<ProductBrand> subBrands;
  List<Product> products;
}

class ProductCategory {
  String id;
  String name;
  List<ProductCategory> subCategories;
  List<Product> products;
}
