class Item {
  final int id, price;
  final String title, description, image;

  Item({this.id, this.price, this.title, this.description, this.image});
}

// list of products
// for our demo
List<Item> items = [
  Item(
    id: 1,
    price: 210,
    title: "Fridays Caesar Salad",
    image: "assets/images/Item_1.jpg",
    description:
        "Romaine lettuce tossed with our Caesar dressing, topped with parmesan and garlic butter croutons.",
  ),
  Item(
    id: 2,
    price: 1000,
    title: "2 for 1 at Hugo's, Hyatt HK",
    image: "assets/images/Item_2.png",
    description:
        "Enjoy the enduring pleasure of Hugo’s, one of the most reputable restaurants in town. Originally opened in 1969 and reincarnated at Hyatt Regency Hong Kong, Tsim Sha Tsui, Hugo’s is where classic meets timeless.",
  ),
  Item(
    id: 3,
    price: 400,
    title: "Reusable Bamboo Lunch Box",
    image: "assets/images/Item_3.jpg",
    description:
        "This eco friendly lunchbox has a capacity of 700ml and is made from both natural bamboo and bamboo fibre, with an elastic band and food-grade silicone seal. The bamboo has naturally anti-bacterial properties and it's BPA-free.",
  ),
];
