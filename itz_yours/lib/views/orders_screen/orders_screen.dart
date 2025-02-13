import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:itz_yours/consts/consts.dart';
import 'package:itz_yours/services/firestore_services.dart';
import 'package:itz_yours/views/orders_screen/order_details.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "My Orders".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
          stream: FirestoreServices.getAllOrders(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(redColor),
                ),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return "No Orders Placed".text.color(darkFontGrey).makeCentered();
            } else {
              var data = snapshot.data!.docs;

              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => OrderDetails(data: data[index]));
                      },
                      child: ListTile(
                        leading: "${index + 1}"
                            .text
                            .fontFamily(bold)
                            .color(darkFontGrey)
                            .xl
                            .make(),
                        title: data[index]['order_id']
                            .toString()
                            .text
                            .color(redColor)
                            .fontFamily(semibold)
                            .make(),
                        subtitle: data[index]['total_amount']
                            .toString()
                            .numCurrency
                            .text
                            .color(darkFontGrey)
                            .fontFamily(bold)
                            .make(),
                        trailing: IconButton(
                            onPressed: () {
                              Get.to(() => OrderDetails(data: data[index]));
                            },
                            icon: const Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: darkFontGrey,
                            )),
                      ),
                    );
                  });
            }
          }),
    );
  }
}
