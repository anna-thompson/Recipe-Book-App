import "package:english_words/english_words.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: "Recipe Book App",
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
              seedColor: Color.fromARGB(255, 24, 160, 233)),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var recipes = <Recipe>[Recipe(title: "Pancakes")];
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = RecipesPage();
        break;
      case 1:
        page = CategoriesPage();
        break;
      case 2:
        page = NewRecipePage();
        break;
      case 3:
        page = FavoritesPage();
        break;
      case 4:
        page = SettingsPage();
        break;
      default:
        throw UnimplementedError("no widget for $selectedIndex");
    }

    return Scaffold(
      body: page,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Recipes",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category_rounded),
            label: "Categories",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: "New",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favorites",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        backgroundColor: Colors.white, // Set the background color
        selectedItemColor: Theme.of(context)
            .colorScheme
            .primary, // Set the selected item color
        unselectedItemColor: Colors.grey, // Set the unselected item color
      ),
    );
  }
}

class Recipe {
  String title;
  //List<String> ingredients = [];
  //List<String> directions = [];

  Recipe({String title = "Untitled Recipe"}) : this.title = title;
}

class RecipeCard extends StatelessWidget {
  final Recipe recipe;

  RecipeCard({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

class RecipesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Recipes"),
      ),
      body: _buildRecipeList(appState.recipes),
    );
  }

  Widget _buildRecipeList(List<Recipe> recipes) {
    if (recipes.isEmpty) {
      return Center(
        child: Text("My Recipes"),
      );
    }

    return ListView();
  }
}

class CategoriesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories"),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text("Breakfast"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CategoryDetailPage("Breakfast"),
                ),
              );
            },
          ),
          // Add more ListTiles for other categories as needed
        ],
      ),
    );
  }
}

class CategoryDetailPage extends StatelessWidget {
  final String categoryName;

  CategoryDetailPage(this.categoryName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
      ),
      body: Center(
        child: Text("Details for $categoryName"),
      ),
    );
  }
}

class NewRecipePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //var appState = context.watch<MyAppState>();
    return Scaffold(
      appBar: AppBar(
        title: Text("New Recipe"),
      ),
      body: Center(
        child: Text("New Recipe"),
      ),
    );
  }
}

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //var appState = context.watch<MyAppState>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorites"),
      ),
      body: Center(
        child: Text("You haven't saved any recipes to your favorites yet."),
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //var appState = context.watch<MyAppState>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Center(
        child: Text("Settings"),
      ),
    );
  }
}
