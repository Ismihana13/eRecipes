import 'package:erecipes_mobile/layouts/master_screen.dart';
import 'package:erecipes_mobile/models/like.dart';
import 'package:erecipes_mobile/providers/like_provider.dart';
import 'package:erecipes_mobile/providers/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class LikeScreen extends StatefulWidget {
  static const String routeName = "/like";

   const LikeScreen({Key? key}) : super(key: key);

  @override
  State<LikeScreen> createState() => _LikeScreenState();
}

class _LikeScreenState extends State<LikeScreen> {
  late LikeProvider _likeProvider;

    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _likeProvider = context.watch<LikeProvider>();
  }

 @override
  Widget build(BuildContext context) {
    return MasterScreen("Like",
         Column(
          children: [
           Expanded( child: _buildRecipeCardList()),
           // _buildBuyButton()
          ],
        ),
      );
  }
  
  Widget _buildRecipeCardList() {
      return Container(
          child: ListView.builder(
            itemCount:_likeProvider?.like.items.length,
            itemBuilder: (context, index) {
              print("rendering element");
              return _buildRecipeCart(_likeProvider.like.items[index]);
            },
            )
      );
  }

  ListTile _buildRecipeCart(LikeItem item) {
    return ListTile(
      leading: item.recept.slika==null ? Placeholder(): imageFromString(item.recept.slika!),
      title: Text(item.recept.naziv ?? " "),
      subtitle: Text(item.recept.opisRecepta ?? ""),
      trailing: Text(item.count.toString()),
    );
  }
  

}