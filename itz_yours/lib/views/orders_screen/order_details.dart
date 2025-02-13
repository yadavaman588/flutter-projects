import 'package:itz_yours/consts/consts.dart';
import 'package:itz_yours/views/orders_screen/components/order_status.dart';
import 'package:itz_yours/views/orders_screen/orderplace_details.dart';
import 'package:intl/intl.dart' as intl;

class OrderDetails extends StatelessWidget {
  final dynamic data;

  const OrderDetails({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Order Details"
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Column(
                children: [
                  orderStatus(
                    color: redColor,
                    icon: Icons.done,
                    showDone: data['order_placed'],
                    title: "Placed",
                  ),
                  orderStatus(
                    color: Colors.blue,
                    icon: Icons.thumb_up,
                    showDone: data['order_confirmed'],
                    title: "Confirmed",
                  ),
                  orderStatus(
                    color: Colors.green,
                    icon: Icons.car_crash,
                    showDone: data['order_on_delivery'],
                    title: "On delivery",
                  ),
                  orderStatus(
                    color: Colors.blue,
                    icon: Icons.done_all_rounded,
                    showDone: data['order_delivered'],
                    title: "Delivered",
                  ),
                  const Divider(),
                  10.heightBox,
                  Column(
                    children: [
                      orderPlaceDetails(
                        d1: data['order_id'],
                        d2: data['shipping_method'],
                        title1: "Order ID",
                        title2: "Shipping Method",
                      ),
                      orderPlaceDetails(
                        d1: intl.DateFormat()
                            .add_yMd()
                            .format(data['order_date'].toDate()),
                        d2: data['payment_method'],
                        title1: "Order Date",
                        title2: "Payment Method",
                      ),
                      orderPlaceDetails(
                        d1: "Unpaid",
                        d2: "Order Placed",
                        title1: "Payment Status",
                        title2: "Delivery Status",
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                "Shipping Address"
                                    .text
                                    .fontFamily(semibold)
                                    .make(),
                                "Name: ${data['order_by_name']}".text.make(),
                                "E-mail: ${data['order_by_email']}".text.make(),
                                "Address: ${data['order_by_address']}"
                                    .text
                                    .make(),
                                "City: ${data['order_by_city']}".text.make(),
                                "State: ${data['order_by_state']}".text.make(),
                                "Contact No.: ${data['order_by_phone']}"
                                    .text
                                    .make(),
                                "Postal Code.: ${data['order_by_postalcode']}"
                                    .text
                                    .make(),
                              ],
                            ),
                            SizedBox(
                              width: 120,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  "Total Amount"
                                      .text
                                      .fontFamily(semibold)
                                      .make(),
                                  "${data['total_amount']}"
                                      .numCurrency
                                      .text
                                      .color(redColor)
                                      .fontFamily(bold)
                                      .make(),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ).box.shadowMd.white.make(),
                  10.heightBox,
                  "Ordered Product"
                      .text
                      .size(16)
                      .color(darkFontGrey)
                      .fontFamily(semibold)
                      .makeCentered(),
                  10.heightBox,
                  ListView(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children:
                              List.generate(data['orders'].length, (index) {
                            return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  orderPlaceDetails(
                                      title1: data['orders'][index]['title'],
                                      title2:
                                          "${data['orders'][index]['tprice']}"
                                              .numCurrency,
                                      d1: "${data['orders'][index]['qty']}x",
                                      d2: "Refundable"),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Container(
                                      width: 30,
                                      height: 20,
                                      color:
                                          Color(data['orders'][index]['color']),
                                    ),
                                  ),
                                  const Divider()
                                ]);
                          }).toList())
                      .box
                      .shadowMd
                      .white
                      .margin(const EdgeInsets.only(bottom: 4))
                      .make(),
                  20.heightBox,
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
