import 'package:flutter/material.dart';
import 'package:mtaa_frontend/core/constants/colors.dart';
import 'package:mtaa_frontend/features/images/data/models/responses/myImageGroupResponse.dart';
import 'package:mtaa_frontend/features/images/data/network/preset_avatar_images_api.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/dotLoader.dart';

class PresetImagesList extends StatefulWidget {
  final void Function(MyImageGroupResponse) onChanged;
  final PresetAvatarImagesApi presetAvatarImagesApi;

  PresetImagesList({super.key, required this.onChanged, required this.presetAvatarImagesApi});

  @override
  _PresetImagesListState createState() => _PresetImagesListState();
}

class _PresetImagesListState extends State<PresetImagesList> {
  bool isFirstTime = true;
  MyImageGroupResponse? selectedImage;
  List<MyImageGroupResponse> images = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    initialize();
  }

  Future<void> initialize() async {
    final fetchedImages = await widget.presetAvatarImagesApi.getAllPresetImages();
    if (mounted) {
      setState(() {
        images = fetchedImages;
        if (images.isNotEmpty) {
          selectedImage = images[0];
        }
        isLoading = false;
      });
      widget.onChanged(selectedImage!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: isLoading
            ? const DotLoader()
            : images.isEmpty
                ? const Text("No images available")
                : GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: images.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            selectedImage = images[index];
                          });
                          widget.onChanged(images[index]);
                        },
                        borderRadius: BorderRadius.circular(1000),
                        splashColor: primarily0InvincibleColor.withAlpha(50),
                        child: Ink(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(images[index].images.firstWhere((item) => item.width == 300, orElse: () => images[index].images.first).fullPath),
                              fit: BoxFit.cover,
                            ),
                            border: selectedImage == images[index] ? Border.all(color: secondary1InvincibleColor, width: 2) : null,
                            borderRadius: BorderRadius.circular(1000),
                          ),
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
