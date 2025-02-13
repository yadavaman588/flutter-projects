import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:itz_yours/consts/consts.dart';
import 'package:itz_yours/services/firestore_services.dart';
import 'package:itz_yours/views/category_screen/item_details.dart';

class SearchScreen extends StatelessWidget {
  final String? title;
  const SearchScreen({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: title!.text.color(darkFontGrey).make(),
      ),
      body: FutureBuilder(
        future: FirestoreServices.searchProducts(title),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
                child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(redColor),
            ));
          } else if (snapshot.data!.docs.isEmpty) {
            return "No such Products found".text.white.makeCentered();
          }
          var data = snapshot.data!.docs;
          var filteredData = data
              .where(
                (element) => element['p_name']
                    .toString()
                    .toLowerCase()
                    .contains(title!.toLowerCase()),
              )
              .toList();

          if (filteredData.isEmpty) {
            return "No such products found"
                .text
                .color(darkFontGrey)
                .makeCentered();
          }

          return Padding(
            padding: const EdgeInsets.all(8),
            child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  mainAxisExtent: 300),
              children: filteredData
                  .mapIndexed(
                    (currentValue, index) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          filteredData[index]['p_imgs'][0],
                          width: 200,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                        const Spacer(),
                        10.heightBox,
                        "${filteredData[index]['p_name']}"
                            .text
                            .fontFamily(semibold)
                            .color(darkFontGrey)
                            .make(),
                        10.heightBox,
                        "${filteredData[index]['p_price']}"
                            .numCurrency
                            .text
                            .color(redColor)
                            .fontFamily(bold)
                            .size(16)
                            .make()
                      ],
                    )
                        .box
                        .margin(const EdgeInsets.symmetric(horizontal: 4))
                        .white
                        .outerShadowMd
                        .roundedSM
                        .padding(const EdgeInsets.all(12))
                        .make()
                        .onTap(
                      () {
                        Get.to(() => ItemDetails(
                              title: "${filteredData[index]['p_name']}",
                              data: filteredData[index],
                            ));
                      },
                    ),
                  )
                  .toList(),
            ),
          );
        },
      ),
    );
  }
}
