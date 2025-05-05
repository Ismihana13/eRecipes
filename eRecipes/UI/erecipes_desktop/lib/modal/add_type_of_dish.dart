import 'package:erecipes_desktop/providers/vrsta_jela_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddTypeDishScreen extends StatefulWidget {
  const AddTypeDishScreen({super.key});

  @override
  _AddTypeDishScreenState createState() => _AddTypeDishScreenState();
}

class _AddTypeDishScreenState extends State<AddTypeDishScreen> {
  TextEditingController _typeDishController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late VrstaJelaProvider provider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    provider = Provider.of<VrstaJelaProvider>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      child: Container(
        width: 300, 
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _typeDishController,
                decoration: const InputDecoration(
                  labelText: 'Type of dish Name',
                  hintText: 'Enter type of dish name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Type of dish name is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        String typeOfDishName = _typeDishController.text;
                        var request = {'naziv': typeOfDishName};
                        await provider.insert(request);
                        Navigator.pop(context, typeOfDishName);
                      }
                    },
                    child: const Text('Add'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}