import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  List products = [];
  List categories = [];
  bool isLoading = true;

  // Icon mapping for categories
  final Map<String, IconData> categoryIcons = {
    // General
    "category": Icons.category,
    "favorite": Icons.favorite,
    "home": Icons.home,
    "star": Icons.star,
    "settings": Icons.settings,
    "info": Icons.info,
    "help": Icons.help_outline,
    "warning": Icons.warning,
    "check": Icons.check_circle,
    "cancel": Icons.cancel,
    "delete": Icons.delete,
    "edit": Icons.edit,
    "search": Icons.search,
    "lock": Icons.lock,
    "unlock": Icons.lock_open,
    "visibility": Icons.visibility,
    "visibility_off": Icons.visibility_off,
    "account": Icons.account_circle,
    "people": Icons.people,
    "person": Icons.person,
    "add_person": Icons.person_add,
    "remove_person": Icons.person_remove,

    // Shopping & E-commerce
    "shopping_cart": Icons.shopping_cart,
    "shopping_bag": Icons.shopping_bag,
    "store": Icons.store,
    "sell": Icons.sell,
    "wallet": Icons.account_balance_wallet,
    "price_tag": Icons.local_offer,
    "credit_card": Icons.credit_card,
    "money": Icons.attach_money,
    "payments": Icons.payments,
    "gift": Icons.card_giftcard,

    // Technology & Electronics
    "phone_android": Icons.phone_android,
    "smartphone": Icons.smartphone,
    "tablet": Icons.tablet,
    "laptop": Icons.laptop,
    "desktop": Icons.desktop_windows,
    "tv": Icons.tv,
    "watch": Icons.watch,
    "camera": Icons.camera_alt,
    "headphones": Icons.headphones,
    "keyboard": Icons.keyboard,
    "mouse": Icons.mouse,
    "router": Icons.router,
    "gamepad": Icons.sports_esports,
    "speaker": Icons.speaker,
    "electronics": Icons.electrical_services,

    // Food & Drink
    "food": Icons.restaurant,
    "fastfood": Icons.fastfood,
    "drink": Icons.local_drink,
    "coffee": Icons.local_cafe,
    "bar": Icons.local_bar,
    "bakery": Icons.bakery_dining,
    "pizza": Icons.local_pizza,
    "ice_cream": Icons.icecream,
    "wine": Icons.wine_bar,
    "grocery": Icons.local_grocery_store,

    // Travel & Transportation
    "flight": Icons.flight,
    "hotel": Icons.hotel,
    "beach": Icons.beach_access,
    "map": Icons.map,
    "navigation": Icons.navigation,
    "car": Icons.directions_car,
    "bike": Icons.directions_bike,
    "bus": Icons.directions_bus,
    "train": Icons.train,
    "boat": Icons.directions_boat,
    "taxi": Icons.local_taxi,
    "traffic": Icons.traffic,

    // Sports & Fitness
    "sports": Icons.sports,
    "fitness": Icons.fitness_center,
    "gym": Icons.sports_gymnastics,
    "football": Icons.sports_football,
    "basketball": Icons.sports_basketball,
    "tennis": Icons.sports_tennis,
    "golf": Icons.sports_golf,
    "cricket": Icons.sports_cricket,
    "volleyball": Icons.sports_volleyball,
    "running": Icons.directions_run,
    "swimming": Icons.pool,

    // Entertainment
    "music": Icons.music_note,
    "movie": Icons.movie,
    "theater": Icons.theaters,
    "book": Icons.book,
    "news": Icons.article,
    "games": Icons.games,
    "concert": Icons.mic,
    "live_tv": Icons.live_tv,

    // Lifestyle & Fashion
    "clothes": Icons.checkroom,
    "shoe": Icons.shopping_bag,
    "beauty": Icons.brush,
    "makeup": Icons.face,
    "jewelry": Icons.diamond,
    "bag": Icons.work,

    // Kids & Family
    "baby": Icons.child_friendly,
    "toys": Icons.toys,
    "school": Icons.school,
    "education": Icons.menu_book,

    // Health & Medical
    "health": Icons.local_hospital,
    "medicine": Icons.medical_services,
    "doctor": Icons.person,
    "healing": Icons.healing,
    "fitness_watch": Icons.watch,

    // Nature & Outdoors
    "garden": Icons.grass,
    "tree": Icons.park,
    "flower": Icons.local_florist,
    "pet": Icons.pets,
    "sun": Icons.wb_sunny,
    "weather": Icons.cloud,

    // Office & Work
    "office": Icons.work,
    "briefcase": Icons.work_outline,
    "meeting": Icons.meeting_room,
    "computer": Icons.computer,
    "print": Icons.print,
    "folder": Icons.folder,
    "document": Icons.description,

    // Communication
    "email": Icons.email,
    "chat": Icons.chat,
    "call": Icons.call,
    "sms": Icons.sms,
    "video_call": Icons.videocam,

    // Transport & Delivery
    "delivery": Icons.delivery_dining,
    "package": Icons.local_shipping,
    "truck": Icons.fire_truck,

    // Others
    "tools": Icons.build,
    "security": Icons.security,
    "cloud": Icons.cloud,
    "download": Icons.download,
    "upload": Icons.upload,
    "qr_code": Icons.qr_code,
    "barcode": Icons.qr_code_scanner,
    "alarm": Icons.alarm,
    "timer": Icons.timer,
    "calendar": Icons.calendar_today,
    "event": Icons.event,
  };

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });
    await Future.wait([fetchProducts(), fetchCategories()]);
    setState(() {
      isLoading = false;
    });
  }

  Future<void> fetchProducts() async {
    final url = Uri.parse('http://10.120.44.75:8000/api/products/');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        products = json.decode(response.body);
      });
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Failed to load products')));
    }
  }

  Future<void> fetchCategories() async {
    final url = Uri.parse('http://10.120.44.75:8000/api/categories/');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        categories = json.decode(response.body);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: fetchData,
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    buildSearchBar(),
                    const SizedBox(height: 16),
                    buildSpecialOffers(),
                    const SizedBox(height: 16),
                    const Text(
                      'Categories',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    buildCategoriesWidget(),
                    const SizedBox(height: 16),
                    const Text(
                      'Top Selling',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    buildProductGrid(),
                  ],
                ),
              ),
      ),
    );
  }

  /// Search Bar
  Widget buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search products...',
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  /// Special Offers Carousel
  Widget buildSpecialOffers() {
    final specialOffers = products
        .where((p) => p['is_special_offer'] == true)
        .toList();
    if (specialOffers.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: 180,
      child: Swiper(
        autoplay: true,
        viewportFraction: 0.9,
        scale: 0.95,
        itemCount: specialOffers.length,
        itemBuilder: (context, index) {
          final product = specialOffers[index];
          final imageUrl = product['image'].replaceAll(
            '127.0.0.1',
            '10.120.44.75',
          );

          return ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              fit: StackFit.expand,
              children: [
                CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                Container(
                  color: Colors.black26,
                  padding: const EdgeInsets.all(8),
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    product['name'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// Categories List
  Widget buildCategoriesWidget() {
    if (categories.isEmpty) {
      return const Center(child: Text('No categories found'));
    }

    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return Container(
            width: 80,
            margin: const EdgeInsets.only(right: 10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 5),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  categoryIcons[category['icon']] ?? Icons.category,
                  size: 28,
                  color: Colors.orange,
                ),
                const SizedBox(height: 4),
                Text(
                  category['name'],
                  style: const TextStyle(fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// Product Grid
  Widget buildProductGrid() {
    if (products.isEmpty) {
      return const Center(child: Text('No products found'));
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.65,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        final imageUrl = product['image'].replaceAll(
          '127.0.0.1',
          '10.120.44.75',
        );

        return buildProductCard(product, imageUrl);
      },
    );
  }

  /// Single Product Card
  Widget buildProductCard(dynamic product, String imageUrl) {
    return GestureDetector(
      onTap: () {
        // Navigate to product details page if needed
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.broken_image, size: 40),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['name'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${product['price']}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                '${product['name']} added to cart!',
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.add_shopping_cart,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
