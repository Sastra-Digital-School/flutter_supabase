import 'package:flutter/material.dart';
import 'package:flutter_supabase_database/controller/product_detail_controll.dart';
import 'package:get/get.dart';

class ProductDetail extends StatelessWidget {
  final controller = Get.put(ProductDetailControll());
  ProductDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () =>
          controller.loading.value
              ? Center(child: CircularProgressIndicator())
              : Scaffold(appBar: _buildApp, body: _buildBody),
    );
  }

  get _buildApp {
    return AppBar(title: Text(controller.productDetailModel.title ?? ""));
  }

  get _buildBody {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(controller.productDetailModel.id.toString()),
          Text(controller.productDetailModel.title ?? ""),
          Text(controller.productDetailModel.price.toString()),
          Text(controller.productDetailModel.brand ?? ''),
        ],
      ),
    );
  }
}
