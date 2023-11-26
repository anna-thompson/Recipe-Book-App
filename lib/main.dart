import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import "package:provider/provider.dart";
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

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
        debugShowCheckedModeBanner: false,
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
  var recipes = <Recipe>[
    Recipe(
        name: "Pancakes",
        description: "So light and fluffy!",
        imageLink:
            "https://images.unsplash.com/photo-1565299543923-37dd37887442?q=80&w=1981&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
    Recipe(name: "Ravioli", description: "Prep veggies before starting the ravioli.", imageLink: "https://images.unsplash.com/photo-1587740908075-9e245070dfaa?q=80&w=1935&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
    Recipe(name: "Spaghetti", imageLink: "https://plus.unsplash.com/premium_photo-1664472682525-0c0b50534850?q=80&w=1780&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
    Recipe(name: "Grilled Chicken", imageLink: "https://images.unsplash.com/photo-1598515214211-89d3c73ae83b?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
    Recipe(name: "Pizza", description: "Pizza!", imageLink: "https://images.unsplash.com/photo-1593560708920-61dd98c46a4e?q=80&w=1935&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
  ];

  void addRecipe(Recipe recipe) {
    recipes.add(recipe);
    notifyListeners();
  }

  void deleteRecipe(Recipe recipe) {
    recipes.remove(recipe);
    notifyListeners();
  }
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
  String name;
  String description;
  String imageLink;

  Recipe(
      {String name = "Untitled Recipe",
      String description = "",
      String imageLink =
          "https://images.unsplash.com/photo-1615799998603-7c6270a45196?q=80&w=1904&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"})
      : this.name = name,
        this.description = description,
        this.imageLink = imageLink;
}

class RecipeCard extends StatelessWidget {
  final Recipe recipe;

  RecipeCard({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 6,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RecipeDetailsPage(recipe),
            ),
          );
        },
        child: Container(
          height: 150,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
              image: NetworkImage(recipe.imageLink),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                recipe.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white,
                  shadows: <Shadow>[
                    Shadow(
                      offset: Offset(1, 1),
                      blurRadius: 7.0,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
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
      body: _buildRecipeGrid(appState.recipes),
    );
  }

  Widget _buildRecipeGrid(List<Recipe> recipes) {
    if (recipes.isEmpty) {
      return Center(
        child: Text("My Recipes"),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio:
              0.8, // Adjust the aspect ratio to make the cards longer vertically
        ),
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          return RecipeCard(recipe: recipes[index]);
        },
      ),
    );
  }
}

class RecipeDetailsPage extends StatelessWidget {
  final Recipe recipe;

  RecipeDetailsPage(this.recipe);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SlidingUpPanel( 
        minHeight: (size.height / 2),
        maxHeight: (size.height / 1.2),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        parallaxEnabled: true,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                height: (size.height / 2) + 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(recipe.imageLink),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 40,
                left: 20,
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    CupertinoIcons.back,
                    color: Colors.white,
                    size: 38,
                  ),
                ),
              ),
            ],
          ),
        ),
        panel: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: 5,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                recipe.name,
                style: TextStyle(
                  fontSize: 25,
                  //color: Colors.black.withOpacity(0.5),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                recipe.description,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*class RecipeDetailsPage extends StatefulWidget {
  final Recipe recipe;

  RecipeDetailsPage(this.recipe);

  @override
  State<RecipeDetailsPage> createState() => _RecipeDetailsPageState();
}

class _RecipeDetailsPageState extends State<RecipeDetailsPage> {
  File? _imageFile;

  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
          //widget.recipe.imagePath = pickedFile.path;
        });
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: _imageFile != null ? 300.0 : 0,
            floating: false,
            pinned: true,
            flexibleSpace: Stack(
              children: [
                // Background Image
                if (_imageFile != null)
                  Image.file(
                    _imageFile!,
                    height: 300.0,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                // Popup Menu Button
                Positioned(
                  top: 6,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      PopupMenuButton<String>(
                        onSelected: handleClick,
                        itemBuilder: (BuildContext context) {
                          return {
                            "Edit",
                            "Delete Recipe"
                          }.map((String choice) {
                            return PopupMenuItem<String>(
                              value: choice,
                              child: Text(choice),
                            );
                          }).toList();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              // Recipe Title
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.recipe.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              // Recipe Description
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.recipe.description,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              // Other recipe details can be displayed here
            ]),
          ),
        ],
      ),
    );
  }
  
  void handleClick(String value) async {
    switch (value) {
      case "Edit":
        break;
      case "Delete Recipe":
        _deleteRecipe();
        break;
    }
  }

  void _deleteRecipe() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Are you sure?"),
          content: Text("This action will permanently delete the recipe."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                _performDelete(); // Perform the actual delete
              },
              child: Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  void _performDelete() {
  var appState = context.read<MyAppState>();

  appState.deleteRecipe(widget.recipe);
  Navigator.pop(context); // Navigate back to the previous screen
  }
} */

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
