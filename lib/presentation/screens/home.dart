import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_app/controllers/home_controller.dart';
import 'package:pos_app/controllers/oders_controller.dart';
import 'package:pos_app/models/order_model.dart';
import 'package:pos_app/presentation/widgets/snackbar_widget.dart';

import '../../services/order_service.dart';

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

                return _buildCurrentPendingOrderWidget();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return _buildLoadingWidget();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentPendingOrderWidget() {
    return Obx(() {
      if (ordersController.pendingOrders.isNotEmpty) {
        OrderModel order = ordersController.pendingOrders.last;
        return Column(
          children: [
            Container(
              // height: 150,
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
                      'Table ${order.table}',
                      style: TextStyle(
                        color: const Color(0xFFFFD700),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: order.items.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                order.items[index].productName,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                '${order.items[index].quantity}',
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
            ),
            _buildActionButtons(order),
          ],
        );
      } else {
        return _buildLoadingWidget();
      }
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
          Obx(() => ordersController.isLoading.value
              ? CircularProgressIndicator()
              : Row(
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        ordersController.confirmOrder(order);
                      },
                      icon: const Icon(
                        Icons.check,
                        color: Colors.green,
                      ),
                      label: const Text(
                        'Confirmer',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ))
        ],
      ),
    );
  }

  _buildLoadingWidget() {
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
}
