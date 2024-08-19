import 'package:exercies4/common/routes/app_route_name.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeDrawerWidget extends ConsumerWidget {
  const HomeDrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(child: Text('Bài 5 L1')),
          // ListTile(
          //   onTap: () {
          //     final List<ProductEntity> products = [
          //       ProductEntity(
          //           name: 'Shose Like',
          //           description: 'The shoes very beauty and nice',
          //           price: 100000,
          //           imageUrl: ImageRes.imgShoes1,
          //           category: ProductCategory.shoes),
          //       ProductEntity(
          //           name: 'Shose Ok Man',
          //           description: 'The shoes very end very and very',
          //           price: 400000,
          //           imageUrl: ImageRes.imgShoes2,
          //           category: ProductCategory.shoes),
          //       ProductEntity(
          //           name: 'Shose Bigger',
          //           description: 'The shoes not beauty and nice',
          //           price: 150000,
          //           imageUrl: ImageRes.imgShoes3,
          //           category: ProductCategory.shoes),
          //       ProductEntity(
          //           name: 'Shose Beauty',
          //           description: 'The shoes ungly but beauty and nice',
          //           price: 350000,
          //           imageUrl: ImageRes.imgShoes4,
          //           category: ProductCategory.shoes),
          //       ProductEntity(
          //           name: 'Clothes Man',
          //           description: 'The cothes very beauty and nice',
          //           price: 150000,
          //           imageUrl: ImageRes.imgClothes1,
          //           category: ProductCategory.clothes),
          //       ProductEntity(
          //           name: 'Clothes Woman',
          //           description: 'The cothes very beauty and nice',
          //           price: 250000,
          //           imageUrl: ImageRes.imgClothes2,
          //           category: ProductCategory.clothes),
          //       ProductEntity(
          //           name: 'Clothes Ok',
          //           description: 'The cothes very beauty and nice',
          //           price: 450000,
          //           imageUrl: ImageRes.imgClothes3,
          //           category: ProductCategory.clothes),
          //       ProductEntity(
          //           name: 'Clothes Beaty',
          //           description: 'The cothes very beauty and nice',
          //           price: 650000,
          //           imageUrl: ImageRes.imgClothes4,
          //           category: ProductCategory.clothes),
          //       ProductEntity(
          //           name: 'Book Like',
          //           description: 'The book very beauty and nice',
          //           price: 100000,
          //           imageUrl: ImageRes.imgBook1,
          //           category: ProductCategory.book),
          //       ProductEntity(
          //           name: 'Book Ok Man',
          //           description: 'The book very end very and very',
          //           price: 400000,
          //           imageUrl: ImageRes.imgBook2,
          //           category: ProductCategory.book),
          //       ProductEntity(
          //           name: 'Book Bigger',
          //           description: 'The book not beauty and nice',
          //           price: 150000,
          //           imageUrl: ImageRes.imgBook3,
          //           category: ProductCategory.book),
          //       ProductEntity(
          //           name: 'Book Beauty',
          //           description: 'The book ungly but beauty and nice',
          //           price: 350000,
          //           imageUrl: ImageRes.imgBook4,
          //           category: ProductCategory.book),
          //       ProductEntity(
          //           name: 'Light Man',
          //           description: 'The light very beauty and nice',
          //           price: 150000,
          //           imageUrl: ImageRes.imgLight1,
          //           category: ProductCategory.light),
          //       ProductEntity(
          //           name: 'Light Woman',
          //           description: 'The light very beauty and nice',
          //           price: 250000,
          //           imageUrl: ImageRes.imgLight2,
          //           category: ProductCategory.light),
          //       ProductEntity(
          //           name: 'Light Ok',
          //           description: 'The light very beauty and nice',
          //           price: 450000,
          //           imageUrl: ImageRes.imgLight3,
          //           category: ProductCategory.light),
          //       ProductEntity(
          //           name: 'Light Beaty',
          //           description: 'The light very beauty and nice',
          //           price: 650000,
          //           imageUrl: ImageRes.imgLight4,
          //           category: ProductCategory.light),
          //     ];
          //     CartRepos.uploadList(products);
          //   },
          //   trailing: const Icon(Icons.abc),
          //   title: const Text('Đẩy list product'),
          // ),
          ListTile(
            onTap: () {},
            trailing: const Icon(Icons.dangerous),
            title: const Text('Ok'),
          ),
          ListTile(
            onTap: () {},
            trailing: const Icon(Icons.e_mobiledata),
            title: const Text('TTT'),
          ),
          ListTile(
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.of(context).pushNamedAndRemoveUntil(
                AppRouteName.auth,
                (route) => false,
              );
            },
            trailing: const Icon(Icons.logout),
            title: const Text(
              'Logout',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
