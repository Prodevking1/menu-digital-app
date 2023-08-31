import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_app/controllers/home_controller.dart';
import 'package:pos_app/controllers/oders_controller.dart';
import 'package:pos_app/models/order_model.dart';

import '../../services/service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController homeController = HomeController();
  OrderService orderService = OrderService();
  OrdersController ordersController = OrdersController();
  bool initialOrdersDisplayed =
      false; // Suivre si les commandes initiales ont déjà été affichées

  @override
  void initState() {
    super.initState();
    orderService.listenToNewOrders();
    // orderService.deleteAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: StreamBuilder(
            stream: orderService.listenToNewOrders(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                ordersController.addOrder(snapshot.data as OrderModel);

                return Column(children: [
                  _buildCurrentPendingOrderWidget(),
                  _buildActionButtons(ordersController.pendingOrders.last),
                ]);
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 80,
                        width: 80,
                        child: CircularProgressIndicator(
                          color: const Color(0xFFFFD700),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text('En attente de commandes'),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentPendingOrderWidget() {
    return Obx(() {
      return ordersController.pendingOrders.isNotEmpty
          ? Container(
              height: 150,
              width: 330,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Column(
                  children: [
                    Text(
                      'Table ${ordersController.pendingOrders.last.table}',
                      style: TextStyle(
                        color: const Color(0xFFFFD700),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount:
                          ordersController.pendingOrders.last.items.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                ordersController.pendingOrders.last.items[index]
                                    .productName,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                '${ordersController.pendingOrders.last.items[index].quantity}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            )
          : Center();
    });
  }

  Widget _buildActionButtons(OrderModel order) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              TextButton.icon(
                onPressed: () {
                  ordersController.cancelOrder(order);
                },
                icon: const Icon(
                  Icons.dangerous,
                  color: Colors.red,
                ),
                label: const Text(
                  'Annuler',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              TextButton.icon(
                onPressed: () {
                  orderService.confirmAndSaveOrder(order);
                },
                icon: const Icon(
                  Icons.check,
                  color: Colors.green,
                ),
                label: const Text(
                  'Confirmer',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
