import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:rezepte_moedling/models/recipe.dart';
import 'package:uuid/uuid.dart';

class RecipeForm extends StatefulWidget {
  const RecipeForm({ Key? key, this.initialRecipe }) : super(key: key);
  final Recipe? initialRecipe;


  @override
  _RecipeFormState createState() => _RecipeFormState();
}

class _RecipeFormState extends State<RecipeForm> {
final _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
    if (widget.initialRecipe != null) {
      loadFormData(widget.initialRecipe!);
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(16.0),
      child: FormBuilder(
        key: _formKey,
        child: SingleChildScrollView(child: Column(children: [
          FormBuilderTextField(name: "name",
          decoration: const InputDecoration(labelText: "Rezeptname"),
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(errorText: 'Bitte Rezeptnamen angeben'),
            FormBuilderValidators.minLength(3,errorText: "Bitte mindestens drei Zeichen angeben")
          ])
          ),
    
    FormBuilderTextField(name: "description",
          decoration: const InputDecoration(labelText: "Beschreibung"),
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(errorText: 'Bitte Beschreibung angeben'),
            FormBuilderValidators.minLength(5,errorText: "Bitte mindestens fünf Zeichen angeben")
          ])
          ),
    
    
          FormBuilderTextField(name: "ingredients",
          decoration: const InputDecoration(labelText: "Zutaten"),
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(errorText: 'Bitte Zutaten angeben'),
            FormBuilderValidators.minLength(5,errorText: "Bitte mindestens fünf Zeichen angeben")
          ])
          ),
    
          FormBuilderTextField(name: "imageURL",
          decoration: const InputDecoration(labelText: "Bild URL"),
          initialValue: 'https://via.placeholder.com/150',
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.url()
          ])
          ),

      const SizedBox(height:16),

          FormBuilderField(builder: (FormFieldState<double> field){
            return Column(crossAxisAlignment: CrossAxisAlignment.center, 
            children: [
              const Text("Rating"),
              RatingBar.builder(
                itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
                ),
                allowHalfRating: true,
                initialRating: field.value ?? 0.0,
                minRating: 0.0,
                direction: Axis.horizontal,
                itemCount: 5,
                itemSize: 30.0,
              // ignore: curly_braces_in_flow_control_structures, curly_braces_in_flow_control_structures, curly_braces_in_flow_control_structures
              onRatingUpdate: (rating){
                field.didChange(rating);
                if (field.hasError)
                  Text(
                      field.errorText!,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                        ),
                      );
                },
                ),
            ],);
          } , 
          validator: (value) {
            if (value == null || value == 0.0) {
            return 'Bitte geben Sie ein Rating an';
            }
            return null;
            },
          name: "rating"),

          const SizedBox(height:16),
          ElevatedButton(onPressed: (){
    
            if (_formKey.currentState!.saveAndValidate()) {
              _submitForm();
            }
    
          },child: const Text("Speichern"))
          ],)),),
    );
  
  }

  void _submitForm(){
  if (_formKey.currentState!.saveAndValidate()) {
    final newRecipe = Recipe(
    id: widget.initialRecipe?.id.toString() ?? const Uuid().v4(),
    name: _formKey.currentState!.fields['name']!.value.toString(), 
    description: _formKey.currentState!.fields['description']!.value.toString(),
    ingredients: _formKey.currentState!.fields['ingredients']!.value.toString(), 
    imageURL: _formKey.currentState!.fields['imageURL']!.value.toString(), 
    rating: _formKey.currentState!.fields['rating']!.value.toDouble(), 
    );
    Navigator.of(context).pop(newRecipe);
    }
  }

  void loadFormData(Recipe recipe){
  final formData = {
    'name': recipe.name,
    'description': recipe.description,
    'ingredients': recipe.ingredients,
    'imageURL': recipe.imageURL,
    'rating': recipe.rating,
  };

  _formKey.currentState!.reset();
  _formKey.currentState!.patchValue(formData);

  }

}