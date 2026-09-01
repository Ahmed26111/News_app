enum CategoriesEnum{
  eBusiness(name: "Business"),
  eEntertainment(name: "Entertainment"),
  eGeneral(name: "General"),
  eHealth(name: "Health"),
  eScience(name: "Science"),
  eSports(name: "Sports"),
  eTechnology(name: "Technology");

  final String name;
  const CategoriesEnum({required this.name});
}
