import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'model/app_state_model.dart';
import 'model/product.dart';
import 'styles.dart';

const double _kDateTimePickerHeight = 216; // NEW

class ShoppingCartTab extends StatefulWidget {
  const ShoppingCartTab({super.key});

  @override
  State<ShoppingCartTab> createState() {
    return _ShoppingCartTabState();
  }
}

class _ShoppingCartTabState extends State<ShoppingCartTab> {
  String? name;
  String? email;
  String? location;
  String? pin;
  DateTime dateTime = DateTime.now();
  final _currencyFormat = NumberFormat.currency(symbol: '\$');

  // Widget _buildNameField() {
  //   return CupertinoTextField(
  //     prefix: const Icon(
  //       CupertinoIcons.person_solid,
  //       color: CupertinoColors.lightBackgroundGray,
  //       size: 28,
  //     ),
  //     padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
  //     clearButtonMode: OverlayVisibilityMode.editing,
  //     textCapitalization: TextCapitalization.words,
  //     autocorrect: false,
  //     decoration: const BoxDecoration(
  //       border: Border(
  //         bottom: BorderSide(
  //           width: 0,
  //           color: CupertinoColors.inactiveGray,
  //         ),
  //       ),
  //     ),
  //     placeholder: 'Name',
  //     onChanged: (newName) {
  //       setState(() {
  //         name = newName;
  //       });
  //     },
  //   );
  // }

  // Widget _buildEmailField() {
  //   return const CupertinoTextField(
  //     prefix: Icon(
  //       CupertinoIcons.mail_solid,
  //       color: CupertinoColors.lightBackgroundGray,
  //       size: 28,
  //     ),
  //     padding: EdgeInsets.symmetric(horizontal: 6, vertical: 12),
  //     clearButtonMode: OverlayVisibilityMode.editing,
  //     keyboardType: TextInputType.emailAddress,
  //     autocorrect: false,
  //     decoration: BoxDecoration(
  //       border: Border(
  //         bottom: BorderSide(
  //           width: 0,
  //           color: CupertinoColors.inactiveGray,
  //         ),
  //       ),
  //     ),
  //     placeholder: 'Email',
  //   );
  // }

  // Widget _buildLocationField() {
  //   return const CupertinoTextField(
  //     prefix: Icon(
  //       CupertinoIcons.location_solid,
  //       color: CupertinoColors.lightBackgroundGray,
  //       size: 28,
  //     ),
  //     padding: EdgeInsets.symmetric(horizontal: 6, vertical: 12),
  //     clearButtonMode: OverlayVisibilityMode.editing,
  //     textCapitalization: TextCapitalization.words,
  //     decoration: BoxDecoration(
  //       border: Border(
  //         bottom: BorderSide(
  //           width: 0,
  //           color: CupertinoColors.inactiveGray,
  //         ),
  //       ),
  //     ),
  //     placeholder: 'Location',
  //   );
  // }

  SliverChildBuilderDelegate _buildSliverChildBuilderDelegate(
      AppStateModel model) {
    return SliverChildBuilderDelegate(
      (context, index) {
        final productIndex = index;
        switch (index) {
          // case 0:
          //   return Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 16),
          //     child: _buildNameField(),
          //   );
          // case 1:
          //   return Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 16),
          //     child: _buildEmailField(),
          //   );
          // case 2:
          //   return Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 16),
          //     child: _buildLocationField(),
          //   );
          // case 3:
          //   return Padding(
          //     padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          //     child: _buildDateAndTimePicker(context),
          //   );
          default:
            if (model.productsInCart.length > productIndex) {
              return ShoppingCartItem(
                index: index,
                product: model.getProductById(
                    model.productsInCart.keys.toList()[productIndex]),
                quantity: model.productsInCart.values.toList()[productIndex],
                lastItem: productIndex == model.productsInCart.length - 1,
                formatter: _currencyFormat,
              );
            } else if (model.productsInCart.keys.length == productIndex &&
                model.productsInCart.isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          'Shipping '
                          '${_currencyFormat.format(model.shippingCost)}',
                          style: Styles.productRowItemPrice,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Tax ${_currencyFormat.format(model.tax)}',
                          style: Styles.productRowItemPrice,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Total ${_currencyFormat.format(model.totalCost)}',
                          style: Styles.productRowTotal,
                        ),
                      ],
                    )
                  ],
                ),
              );
            }
        }
        return null;
      },
    );
  }

  Widget _buildDateAndTimePicker(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const <Widget>[
                Icon(
                  CupertinoIcons.clock,
                  color: CupertinoColors.lightBackgroundGray,
                  size: 28,
                ),
                SizedBox(width: 6),
                Text(
                  'Delivery time',
                  style: Styles.deliveryTimeLabel,
                ),
              ],
            ),
            Text(
              DateFormat.yMMMd().add_jm().format(dateTime),
              style: Styles.deliveryTime,
            ),
          ],
        ),
        SizedBox(
          height: _kDateTimePickerHeight,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.dateAndTime,
            initialDateTime: dateTime,
            onDateTimeChanged: (newDateTime) {
              setState(() {
                dateTime = newDateTime;
              });
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateModel>(
      builder: (context, model, child) {
        return CustomScrollView(
          slivers: <Widget>[
            const CupertinoSliverNavigationBar(
              largeTitle: Text('Shopping Cart'),
            ),
            SliverSafeArea(
              top: false,
              minimum: const EdgeInsets.only(top: 4),
              sliver: SliverList(
                delegate: _buildSliverChildBuilderDelegate(model),
              ),
            )
          ],
        );
      },
    );
  }
}

class ShoppingCartItem extends StatelessWidget {
  const ShoppingCartItem({
    required this.index,
    required this.product,
    required this.lastItem,
    required this.quantity,
    required this.formatter,
    super.key,
  });

  final Product product;
  final int index;
  final bool lastItem;
  final int quantity;
  final NumberFormat formatter;

  @override
  Widget build(BuildContext context) {
    final row = SafeArea(
      top: false,
      bottom: false,
      child: CupertinoListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Image.asset(
            product.assetName,
            package: product.assetPackage,
            fit: BoxFit.cover,
            width: 40,
            height: 40,
          ),
        ),
        leadingSize: 40,
        title: Text(
          product.name,
          style: Styles.productRowItemName,
        ),
        subtitle: Text(
          '${quantity > 1 ? '$quantity x ' : ''}'
          '${formatter.format(product.price)}',
          style: Styles.productRowItemPrice,
        ),
        trailing: Row(
          children: [
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                final model =
                    Provider.of<AppStateModel>(context, listen: false);
                model.removeItemFromCart(product.id);
              },
              child: const Icon(
                CupertinoIcons.minus_circled,
                semanticLabel: 'Remove',
              ),
            ),
            Text(
              '$quantity'
            ),
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                final model =
                    Provider.of<AppStateModel>(context, listen: false);
                model.addProductToCart(product.id);
              },
              child: const Icon(
                CupertinoIcons.plus_circled,
                semanticLabel: 'Add',
              ),
            ),
            Text(
              formatter.format(quantity * product.price),
              style: Styles.productRowItemName,
            ),
          ],
        ),
      ),
    );

    return row;
  }
}
