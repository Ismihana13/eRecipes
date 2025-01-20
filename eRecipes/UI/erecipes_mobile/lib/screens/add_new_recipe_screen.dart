import 'package:flutter/material.dart';

class AddNewRecipeScreen extends StatefulWidget {
  const AddNewRecipeScreen({super.key});

  @override
  State<AddNewRecipeScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<AddNewRecipeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'eRecipes',
           style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          )
        ),
           backgroundColor: const Color.fromRGBO(1, 100, 34, 1),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(),
                Row(
                  children: [
                    Text(
                      'Dobro došli!',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(
                      Icons.person,
                      color: Colors.black,
                      size: 24,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
             const Text(
              'Dodajte novi recept',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xCC0D3E09),
              ),
            ),
            _buildFormForRecipe()
          ],
        ) ,
      ),
    );
  }
  Widget _buildFormForRecipe() {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _recipeNameController = TextEditingController();
  final TextEditingController _recipeDescriptionController = TextEditingController();
  final TextEditingController _preparationDescriptionController = TextEditingController();
  final TextEditingController _preparationTimeController = TextEditingController();

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Form(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(height: 20),
          // Naziv recepta
             Align(
            alignment: Alignment.centerLeft,
            child: const Text(
              'Naslov recepta', 
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
          ),
           TextFormField(
            controller: _recipeNameController,
            decoration: const InputDecoration(
              //labelText: 'Naziv recepta',  // Naziv recepta iznad inputa
              hintText: 'Unesite naziv recepta', // Hint tekst unutar inputa
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Unesite naziv recepta';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          // Opis recepta
          TextFormField(
            controller: _recipeDescriptionController,
            decoration: const InputDecoration(
              labelText: 'Opis recepta',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Unesite opis recepta';
              }
              return null;
            },
            maxLines: 4,
          ),
          const SizedBox(height: 20),
          // Opis pripreme
          TextFormField(
            controller: _preparationDescriptionController,
            decoration: const InputDecoration(
              labelText: 'Opis pripreme',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Unesite opis pripreme';
              }
              return null;
            },
            maxLines: 4,
          ),
          const SizedBox(height: 20),
          // Vrijeme pripreme
          TextFormField(
            controller: _preparationTimeController,
            decoration: const InputDecoration(
              labelText: 'Vrijeme pripreme (u minutama)',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Unesite vrijeme pripreme';
              }
              return null;
            },
          ),
          const SizedBox(height: 30),
          // Dugme za dodavanje recepta
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                // Podaci su validni, obraditi ih
                // Ovdje možeš sačuvati podatke recepta
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Recept je dodan!')),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: const Text('Dodaj recept'),
          ),
        ],
      ),
    ),
  );
}

}