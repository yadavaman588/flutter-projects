import 'package:itz_yours/consts/consts.dart';
import 'package:itz_yours/consts/lists.dart';
import 'package:itz_yours/views/profile_screen/components/details_card.dart';
import 'package:itz_yours/widgets_commo/bg_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          //edit profile button
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.topRight,
              child: Icon(
                Icons.edit,
                color: whiteColor,
              ),
            ),
          ),
          10.heightBox,
          //user details section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Image.asset(
                  imgProfile2,
                  width: 80,
                  fit: BoxFit.cover,
                ).box.roundedFull.clip(Clip.antiAlias).make(),
                10.widthBox,
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    "Dummy User"
                        .text
                        .size(10)
                        .fontFamily(semibold)
                        .white
                        .make(),
                    5.heightBox,
                    "Customer@example.com"
                        .text
                        .size(10)
                        .fontFamily(semibold)
                        .white
                        .make()
                  ],
                )),
                OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                      color: whiteColor,
                    )),
                    onPressed: () {},
                    child: logout.text.fontFamily(semibold).white.make())
              ],
            ),
          ),
          30.heightBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              detailsCard(
                  count: "00",
                  title: "In Your Cart",
                  width: context.screenWidth / 3.4),
              detailsCard(
                  count: "444",
                  title: "In Your Wishlist",
                  width: context.screenWidth / 3.4),
              detailsCard(
                  count: "8888",
                  title: "Your Orders",
                  width: context.screenWidth / 3.4)
            ],
          ),

          //buttons section
          ListView.separated(
                  shrinkWrap: true,
                  separatorBuilder: (context, index) {
                    return const Divider(
                      color: lightGrey,
                    );
                  },
                  itemCount: profileButtonList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: Image.asset(
                        profileButtonIcons[index],
                        width: 22,
                      ),
                      title: profileButtonList[index]
                          .text
                          .fontFamily(semibold)
                          .color(darkFontGrey)
                          .make(),
                    );
                  })
              .box
              .white
              .rounded
              .margin(const EdgeInsets.all(12))
              .padding(const EdgeInsets.symmetric(horizontal: 16))
              .make()
              .box
              .color(redColor)
              .make()
        ],
      )),
    ));
  }
}
