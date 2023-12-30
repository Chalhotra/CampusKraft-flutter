import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ig_clone/pages/product_card.dart';
import 'package:ig_clone/pages/product_details_page.dart';

// import 'global_variables.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();
  final List<String> filters = ['Adidas', 'Nike', 'Bata', 'Skechers'];
  late String selectedFilter;
  @override
  void initState() {
    super.initState();
    selectedFilter = filters[0];
  }

  final border = OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.black26,
    ),
    borderRadius: BorderRadius.all(
      Radius.circular(50),
    ),
  );
  final focusedBorder = OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.black26,
    ),
    borderRadius: BorderRadius.all(
      Radius.circular(50),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Opacity(
        opacity: 0.4,
        child: Container(
          height: double.infinity,
          width: double.infinity,
        ),
      ),
      Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            SafeArea(
              child: Align(
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text('Everyday\nServices',
                          style: Theme.of(context).textTheme.titleLarge),
                    ),
                    Spacer(),
                    SizedBox(
                      width: 200,
                      height: 50,
                      child: TextField(
                        controller: searchController,
                        onChanged: (value) {
                          setState(() {});
                        },
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                            bottom: -5,
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "Search",
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                          border: border,
                          prefixIcon: Icon(Icons.search),
                          enabledBorder: border,
                          focusedBorder: focusedBorder,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection('products')
                    .snapshots(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  final products = snapshot.data!.docs.where((product) {
                    final title = product['title'].toString().toLowerCase();
                    final searchQuery = searchController.text.toLowerCase();
                    return title.contains(searchQuery);
                  }).toList();
                  return Expanded(
                    child: (MediaQuery.of(context).size.width > 1080)
                        ? GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2, childAspectRatio: 1.75),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 30),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) {
                                        return ProductDetailsPage(
                                            product: products[index].data());
                                      },
                                    ));
                                  },
                                  child: ProductCard(
                                      index: index,
                                      title: products[index]['title'] as String,
                                      price: products[index]['price'] as int,
                                      image: products[index]['imageUrl']
                                          as String),
                                ),
                              );
                            },
                            itemCount: products.length,
                          )
                        : GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1, childAspectRatio: 1.2),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 30),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) {
                                        return ProductDetailsPage(
                                            product: products[index].data());
                                      },
                                    ));
                                  },
                                  child: ProductCard(
                                      index: index,
                                      title: products[index]['title'] as String,
                                      price: products[index]['price'] as int,
                                      image: products[index]['imageUrl']
                                          as String),
                                ),
                              );
                            },
                            itemCount: products.length,
                          ),
                  );
                }),
          ],
        ),
      )
    ]);
  }
}
