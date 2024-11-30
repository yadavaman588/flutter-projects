import 'package:get/get.dart';
import 'package:itz_yours/consts/consts.dart';
import 'package:itz_yours/controllers/home_controller.dart';
import 'package:itz_yours/views/category_screen/category_screen.dart';
import 'package:itz_yours/views/category_screen/item_details.dart';
import 'package:itz_yours/widgets_commo/bg_widget.dart';

class CategoryDetails extends StatelessWidget {
  final String? title;
  const CategoryDetails({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
      appBar: AppBar(
        title: title!.text.fontFamily(bold).white.make(),
      ),
      body: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                  children: List.generate(
                6,
                (index) => "Baby Clothing"
                    .text
                    .size(12)
                    .fontFamily(semibold)
                    .color(darkFontGrey)
                    .makeCentered()
                    .box
                    .white
                    .rounded
                    .size(120, 60)
                    .margin(const EdgeInsets.symmetric(horizontal: 4))
                    .make(),
              )),
            ),
            20.heightBox,
            Expanded(
                child: GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 6,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisExtent: 250,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8),
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            imgP5,
                            width: 200,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                          10.heightBox,
                          "Laptop 4gb/64gb"
                              .text
                              .fontFamily(semibold)
                              .color(darkFontGrey)
                              .make(),
                          10.heightBox,
                          "\$600"
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
                          .outerShadowSm
                          .rounded
                          .padding(const EdgeInsets.all(12))
                          .make()
                          .onTap(() {
                        Get.to(() => const ItemDetails(title: "Dummy Item"));
                      });
                    }))
          ],
        ),
      ),
    ));
  }
}
