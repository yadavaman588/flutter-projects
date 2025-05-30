import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:itz_yours/consts/consts.dart';
import 'package:itz_yours/consts/lists.dart';
import 'package:itz_yours/controllers/home_controller.dart';
import 'package:itz_yours/controllers/product_controller.dart';
import 'package:itz_yours/services/firestore_services.dart';
import 'package:itz_yours/views/category_screen/item_details.dart';
import 'package:itz_yours/views/home_screen/components/featured_button.dart';
import 'package:itz_yours/views/home_screen/search_scree.dart';
import 'package:itz_yours/widgets_commo/home_buttons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.find<HomeController>();
    var pController = Get.put(ProductController());
    return Container(
      padding: const EdgeInsets.all(12),
      color: lightGrey,
      width: context.screenWidth,
      height: context.screenHeight,
      child: SafeArea(
        child: Column(children: [
          Container(
            alignment: Alignment.center,
            height: 60,
            color: lightGrey,
            child: TextFormField(
              controller: controller.searchController,
              decoration: InputDecoration(
                border: InputBorder.none,
                suffixIcon: const Icon(Icons.search).onTap(() {
                  if (controller.searchController.text.isNotEmptyAndNotNull) {
                    Get.to(() => SearchScreen(
                          title: controller.searchController.text,
                        ));
                  }
                }),
                fillColor: whiteColor,
                filled: true,
                hintText: searchAnything,
                hintStyle: const TextStyle(color: textfieldGrey),
              ),
            ),
          ),
          10.heightBox,
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  //swipers

                  VxSwiper.builder(
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      height: 150,
                      itemCount: slidersList.length,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          slidersList[index],
                          fit: BoxFit.fitHeight,
                        )
                            .box
                            .rounded
                            .clip(Clip.antiAlias)
                            .margin(const EdgeInsets.symmetric(horizontal: 8))
                            .make();
                      }),

                  15.heightBox,

                  //deals buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                        2,
                        (index) => homeButtons(
                            width: context.screenWidth / 2.5,
                            height: context.screenHeight * 0.12,
                            title: index == 0 ? todayDeal : flashSale,
                            icon: index == 0 ? icTodaysDeal : icFlashDeal)),
                  ),
                  //2nd swiper
                  15.heightBox,

                  VxSwiper.builder(
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      height: 150,
                      itemCount: secondSlidersList.length,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          secondSlidersList[index],
                          fit: BoxFit.fitHeight,
                        )
                            .box
                            .rounded
                            .clip(Clip.antiAlias)
                            .margin(const EdgeInsets.symmetric(horizontal: 8))
                            .make();
                      }),

                  10.heightBox,
                  //category buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                        3,
                        (index) => homeButtons(
                            width: context.screenWidth / 3.5,
                            height: context.screenHeight * 0.12,
                            icon: index == 0
                                ? icTopCategories
                                : index == 1
                                    ? icBrands
                                    : icTopSeller,
                            title: index == 0
                                ? topCategories
                                : index == 1
                                    ? brand
                                    : topSellers)),
                  ),

                  20.heightBox,
                  //featured categories

                  Align(
                      alignment: Alignment.centerLeft,
                      child: featuredCategories.text
                          .color(darkFontGrey)
                          .size(18)
                          .fontFamily(semibold)
                          .make()),
                  20.heightBox,
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        children: List.generate(
                            3,
                            (index) => Column(
                                  children: [
                                    featuredButton(
                                      icon: featuredImages1[index],
                                      title: featuredTitles1[index],
                                    ),
                                    10.heightBox,
                                    featuredButton(
                                      icon: featuredImages2[index],
                                      title: featuredTitles2[index],
                                    ),
                                  ],
                                )).toList()),
                  ),

                  20.heightBox,
                  Container(
                    padding: const EdgeInsets.all(12),
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          featuredProducts.text.white
                              .fontFamily(bold)
                              .size(18)
                              .make(),
                          10.heightBox,
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: FutureBuilder(
                                future: FirestoreServices.getFeaturedProduct(),
                                builder: (context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (!snapshot.hasData) {
                                    return const Center(
                                        child: CircularProgressIndicator(
                                      valueColor:
                                          AlwaysStoppedAnimation(redColor),
                                    ));
                                  } else if (snapshot.data!.docs.isEmpty) {
                                    return "No featured Products"
                                        .text
                                        .white
                                        .makeCentered();
                                  } else {
                                    var featuredData = snapshot.data!.docs;
                                    return Row(
                                      children: List.generate(
                                          featuredData.length,
                                          (index) => Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Image.network(
                                                    featuredData[index]
                                                        ['p_imgs'][0],
                                                    width: 130,
                                                    height: 130,
                                                    fit: BoxFit.cover,
                                                  ),
                                                  10.heightBox,
                                                  "${featuredData[index]['p_name']}"
                                                      .text
                                                      .fontFamily(semibold)
                                                      .color(darkFontGrey)
                                                      .make(),
                                                  10.heightBox,
                                                  "${featuredData[index]['p_price']}"
                                                      .numCurrency
                                                      .text
                                                      .color(redColor)
                                                      .fontFamily(bold)
                                                      .size(16)
                                                      .make()
                                                ],
                                              )
                                                  .box
                                                  .margin(const EdgeInsets
                                                      .symmetric(horizontal: 4))
                                                  .white
                                                  .rounded
                                                  .padding(
                                                      const EdgeInsets.all(8))
                                                  .make()
                                                  .onTap(
                                                () async {
                                                  await pController.checkIfFav(
                                                      featuredData[index]);
                                                  Get.to(() => ItemDetails(
                                                        title:
                                                            "${featuredData[index]['p_name']}",
                                                        data:
                                                            featuredData[index],
                                                      ));
                                                  setState(() {});
                                                },
                                              )),
                                    );
                                  }
                                }),
                          )
                        ]),
                  ),
                  20.heightBox,

                  VxSwiper.builder(
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      height: 150,
                      itemCount: secondSlidersList.length,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          secondSlidersList[index],
                          fit: BoxFit.fitHeight,
                        )
                            .box
                            .rounded
                            .clip(Clip.antiAlias)
                            .margin(const EdgeInsets.symmetric(horizontal: 8))
                            .make();
                      }),

                  20.heightBox,
                  StreamBuilder(
                    stream: FirestoreServices.getAllPrducts(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                            child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(redColor),
                        ));
                      } else {
                        var allproductsData = snapshot.data!.docs;
                        return GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: allproductsData.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 8,
                                    crossAxisSpacing: 8,
                                    mainAxisExtent: 300),
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                    allproductsData[index]['p_imgs'][0],
                                    width: 200,
                                    height: 200,
                                    fit: BoxFit.cover,
                                  ),
                                  const Spacer(),
                                  10.heightBox,
                                  "${allproductsData[index]['p_name']}"
                                      .text
                                      .fontFamily(semibold)
                                      .color(darkFontGrey)
                                      .make(),
                                  10.heightBox,
                                  "${allproductsData[index]['p_price']}"
                                      .numCurrency
                                      .text
                                      .color(redColor)
                                      .fontFamily(bold)
                                      .size(16)
                                      .make()
                                ],
                              )
                                  .box
                                  .margin(
                                      const EdgeInsets.symmetric(horizontal: 4))
                                  .white
                                  .rounded
                                  .padding(const EdgeInsets.all(12))
                                  .make()
                                  .onTap(
                                () {
                                  pController
                                      .checkIfFav(allproductsData[index]);
                                  Get.to(() => ItemDetails(
                                        title:
                                            "${allproductsData[index]['p_name']}",
                                        data: allproductsData[index],
                                      ));
                                  setState(() {});
                                },
                              );
                            });
                      }
                    },
                  )
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
